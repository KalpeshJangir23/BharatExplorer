import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_show_planner/core/config/theme/appTheme.dart';
import 'package:trip_show_planner/screens/HomeScreen/homeScreen.dart';
import 'package:trip_show_planner/screens/bottom_nav.dart';
import 'package:trip_show_planner/screens/enter_splash_Screen/spash.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Show Planner',
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
