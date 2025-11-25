import 'package:flutter/material.dart';
import 'package:base_project/core/di/injection.dart' as di;
import 'package:base_project/core/navigation/page_route.dart';

import 'core/config/app_properties.dart';

Future<void> mainCommon(AppProperties config) async {
  AppProperties.instance = config;

  WidgetsFlutterBinding.ensureInitialized();

  di.init(); // Initialize dependencies
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Base',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
