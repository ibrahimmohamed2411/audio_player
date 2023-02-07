import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> showLoadingDialog([String? message]) {
  return showDialog(
    context: StackedService.navigatorKey!.currentContext!,
    builder: (context) => AlertDialog(
      content: SizedBox(
        child: CircularProgressIndicator(),
      ),
    ),
  );
}

void dismissLoadingDialog() {
  return Navigator.of(StackedService.navigatorKey!.currentContext!).pop();
}
