import 'package:flutter/material.dart';

class AppStyle {
  Color primaryColor = const Color(0XFF8A2BE2);
  Color secondaryColor = const Color(0XFFFFA500);

  ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          secondary: secondaryColor,
          // seedColor: Color(0XFF24FF78),
          // brightness: Brightness.dark,
        ),
        // primaryColor: primaryColor,
        // colorScheme: _colorScheme,
        // primarySwatch: Colors.deepPurple,
        // brightness: Brightness.dark,
        // scaffoldBackgroundColor: Colors.blueGrey.shade50,
        // backgroundColor: Colors.white,
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
        // bottomNavigationBarTheme: _bottomNavigationTheme,
      );

  ColorScheme get _colorScheme => ColorScheme(
        brightness: Brightness.light,
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: secondaryColor,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background: Colors.blueGrey.shade50,
        onBackground: Colors.blueGrey.shade900,
        surface: Colors.blueGrey.shade50,
        onSurface: Colors.blueGrey.shade900,
      );

  AppBarTheme get _appBarTheme => AppBarTheme(
        elevation: 0,
        centerTitle: true,
        color: primaryColor,
        foregroundColor: Colors.white,
      );

  FloatingActionButtonThemeData get _fabTheme =>
      const FloatingActionButtonThemeData(
        // backgroundColor: secondaryColor,
        elevation: 4,
        // foregroundColor: Colors.white,
      );

  ElevatedButtonThemeData get _elevatedButtonThemeData =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
          primary: secondaryColor,
          onPrimary: Colors.white,
        ),
      );

  InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
        // fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: secondaryColor),
        ),
      );

  BottomNavigationBarThemeData get _bottomNavigationTheme =>
      const BottomNavigationBarThemeData(
        elevation: 0,
        showUnselectedLabels: true,
        // backgroundColor: Colors.white,
        // selectedItemColor: primaryColor,
        // unselectedItemColor: Colors.blueGrey.shade900,
      );
}
