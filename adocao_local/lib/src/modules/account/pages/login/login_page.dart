import 'package:adocao_local/src/modules/account/interfaces/user_interface.dart';
import 'package:adocao_local/src/modules/account/repositories/user_repository.dart';
import 'package:adocao_local/src/modules/home/home_page.dart';
import 'package:adocao_local/src/shares/core/app_assets.dart';
import 'package:adocao_local/src/shares/exceptions/http_response_exception.dart';
import 'package:adocao_local/src/shares/services/app_preferences_service.dart';
import 'package:adocao_local/src/shares/services/http_client_service.dart';
import 'package:flutter/material.dart';
import 'package:asuka/asuka.dart' as asuka;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final txtLogin = TextEditingController();
  final txtPassword = TextEditingController();
  final appData = AppPreferenceService();

  IUserStorage storage = UserRepository(
    client: HttpClientService(),
    appData: AppPreferenceService(),
  );

  void login() async {
    try {
      final token = await storage.login(txtLogin.text, txtPassword.text);
      await appData.setJWT(token.access);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } on HttpResponseException catch (error) {
      asuka.showSnackBar(
        asuka.AsukaSnackbar.alert('Verifique as suas credenciais'),
      );
    }
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
                    controller: txtLogin,
                    decoration: const InputDecoration(
                      labelText: 'Nome de usuário',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: txtPassword,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: login,
                          child: const Text('Entrar'),
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).colorScheme.secondary),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Ainda não possui cadastro\n' +
                          'Clique aqui e cadastre-se',
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
