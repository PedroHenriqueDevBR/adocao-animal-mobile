import 'package:flutter/material.dart';

import 'package:adocao_local/src/modules/animal/models/animal_model.dart';

class CreateAnimalPage extends StatefulWidget {
  AnimalModel? animal;

  CreateAnimalPage({
    Key? key,
    this.animal,
  }) : super(key: key);

  @override
  State<CreateAnimalPage> createState() => _CreateAnimalPageState();
}

class _CreateAnimalPageState extends State<CreateAnimalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modo Edição'),
      ),
      body: const Center(
        child: Text('Cadastrar ou editar animal'),
      ),
    );
  }
}
