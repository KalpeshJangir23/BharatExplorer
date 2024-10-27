import 'package:flutter/material.dart';
import 'package:trip_show_planner/core/config/theme/appTheme.dart';
import 'package:trip_show_planner/screens/momument_display.dart/booking.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Show Planner',
      theme: AppTheme.darkTheme,
      home: const BookingPage(),
    );
  }
}
