import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/router/app_router.dart';
import 'config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:stacked_services/stacked_services.dart';
import 'core/services/snack_bar_service.dart';
import 'generated/l10n.dart';
import 'locator/locator.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  await configureDependencies();
  runApp(AudioPlayerApp());
}

class AudioPlayerApp extends StatelessWidget {
  const AudioPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        onGenerateTitle: (context) => S.of(context).app_title,
        theme: appTheme(),
        scaffoldMessengerKey: locator<SnackBarService>().key,
        navigatorKey: StackedService.navigatorKey,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        onGenerateRoute: AppRouter().onGenerateRoute,
      ),
    );
  }
}
