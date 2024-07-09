import 'package:flutter/material.dart';
import 'package:todo/shared/styles/colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: mint,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false));
  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Color(0xFF141922),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          backgroundColor: Color(0xFF141922),
          showSelectedLabels: false,
          showUnselectedLabels: false));
}
