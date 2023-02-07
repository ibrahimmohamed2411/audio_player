import '../../../../core/error/failures.dart';
import '../datasources/songs_local_data_source.dart';
import '../../domain/repositories/songs_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:on_audio_query/on_audio_query.dart';

@LazySingleton(as: SongsRepository)
class SongsRepositoryImp implements SongsRepository {
  final SongsLocalDataSource songsLocalDataSource;
  SongsRepositoryImp({required this.songsLocalDataSource});

  @override
  Future<Either<Failure, List<SongModel>>> getSongs() async {
    try {
      final songs = await songsLocalDataSource.getSongs();
      return Right(songs);
    } on Exception catch (e) {
      return Left(CacheFailure(msg: e.toString()));
    }
  }
}
