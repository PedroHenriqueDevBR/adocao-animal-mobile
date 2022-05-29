import 'package:adocao_local/src/modules/account/pages/login/login_page.dart';
import 'package:adocao_local/src/modules/home/home_page.dart';
import 'package:adocao_local/src/shares/core/app_assets.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:adocao_local/src/shares/services/app_preferences_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rive/rive.dart';

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
      await Future.delayed(const Duration(milliseconds: 1200));

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
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: const HomePage(),
        type: PageTransitionType.size,
        duration: const Duration(microseconds: 1700),
        alignment: Alignment.center,
      ),
    );
  }

  void goToLoginPage() {
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: const LoginPage(),
        type: PageTransitionType.rightToLeft,
      ),
    );
    // Navigator.pushReplacementNamed(
    //   context,
    //   'account/login',
    // );
  }

  @override
  void initState() {
    super.initState();
    verifyLoggedUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: RiveAnimation.asset(AppAnimations.logoAnimation),
        ),
      ),
    );
  }
}
