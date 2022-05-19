import 'package:adocao_local/src/modules/animal/models/animal_sex_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_type_model.dart';
import 'package:adocao_local/src/modules/animal/repositories/animal_repository.dart';
import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:adocao_local/src/shares/services/app_preferences_service.dart';
import 'package:adocao_local/src/shares/services/http_client_service.dart';
import 'package:adocao_local/src/shares/widgets/dropdown_conrtainer/dropdown_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import './edit_animal_store.dart';

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
  final _textStyle = AppTextStyle();
  final appData = AppPreferenceService();
  final client = HttpClientService();
  late EditAnimalStore controller;

  @override
  void initState() {
    super.initState();
    controller = EditAnimalStore(
      context: context,
      appData: appData,
      storage: AnimalRepository(
        client: client,
        appData: appData,
      ),
      animal: widget.animal,
    );
    controller.loadAnimalTypeList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reaction(
      (_) => controller.update,
      (_) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Adoção de animais'),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Dados do animal',
                      textAlign: TextAlign.left,
                      style: _textStyle.titleStyle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) => controller.setName(value),
                      decoration: const InputDecoration(
                        labelText: 'Nome do animal',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) => controller.setBreed(value),
                            decoration: const InputDecoration(
                              labelText: 'Raça',
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              int? intValue = int.tryParse(value);
                              if (intValue != null) {
                                controller.setAge(intValue);
                              } else {}
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Idade',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownContainerWidget(
                            child: Observer(
                              builder: (_) => DropdownButton<AnimalTypeModel>(
                                onChanged: controller.selectAnimalType,
                                isExpanded: true,
                                underline: const SizedBox(),
                                hint: const Text('Tipo de animal'),
                                value: controller.selectedAnimalType,
                                items: controller.animalTypeList
                                    .map(
                                      (AnimalTypeModel animalType) =>
                                          DropdownMenuItem<AnimalTypeModel>(
                                        value: animalType,
                                        child: Text(animalType.name),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: DropdownContainerWidget(
                            child: Observer(
                              builder: (_) => DropdownButton<AnimalSexModel>(
                                onChanged: controller.selectAnimalSex,
                                isExpanded: true,
                                underline: const SizedBox(),
                                hint: const Text('Sexo'),
                                value: controller.selectedAnimalSex,
                                items: controller.animalSexList
                                    .map(
                                      (AnimalSexModel animalSex) =>
                                          DropdownMenuItem<AnimalSexModel>(
                                        value: animalSex,
                                        child: Text(animalSex.name),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              const Divider(),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Album de fotos',
                      textAlign: TextAlign.left,
                      style: _textStyle.titleStyle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                children: [
                  Container(
                    color: Colors.grey,
                  ),
                  Container(
                    color: Colors.grey,
                  ),
                  Container(
                    color: Colors.grey,
                  ),
                  Container(
                    color: Colors.grey,
                  ),
                  Container(
                    color: Colors.grey,
                  ),
                  Container(
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const Divider(),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Caderneta de vacinação',
                      textAlign: TextAlign.left,
                      style: _textStyle.titleStyle,
                    ),
                  ),
                ],
              ),
              ListView.separated(
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (_, __) => const Divider(),
                itemCount: 5,
                itemBuilder: (context, index) => ListTile(
                  title: Text('Nome da vacina ${index + 1}'),
                  subtitle: const Text('00/00/0000'),
                  trailing: TextButton(onPressed: () {}, child: Text('Editar')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
