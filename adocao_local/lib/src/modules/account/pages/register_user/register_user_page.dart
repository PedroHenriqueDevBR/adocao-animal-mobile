import 'package:adocao_local/src/modules/account/pages/register_user/register_user_store.dart';
import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:flutter/material.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({Key? key}) : super(key: key);

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  AppTextStyle appTextStyle = AppTextStyle();
  final controller = RegisterUserStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar-se'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Crie uma nova conta para publicar os seus aminais para adoção.',
                  style: appTextStyle.textButton,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Dados pessoais',
                        style: appTextStyle.descriptionStyle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) => controller.setName(value),
                        decoration: const InputDecoration(
                          labelText: 'Nome completo',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) => controller.setUsername(value),
                        decoration: const InputDecoration(
                          labelText: 'Username',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  onChanged: (value) => controller.setContact(value),
                  decoration: const InputDecoration(
                    labelText: 'Contato',
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Acesso à plataforma',
                        style: appTextStyle.descriptionStyle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) => controller.setPassword(value),
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) =>
                            controller.setRepeatPassword(value),
                        decoration: const InputDecoration(
                          labelText: 'Repetir senha',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Localização',
                        style: appTextStyle.descriptionStyle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<int>(
                        value: 1,
                        hint: const Text('Estado'),
                        items: const [
                          DropdownMenuItem(
                            child: Text('Piauí'),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text('Maranhão'),
                            value: 2,
                          ),
                        ],
                        onChanged: (int? value) {},
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: DropdownButton<int>(
                        hint: const Text('Cidade'),
                        value: 1,
                        items: const [
                          DropdownMenuItem(
                            child: Text('Teresina'),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text('Timon'),
                            value: 2,
                          ),
                        ],
                        onChanged: (int? value) {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text('Registrar')),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Já tenho cadastro, retornar para a tela de login',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
