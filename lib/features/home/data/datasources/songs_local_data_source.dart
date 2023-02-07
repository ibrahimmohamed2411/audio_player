import 'package:injectable/injectable.dart';
import 'package:on_audio_query/on_audio_query.dart';

@lazySingleton
class SongsLocalDataSource {
  final OnAudioQuery query;
  SongsLocalDataSource({required this.query});
  Future<bool> requireStoragePermission() async {
    bool permissionStatus = await query.permissionsStatus();
    if (!permissionStatus) {
      return query.permissionsRequest();
    }
    return true;
  }

  Future<List<SongModel>> getSongs() async {
    bool permissionStatus = await requireStoragePermission();
    if (permissionStatus) {
      final songs = await query.querySongs();
      return songs;
    }
    throw Exception('Permission not granted');
  }
}
