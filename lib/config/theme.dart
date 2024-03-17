import 'package:flutter/material.dart';

mixin ThemeProject {
  static final theme = ThemeData(
    primaryColor: Colors.pinkAccent,
    scaffoldBackgroundColor: Colors.grey[850],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.pinkAccent,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.pinkAccent,
      unselectedItemColor: Colors.white54,
      selectedItemColor: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: Colors.pinkAccent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.pinkAccent.withAlpha(140),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.pinkAccent,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.pinkAccent,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    ),
  );
}