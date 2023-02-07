// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:audioplayer/core/api/api_consumer.dart' as _i18;
import 'package:audioplayer/core/api/app_interceptors.dart' as _i3;
import 'package:audioplayer/core/api/dio_consumer.dart' as _i19;
import 'package:audioplayer/core/network/network_info.dart' as _i9;
import 'package:audioplayer/core/services/audio_player_service.dart' as _i5;
import 'package:audioplayer/core/services/snack_bar_service.dart' as _i13;
import 'package:audioplayer/features/home/data/datasources/songs_local_data_source.dart'
    as _i14;
import 'package:audioplayer/features/home/data/repositories/songs_repository.dart'
    as _i16;
import 'package:audioplayer/features/home/domain/repositories/songs_repository.dart'
    as _i15;
import 'package:audioplayer/features/home/presentation/view_models/home_view_model.dart'
    as _i20;
import 'package:audioplayer/features/splash/presentation/view_models/splash_view_model.dart'
    as _i17;
import 'package:data_connection_checker_tv/data_connection_checker.dart'
    as _i10;
import 'package:dio/dio.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i8;
import 'package:just_audio/just_audio.dart' as _i4;
import 'package:on_audio_query/on_audio_query.dart' as _i11;
import 'package:shared_preferences/shared_preferences.dart' as _i12;
import 'package:stacked_services/stacked_services.dart' as _i6;

import 'register_module.dart' as _i21;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
Future<_i1.GetIt> $initLocator(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AppInterceptors>(() => _i3.AppInterceptors());
  gh.singleton<_i4.AudioPlayer>(registerModule.audioPlayer);
  gh.lazySingleton<_i5.AudioPlayerService>(
      () => _i5.AudioPlayerService(audioPlayer: gh<_i4.AudioPlayer>()));
  gh.singleton<_i6.BottomSheetService>(registerModule.bottomSheetService);
  gh.singleton<_i6.DialogService>(registerModule.dialogService);
  gh.lazySingleton<_i7.Dio>(() => registerModule.dio);
  gh.lazySingleton<_i8.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.lazySingleton<_i7.LogInterceptor>(() => registerModule.logInterceptor);
  gh.singleton<_i6.NavigationService>(registerModule.navigationService);
  gh.lazySingleton<_i9.NetworkInfo>(() => _i9.NetworkInfoImp(
      dataConnectionChecker: gh<_i10.DataConnectionChecker>()));
  gh.singleton<_i11.OnAudioQuery>(registerModule.audioQuery);
  await gh.factoryAsync<_i12.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.lazySingleton<_i13.SnackBarService>(() => _i13.SnackBarService());
  gh.lazySingleton<_i14.SongsLocalDataSource>(
      () => _i14.SongsLocalDataSource(query: gh<_i11.OnAudioQuery>()));
  gh.lazySingleton<_i15.SongsRepository>(() => _i16.SongsRepositoryImp(
      songsLocalDataSource: gh<_i14.SongsLocalDataSource>()));
  gh.factory<_i17.StartupViewModel>(() => _i17.StartupViewModel());
  gh.lazySingleton<_i18.ApiConsumer>(
      () => _i19.DioConsumer(client: gh<_i7.Dio>()));
  gh.factory<_i20.HomeViewModel>(() => _i20.HomeViewModel(
        songsRepository: gh<_i15.SongsRepository>(),
        audioPlayerService: gh<_i5.AudioPlayerService>(),
      ));
  return getIt;
}

class _$RegisterModule extends _i21.RegisterModule {}
