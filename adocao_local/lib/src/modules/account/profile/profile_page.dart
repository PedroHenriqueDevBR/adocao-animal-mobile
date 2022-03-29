import 'package:adocao_local/src/shares/core/app_assets.dart';
import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  final _textStyle = AppTextStyle();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: size.width,
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).colorScheme.secondary,
            child: Column(
              children: [
                Image.asset(
                  AppAssets.avatar,
                  width: 150,
                  fit: BoxFit.fill,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Atualizar Imagem',
                          style: _textStyle.textButton.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Remover Imagem',
                          style: _textStyle.textButton.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dados pessoais',
                  style: _textStyle.titleStyle,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'username (readonly)',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome completo',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Contato',
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Estado',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Cidade',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Container(
                  width: size.width,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Alterar Senha',
                      textAlign: TextAlign.center,
                      style: _textStyle.textButton.copyWith(
                        color: Colors.blueGrey.shade900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Atualizar dados'),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Encerrar sessão'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          )
        ],
      ),
    );
  }
}
