// Entry point for development in Vietnam.
//
// Used with vietnam build flavor like example:
// `flutter build apk --flavor vnTest --target lib/main_vn_dev.dart`

import 'dart:async';

import 'core/config/app_properties.dart';
import 'main.dart';

void main() => runZonedGuarded(
      () async => await mainCommon(const AppProperties(
          apSrvURL: 'https://dummyjson.com', mode: AppMode.IT_TEST)),
      (error, stack) => () {
        print("------runZonedGuarded--------"
            "${error.toString()}");
      },
    );
