import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../../features/home/domain/entities/position_data.dart';

@lazySingleton
class AudioPlayerService {
  final AudioPlayer audioPlayer;
  AudioPlayerService({
    required this.audioPlayer,
  });
  Future<void> play() async {
    await audioPlayer.play();
  }

  Future<void> pause() async {
    await audioPlayer.pause();
  }

  Future<void> stop() async {
    await audioPlayer.stop();
  }

  Future<void> seekToNext() async {
    await audioPlayer.seekToNext();
  }

  Future<void> seekToPrevious() async {
    await audioPlayer.seekToPrevious();
  }

  Future<void> setLoopMode(LoopMode loopMode) async {
    await audioPlayer.setLoopMode(loopMode);
  }

  Future<void> setAudioSource(AudioSource audioSource,
      {int? initialIndex}) async {
    await audioPlayer.setAudioSource(audioSource, initialIndex: initialIndex);
  }

  Future<void> setShuffleModeEnabled(bool enabled) async {
    await audioPlayer.setShuffleModeEnabled(enabled);
  }

  Future<void> setVolume(double volume) async {
    await audioPlayer.setVolume(volume);
  }

  Future<void> seek(Duration position) async {
    await audioPlayer.seek(position);
  }

  Future<void> setSpeed(double speed) async {
    await audioPlayer.setSpeed(speed);
  }

  Stream<PositionData> get positionDataStream => Rx.combineLatest3(
        audioPlayer.positionStream,
        audioPlayer.bufferedPositionStream,
        audioPlayer.durationStream,
        (position, buffered, duration) => PositionData(
          position: position,
          bufferedPosition: buffered,
          duration: duration ?? Duration.zero,
        ),
      );

  int? get currentAudioIndex => audioPlayer.currentIndex;
  Stream<SequenceState?> get sequenceStateStream =>
      audioPlayer.sequenceStateStream;
  Stream<PlayerState?> get playerStateStream => audioPlayer.playerStateStream;

  Stream<bool?> playingStateStream() {
    return audioPlayer.playingStream;
  }

  Stream<int?> currentAudioIndexStream() {
    return audioPlayer.currentIndexStream;
  }
}
