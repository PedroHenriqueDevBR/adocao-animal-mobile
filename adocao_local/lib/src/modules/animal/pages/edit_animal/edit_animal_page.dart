import 'dart:io';
import 'dart:io' show Platform;

import 'package:adocao_local/src/modules/animal/models/vaccine_book_model.dart';
import 'package:adocao_local/src/modules/animal/pages/edit_animal/widgets/animal_form_widget.dart';
import 'package:adocao_local/src/modules/animal/repositories/animal_image_repository.dart';
import 'package:adocao_local/src/modules/animal/repositories/animal_repository.dart';
import 'package:adocao_local/src/modules/animal/repositories/animal_type_repository.dart';
import 'package:adocao_local/src/modules/animal/repositories/animal_vaccine_repository.dart';
import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:adocao_local/src/shares/services/app_preferences_service.dart';
import 'package:adocao_local/src/shares/services/http_client_service.dart';
import 'package:flutter/material.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:flutter/services.dart';
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
      appData: appData,
      storage: AnimalRepository(
        client: client,
        appData: appData,
      ),
      animalTypeStorage: AnimalTypeRepository(
        client: client,
        appData: appData,
      ),
      imageStorage: AnimalImageRepository(
        client: client,
        appData: appData,
      ),
      vaccineStorage: AnimalVaccineRepository(
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
                child: AnimalFormWidget(
                  textStyle: _textStyle,
                  txtName: controller.txtName,
                  txtBreed: controller.txtBreed,
                  txtAge: controller.txtAge,
                  selectAnimalType: controller.selectAnimalType,
                  selectedAnimalType: controller.selectedAnimalType,
                  animalTypeList: controller.animalTypeList,
                  selectAnimalSex: controller.selectAnimalSex,
                  selectedAnimalSex: controller.selectedAnimalSex,
                  animalSexList: controller.animalSexList,
                  confirmImageProvider: confirmImageProvider,
                  saveImages: () async {
                    await controller.savePhotos(context);
                    setState(() {});
                  },
                  removeImageAnimalPhoto: controller.removePhoto,
                  removeImageFromPhotoPending:
                      controller.removeImageFromPhotoPending,
                  animalPhotoList: controller.animalPhotoList,
                  animalPhotoPendingList: controller.animalPhotoPendingList,
                  animalVaccineList: controller.animalVaccineList,
                  addVaccineDialog: addVaccineDialog,
                  removeVaccineDialog: removeVaccineDialog,
                  animalSaved: controller.animal != null &&
                      controller.animal!.id != null,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await controller.saveAnimal(context);
                      setState(() {});
                    },
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

  void confirmImageProvider() => asuka.showDialog(
        builder: (dialogContext) => AlertDialog(
          backgroundColor: Theme.of(dialogContext).colorScheme.primaryContainer,
          elevation: 16.0,
          title: const Text('Selecione uma opção'),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    Platform.isLinux || Platform.isWindows
                        ? await controller.openGaleryDesktop()
                        : await controller.openGamera();
                    setState(() {});
                    Navigator.pop(dialogContext);
                  },
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

  void addVaccineDialog() => asuka.showDialog(
        builder: (dialogContext) => AlertDialog(
          backgroundColor: Theme.of(dialogContext).colorScheme.primaryContainer,
          elevation: 16.0,
          title: const Text('Adicionar vacina'),
          content: Form(
            child: Wrap(
              children: [
                TextFormField(
                  controller: controller.txtVaccineName,
                  decoration: const InputDecoration(
                    labelText: 'Nome da vacina',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                Container(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.registerVaccine();
                          setState(() {});
                          Navigator.pop(dialogContext);
                        },
                        child: const Text('Registrar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  void removeVaccineDialog(VaccineModel vaccine) => asuka.showDialog(
        builder: (dialogContext) => AlertDialog(
          backgroundColor: Theme.of(dialogContext).colorScheme.primaryContainer,
          elevation: 16.0,
          title: const Text('Atenção'),
          content: const Text('Confirmar a remoção da vacina'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancela'),
            ),
            TextButton(
              onPressed: () {
                controller.removerVaccine(vaccine);
                setState(() {});
                Navigator.pop(dialogContext);
              },
              child: const Text('Confirmar'),
            ),
          ],
        ),
      );
}
