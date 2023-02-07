import '../../../../config/router/routes.dart';
import '../../../../locator/locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
@injectable
class StartupViewModel extends ChangeNotifier {
  final _navigationService = locator<NavigationService>();
  Future<void> handleStartupLogic() async {
    Future.delayed(Duration(seconds: 3), () {
      _navigationService.replaceWith(Routes.home);
    });
  }
}
