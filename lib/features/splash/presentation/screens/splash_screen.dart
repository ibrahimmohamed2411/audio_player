import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../locator/locator.dart';
import '../view_models/splash_view_model.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StartupViewModel>(
      create: (context) => locator()..handleStartupLogic(),
      child: Consumer<StartupViewModel>(
        builder: (context, value, child) => Scaffold(
          body: Center(
            child: Image.asset(
              AssetManager.app_icon,
              width: 200.w,
              height: 200.h,
            ),
          ),
        ),
      ),
    );
  }
}
