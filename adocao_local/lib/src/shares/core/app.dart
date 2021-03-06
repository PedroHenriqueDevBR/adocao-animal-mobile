import 'package:adocao_local/src/modules/account/pages/login/login_page.dart';
import 'package:adocao_local/src/modules/account/pages/register_user/register_user_page.dart';
import 'package:adocao_local/src/modules/home/home_page.dart';
import 'package:adocao_local/src/modules/home/splash_page.dart';
import 'package:adocao_local/src/shares/core/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asuka/asuka.dart' as asuka;

class App extends StatelessWidget {
  final _appStyle = AppStyle();

  void changeNavigatorColor() {
    final uiOverlay = SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: _appStyle.primaryColor,
    );
    SystemChrome.setSystemUIOverlayStyle(uiOverlay);
  }

  @override
  Widget build(BuildContext context) {
    changeNavigatorColor();
    return MaterialApp(
      builder: asuka.builder,
      navigatorObservers: [
        asuka.asukaHeroController //if u don`t add this Hero will not work
      ],
      debugShowCheckedModeBanner: false,
      title: 'Adoção Animal',
      theme: _appStyle.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        'home': (context) => const HomePage(),
        'account/login': (context) => const LoginPage(),
        'account/register': (context) => const RegisterUserPage(),
      },
    );
  }
}
