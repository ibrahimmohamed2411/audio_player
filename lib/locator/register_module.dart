import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

@module
abstract class RegisterModule {
  

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker();

  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  LogInterceptor get logInterceptor => LogInterceptor();
  
  @singleton
  NavigationService get navigationService => NavigationService();

  @singleton
  DialogService get dialogService => DialogService();
  @singleton
  OnAudioQuery get audioQuery => OnAudioQuery();
  
  @singleton
  AudioPlayer get audioPlayer => AudioPlayer();

  @singleton
  BottomSheetService get bottomSheetService => BottomSheetService();
}
