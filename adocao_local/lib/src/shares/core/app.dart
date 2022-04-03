import 'package:adocao_local/src/modules/account/pages/login/login_page.dart';
import 'package:adocao_local/src/modules/home/home_page.dart';
import 'package:adocao_local/src/shares/core/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asuka/asuka.dart' as asuka;

class App extends StatelessWidget {
  final _appStyle = AppStyle();

  void changeNavigatorColor() {
    final uiOverlay = SystemUiOverlayStyle.light.copyWith(
      statusBarColor: _appStyle.primaryColor,
      systemNavigationBarColor: Colors.white,
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
      initialRoute: 'account/login',
      routes: {
        'home': (context) => const HomePage(),
        'account/login': (context) => const LoginPage(),
      },
    );
  }
}
