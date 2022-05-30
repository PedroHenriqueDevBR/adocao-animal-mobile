import 'dart:io';

import 'package:adocao_local/src/modules/animal/models/animal_photo_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_sex_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_type_model.dart';
import 'package:adocao_local/src/modules/animal/models/vaccine_book_model.dart';
import 'package:adocao_local/src/modules/animal/repositories/animal_repository.dart';
import 'package:adocao_local/src/modules/animal/repositories/animal_type_repository.dart';
import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:adocao_local/src/shares/services/app_preferences_service.dart';
import 'package:adocao_local/src/shares/services/http_client_service.dart';
import 'package:adocao_local/src/shares/widgets/dropdown_conrtainer/dropdown_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import './edit_animal_store.dart';
import 'package:asuka/asuka.dart' as asuka;

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
      animalTypeStorage: AnimalTypeRepository(
        client: client,
        appData: appData,
      ),
      animal: widget.animal,
    );
    controller.loadAnimalTypeList();
    controller.loadAnimalData();
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Adoção de animais'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: animalForm(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Salvar alterações'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget animalForm() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dados do animal',
            textAlign: TextAlign.left,
            style: _textStyle.titleStyle,
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
          Row(
            children: [
              Expanded(
                child: Text(
                  'Album de fotos',
                  textAlign: TextAlign.left,
                  style: _textStyle.titleStyle,
                ),
              ),
              IconButton(
                  onPressed: confirmImageProvider, icon: Icon(Icons.add)),
            ],
          ),
          const SizedBox(height: 16.0),
          controller.animalPhotoList.isNotEmpty
              ? GridView.builder(
                  itemCount: controller.animalPhotoList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  ),
                  itemBuilder: (_, index) {
                    AnimalPhotoModel photo = controller.animalPhotoList[index];
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(photo.url),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red.withAlpha(150),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12.0),
                              ),
                            ),
                            child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  controller.removeImageAnimalPhoto(photo);
                                  setState(() {});
                                }),
                          ),
                        ),
                      ],
                    );
                  },
                )
              : Container(),
          controller.animalPhotoPendingList.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    const Divider(),
                    Text(
                      'Imagens preparadas',
                      textAlign: TextAlign.left,
                      style: _textStyle.titleStyle,
                    ),
                    const SizedBox(height: 12.0),
                    GridView.builder(
                      itemCount: controller.animalPhotoPendingList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                      ),
                      itemBuilder: (_, index) {
                        File file = controller.animalPhotoPendingList[index];
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(file),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red.withAlpha(150),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12.0),
                                  ),
                                ),
                                child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      controller
                                          .removeImageFromPhotoPending(file);
                                      setState(() {});
                                    }),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  ],
                )
              : Container(),
          const SizedBox(height: 8.0),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Caderneta de vacinação',
                  textAlign: TextAlign.left,
                  style: _textStyle.titleStyle,
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.add)),
            ],
          ),
          Observer(builder: (_) {
            return ListView.separated(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (_, __) => const Divider(),
              itemCount: controller.animalVaccineList.length,
              itemBuilder: (_, index) {
                VaccineModel vaccine = controller.animalVaccineList[index];
                return ListTile(
                  title: Text(vaccine.name),
                  subtitle: Text(vaccine.formattedDate),
                  trailing: TextButton(
                    onPressed: () {},
                    child: const Text('Editar'),
                  ),
                );
              },
            );
          }),
        ],
      );

  void confirmImageProvider() => asuka.showDialog(
        builder: (dialogContext) => AlertDialog(
          backgroundColor: Theme.of(dialogContext).colorScheme.primaryContainer,
          elevation: 16.0,
          title: Text('Selecione uma opção'),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.camera_alt_outlined),
                        Text('Câmera'),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    Platform.isLinux || Platform.isWindows
                        ? await controller.openGaleryDesktop()
                        : await controller.openGalery();
                    setState(() {});
                    Navigator.pop(dialogContext);
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.image_outlined),
                          Text('Galeria'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
