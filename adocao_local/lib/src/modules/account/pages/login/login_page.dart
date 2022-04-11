import 'package:adocao_local/src/modules/account/pages/login/login_store.dart';
import 'package:adocao_local/src/modules/account/repositories/user_repository.dart';
import 'package:adocao_local/src/shares/core/app_assets.dart';
import 'package:adocao_local/src/shares/services/app_preferences_service.dart';
import 'package:adocao_local/src/shares/services/http_client_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginStore controller;
  final client = HttpClientService();
  final appData = AppPreferenceService();

  @override
  void initState() {
    controller = LoginStore(
      context: context,
      appData: appData,
      storage: UserRepository(client: client, appData: appData),
    );
    // controller.verifyLoggedUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.only(
                top: 110,
                bottom: 110,
              ),
              child: Center(
                child: Image.asset(
                  AppAssets.logo,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) => controller.setLogin(value),
                    decoration: const InputDecoration(
                      labelText: 'Nome de usuário',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Observer(
                      builder: (_) => TextFormField(
                            onChanged: (value) => controller.setPassword(value),
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    controller.toggleShowPassword(),
                                icon: Icon(
                                  controller.showPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                            obscureText: controller.showPassword ? false : true,
                          )),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: Observer(
                          builder: (_) => ElevatedButton(
                            onPressed: controller.formIsValid
                                ? controller.login
                                : null,
                            child: controller.loading
                                ? const SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('Entrar'),
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: controller.goToRegisterUserPage,
                    child: const Text(
                      'Ainda não possui cadastro\nClique aqui e cadastre-se',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
