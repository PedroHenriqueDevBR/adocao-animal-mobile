import 'package:adocao_local/src/shares/core/app_assets.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:adocao_local/src/shares/services/app_preferences_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  IAppData appData = AppPreferenceService();

  void verifyLoggedUser() async {
    try {
      final jwt = await appData.getJWT();
      await Future.delayed(const Duration(seconds: 1));

      if (jwt.isNotEmpty) {
        goToHomePage();
      } else {
        goToLoginPage();
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      goToLoginPage();
    }
  }

  void goToHomePage() {
    Navigator.pushNamed(
      context,
      'home',
    );
  }

  void goToLoginPage() {
    Navigator.pushNamed(
      context,
      'account/login',
    );
  }

  @override
  void initState() {
    super.initState();
    verifyLoggedUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Image.asset(
          AppAssets.logo,
          width: 100,
          height: 100,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
