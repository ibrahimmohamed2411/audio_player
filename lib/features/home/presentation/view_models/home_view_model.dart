import 'dart:async';
import '../../../../core/services/audio_player_service.dart';
import '../../../../core/state_management/view_state.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/entities/position_data.dart';
import '../../domain/repositories/songs_repository.dart';

@injectable
class HomeViewModel extends ChangeNotifier {
  final SongsRepository songsRepository;
  final AudioPlayerService audioPlayerService;
  HomeViewModel({
    required this.songsRepository,
    required this.audioPlayerService,
  });
  ViewState songsViewState = ViewState.initial;
  List<SongModel> _songs = [];
  List<SongModel> get songs => _songs;
  String errorMsg = '';
  SongModel? _currentSong;
  SongModel? get currentSong => _currentSong;

  final MiniplayerController controller = MiniplayerController();

  Future<void> getSongs() async {
    songsViewState = ViewState.loading;
    notifyListeners();
    final successOrFailure = await songsRepository.getSongs();
    successOrFailure.fold(
      (failure) {
        songsViewState = ViewState.error;
        errorMsg = failure.msg;
      },
      (songs) {
        songsViewState = ViewState.success;
        _songs = songs;
      },
    );
    notifyListeners();
  }

  Future<void> play(int initialIndex) async {
    List<UriAudioSource> playList = [];
    for (int i = 0; i < _songs.length; i++) {
      playList.add(
        AudioSource.uri(
          Uri.parse(_songs[i].uri!),
          tag: MediaItem(
            id: i.toString(),
            title: _songs[i].displayName,
          ),
        ),
      );
    }

    audioPlayerService
      ..setLoopMode(LoopMode.all)
      ..setAudioSource(
        ConcatenatingAudioSource(
          children: playList,
          useLazyPreparation: true,
        ),
        initialIndex: initialIndex,
      )
      ..play();
    _currentSong = _songs[initialIndex];
    notifyListeners();
  }

  Future<void> nextSong() async {
    await audioPlayerService.seekToNext();
    _currentSong = _songs[audioPlayerService.currentAudioIndex!];
    notifyListeners();
  }

  Future<void> previousSong() async {
    await audioPlayerService.seekToPrevious();
    _currentSong = _songs[audioPlayerService.currentAudioIndex!];
    notifyListeners();
  }

  closePlayer() {
    audioPlayerService.stop();
    _currentSong = null;
    notifyListeners();
  }

  Future<void> playAudio() async {
    await audioPlayerService.play();
  }

  Future<void> pauseAudio() async {
    await audioPlayerService.pause();
  }

  Future<void> seek(Duration position) async {
    await audioPlayerService.seek(position);
  }

  Stream<SequenceState?> get sequenceStateStream =>
      audioPlayerService.sequenceStateStream;

  Stream<PlayerState?> get playerStateStream {
    return audioPlayerService.playerStateStream;
  }

  Stream<PositionData> get positionDataStream =>
      audioPlayerService.positionDataStream;

  Stream<bool?> get playingStateStream =>
      audioPlayerService.playingStateStream();

  Stream<void> currentAudioSongStream() {
    audioPlayerService.currentAudioIndexStream().listen((index) {
      if (index != null) {
        _currentSong = _songs[index];
        notifyListeners();
      }
    });
    return Stream.empty();
  }
}
