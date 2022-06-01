import 'dart:io';

import 'package:adocao_local/src/modules/animal/interfaces/animal_interface.dart';
import 'package:adocao_local/src/modules/animal/interfaces/animal_type_interface.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_photo_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_sex_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_type_model.dart';
import 'package:adocao_local/src/modules/animal/models/vaccine_book_model.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'edit_animal_store.g.dart';

class EditAnimalStore extends _EditAnimalStore with _$EditAnimalStore {
  EditAnimalStore({
    required IAppData appData,
    required IAnimalStorage storage,
    required IAnimalTypeStorage animalTypeStorage,
    required BuildContext context,
    AnimalModel? animal,
  }) {
    super.appData = appData;
    super.storage = storage;
    super.animalTypeStorage = animalTypeStorage;
    super.context = context;
    super.animal = animal;
  }
}

abstract class _EditAnimalStore with Store {
  late IAppData appData;
  late IAnimalStorage storage;
  late IAnimalTypeStorage animalTypeStorage;
  late BuildContext context;
  late AnimalModel? animal;
  final ImagePicker picker = ImagePicker();

  List<AnimalPhotoModel> animalPhotoList = [];
  List<File> animalPhotoPendingList = [];
  List<VaccineModel> animalVaccineList = [];
  ObservableList<AnimalSexModel> animalSexList =
      ObservableList<AnimalSexModel>();
  ObservableList<AnimalTypeModel> animalTypeList =
      ObservableList<AnimalTypeModel>();

  TextEditingController txtName = TextEditingController();
  TextEditingController txtBreed = TextEditingController();
  TextEditingController txtAge = TextEditingController();

  @observable
  AnimalTypeModel? selectedAnimalType;
  @observable
  AnimalSexModel? selectedAnimalSex;
  @observable
  bool loading = false;
  @observable
  bool update = false;

  @action
  void setUpdate() => update = !update;

  void loadAnimalTypeList() async {
    animalSexList.addAll(
      [
        AnimalSexModel(short: 'M', name: 'Macho'),
        AnimalSexModel(short: 'F', name: 'Fêmea'),
      ],
    );
    final result = await animalTypeStorage.allTypes();
    animalTypeList.addAll(result);
  }

  void loadAnimalData() {}

  void selectAnimalType(AnimalTypeModel? animalType) {
    selectedAnimalType = animalType;
    setUpdate();
  }

  void selectAnimalSex(AnimalSexModel? animalSex) {
    selectedAnimalSex = animalSex;
    setUpdate();
  }

  void removeImageAnimalPhoto(AnimalPhotoModel photo) {
    animalPhotoList.remove(photo);
  }

  void removeImageFromPhotoPending(File file) {
    animalPhotoPendingList.remove(file);
  }

  Future<void> openGalery() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      animalPhotoPendingList.add(File(image.path));
      setUpdate();
    }
  }

  Future<void> openGaleryDesktop() async {
    FilePickerResult? files = await FilePicker.platform.pickFiles(
      dialogTitle: 'Selecionar imagem',
      type: FileType.image,
      allowMultiple: true,
      lockParentWindow: true,
    );
    if (files != null) {
      for (final file in files.files) {
        if (file.path != null) animalPhotoPendingList.add(File(file.path!));
      }
    }
  }

  Future<void> openGamera() async {
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      animalPhotoPendingList.add(File(image.path));
      setUpdate();
    }
  }
}
