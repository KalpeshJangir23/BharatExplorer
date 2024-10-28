import 'package:flutter/material.dart';
import 'package:trip_show_planner/core/config/theme/appColor.dart';

class AppTheme {
  static final darkTheme = ThemeData(
      primaryColor: Appcolor.primary,
      scaffoldBackgroundColor: Appcolor.darkBackground,
      brightness: Brightness.dark,
      fontFamily: 'Satoshi',
      sliderTheme: SliderThemeData(
          overlayShape: SliderComponentShape.noOverlay,
          activeTrackColor: const Color(0xffB7B7B7),
          inactiveTrackColor: Colors.grey.withOpacity(0.3),
          thumbColor: const Color(0xffB7B7B7)),
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.transparent,
          hintStyle: const TextStyle(
            color: Color(0xffA7A7A7),
            fontWeight: FontWeight.w500,
          ),
          contentPadding: const EdgeInsets.all(30),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.white, width: 0.4)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.white, width: 0.4))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: Appcolor.primary,
              elevation: 0,
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)))));
}
