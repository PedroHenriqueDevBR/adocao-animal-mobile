import 'dart:io';

import 'package:adocao_local/src/modules/account/pages/login/login_store.dart';
import 'package:adocao_local/src/modules/account/repositories/user_repository.dart';
import 'package:adocao_local/src/modules/account/widgets/avatar_container_widget.dart';
import 'package:adocao_local/src/shares/core/app_assets.dart';
import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:adocao_local/src/shares/services/app_preferences_service.dart';
import 'package:adocao_local/src/shares/services/http_client_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:rive/rive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginStore controller;
  final client = HttpClientService();
  final appData = AppPreferenceService();
  final appTextStyle = AppTextStyle();

  @override
  void initState() {
    controller = LoginStore(
      context: context,
      appData: appData,
      storage: UserRepository(client: client, appData: appData),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Platform.isAndroid || Platform.isIOS
            ? Column(
                children: [
                  const AvatarContainerWidget(),
                  formContainer(),
                ],
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: AvatarContainerWidget(),
                    ),
                    Expanded(
                      flex: 1,
                      child: formContainer(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget formContainer() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Login',
              style: appTextStyle.titleStyle,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Entre com as suas credenciais',
              style: appTextStyle.descriptionStyle,
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
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
                          onPressed: () => controller.toggleShowPassword(),
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
                      onPressed:
                          controller.formIsValid ? controller.login : null,
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
      );
}
