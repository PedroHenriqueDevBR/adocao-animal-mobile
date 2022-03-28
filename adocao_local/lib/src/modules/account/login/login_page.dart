import '../../../shares/core/app_assets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                top: 50,
                bottom: 50,
              ),
              child: Center(
                child: Image.asset(
                  AppAssets.logo,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nome de usuário',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
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
