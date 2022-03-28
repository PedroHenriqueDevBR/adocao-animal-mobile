import 'package:flutter/material.dart';

class AppStyle {
  Color primaryColor = const Color(0XFF8A2BE2);
  Color secondaryColor = const  Color(0XFFFFA500);

  ThemeData get lightTheme => ThemeData(
    primaryColor: primaryColor,
    accentColor: secondaryColor,
    primarySwatch: Colors.deepPurple,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.blueGrey.shade50,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      },
    ),
    elevatedButtonTheme: _elevatedButtonThemeData,
    inputDecorationTheme: _inputDecorationTheme,
    appBarTheme: _appBarTheme,
    floatingActionButtonTheme: _fabTheme,
    bottomNavigationBarTheme: _bottomNavigationTheme,
  );

  AppBarTheme get _appBarTheme => const AppBarTheme(
    elevation: 0,
    centerTitle: true,
  );

  FloatingActionButtonThemeData get _fabTheme => FloatingActionButtonThemeData(
    backgroundColor: secondaryColor,
    elevation: 4,
    foregroundColor: Colors.white,
  );

  ElevatedButtonThemeData get _elevatedButtonThemeData => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      primary: primaryColor,
    ),
  );

  InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: secondaryColor),
    ),
  );

  BottomNavigationBarThemeData get _bottomNavigationTheme => BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 0,
    showUnselectedLabels: true,
    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.blueGrey.shade900,
  );
}