import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppLoading{
  static Future loading(Function action, {bool dismiss = true}) async {
    if (!EasyLoading.isShow) {
      // _print('show loading in loading process...');
      await EasyLoading.show();
    }

    var result;
    try {
      result = await action.call();
    } catch (e) {
      print(e.toString());
    }

    if (EasyLoading.isShow && dismiss) {
      // _print('dismiss loading in loading process...');
      await EasyLoading.dismiss();
    }

    return result;
  }

  static void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
      // ..customAnimation = CustomAnimation();
  }
}