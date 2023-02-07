import 'package:dartz/dartz.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../core/error/failures.dart';

abstract class SongsRepository {
  Future<Either<Failure, List<SongModel>>> getSongs();
}
