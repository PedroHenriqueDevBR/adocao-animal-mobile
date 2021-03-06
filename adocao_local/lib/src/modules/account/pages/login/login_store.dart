import 'package:adocao_local/src/modules/account/interfaces/user_interface.dart';
import 'package:adocao_local/src/modules/account/pages/register_user/register_user_page.dart';
import 'package:adocao_local/src/modules/home/home_page.dart';
import 'package:adocao_local/src/shares/exceptions/http_response_exception.dart';
import 'package:adocao_local/src/shares/exceptions/unauthorized_exception.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:page_transition/page_transition.dart';

part 'login_store.g.dart';

class LoginStore extends _LoginStore with _$LoginStore {
  LoginStore({
    required IAppData appData,
    required IUserStorage storage,
  }) {
    super.appData = appData;
    super.storage = storage;
  }
}

abstract class _LoginStore with Store {
  late IAppData appData;
  late IUserStorage storage;

  @observable
  String txtLogin = '';
  @observable
  String txtPassword = '';
  @observable
  bool showPassword = false;
  @observable
  bool loading = false;

  @action
  void setLogin(String value) => txtLogin = value;

  @action
  void setPassword(String value) => txtPassword = value;

  @action
  void setLoading(bool value) => loading = value;

  @action
  void toggleShowPassword() => showPassword = !showPassword;

  @computed
  bool get formIsValid => txtLogin.length >= 5 && txtPassword.length >= 8;

  void verifyLoggedUser(BuildContext context) async {
    setLoading(true);
    try {
      final jwt = await appData.getJWT();
      if (jwt.isNotEmpty) {
        goToHomePage(context);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    } finally {
      setLoading(false);
    }
  }

  void login(BuildContext context) async {
    try {
      setLoading(true);
      FocusManager.instance.primaryFocus?.unfocus();
      final token = await storage.login(txtLogin, txtPassword);
      appData.setJWT(token.access);
      goToHomePage(context);
    } on UnauthorizedException catch (_) {
      asuka.showSnackBar(
        asuka.AsukaSnackbar.alert('Verifique as suas credenciais'),
      );
    } on HttpResponseException catch (_) {
      asuka.showSnackBar(
        asuka.AsukaSnackbar.alert('Verifique as suas credenciais'),
      );
    } catch (error) {
      asuka.showSnackBar(
        asuka.AsukaSnackbar.alert('Erro interno, j?? estamos resolvendo'),
      );
    } finally {
      setLoading(false);
    }
  }

  void goToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: const HomePage(),
        type: PageTransitionType.rightToLeft,
        duration: const Duration(milliseconds: 600),
        reverseDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void goToRegisterUserPage(BuildContext context) {
    Navigator.push(
      context,
      PageTransition(
        child: const RegisterUserPage(),
        type: PageTransitionType.rightToLeft,
        duration: const Duration(milliseconds: 600),
        reverseDuration: const Duration(milliseconds: 500),
      ),
    );
  }
}
