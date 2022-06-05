import 'dart:io';

import 'package:adocao_local/src/modules/account/pages/login/login_page.dart';
import 'package:adocao_local/src/modules/animal/interfaces/animal_image_interface.dart';
import 'package:adocao_local/src/modules/animal/interfaces/animal_interface.dart';
import 'package:adocao_local/src/modules/animal/interfaces/animal_type_interface.dart';
import 'package:adocao_local/src/modules/animal/interfaces/animal_vaccine_interface.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_photo_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_sex_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_type_model.dart';
import 'package:adocao_local/src/modules/animal/models/vaccine_book_model.dart';
import 'package:adocao_local/src/shares/exceptions/connection_refused_exception.dart';
import 'package:adocao_local/src/shares/exceptions/http_response_exception.dart';
import 'package:adocao_local/src/shares/exceptions/unauthorized_exception.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;

part 'edit_animal_store.g.dart';

class EditAnimalStore extends _EditAnimalStore with _$EditAnimalStore {
  EditAnimalStore({
    required IAppData appData,
    required IAnimalStorage storage,
    required IAnimalTypeStorage animalTypeStorage,
    required IAnimalImageStorage imageStorage,
    required IAnimalVaccineStorage vaccineStorage,
    AnimalModel? animal,
  }) {
    super.appData = appData;
    super.storage = storage;
    super.animalTypeStorage = animalTypeStorage;
    super.animal = animal;
    super.imageStorage = imageStorage;
    super.vaccineStorage = vaccineStorage;
  }
}

abstract class _EditAnimalStore with Store {
  late IAppData appData;
  late IAnimalStorage storage;
  late IAnimalTypeStorage animalTypeStorage;
  late IAnimalImageStorage imageStorage;
  late IAnimalVaccineStorage vaccineStorage;
  late AnimalModel? animal;
  final ImagePicker picker = ImagePicker();

  List<AnimalPhotoModel> animalPhotoList = [];
  ObservableList<File> animalPhotoPendingList = ObservableList<File>();
  List<VaccineModel> animalVaccineList = [];
  ObservableList<AnimalSexModel> animalSexList =
      ObservableList<AnimalSexModel>();
  ObservableList<AnimalTypeModel> animalTypeList =
      ObservableList<AnimalTypeModel>();

  TextEditingController txtName = TextEditingController();
  TextEditingController txtBreed = TextEditingController();
  TextEditingController txtAge = TextEditingController();
  TextEditingController txtVaccineName = TextEditingController();

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

  void loadAnimalData() {
    if (animal != null) {
      txtName.text = animal!.name;
      txtBreed.text = animal!.breed;
      txtAge.text = '${animal!.age}';
      animalPhotoList.addAll(animal!.photos);
      animalVaccineList.addAll(animal!.vaccines);
    }
  }

  void selectAnimalType(AnimalTypeModel? animalType) {
    selectedAnimalType = animalType;
    setUpdate();
  }

  void selectAnimalSex(AnimalSexModel? animalSex) {
    selectedAnimalSex = animalSex;
    setUpdate();
  }

  void removeImageFromPhotoPending(File file) {
    animalPhotoPendingList.remove(file);
  }

  bool formIsValid() {
    bool valid = true;
    if (txtName.text.isEmpty) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Informe o nome do animal'));
      valid = false;
    } else if (txtBreed.text.isEmpty) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Informe a raça do animal'));
      valid = false;
    } else if (txtAge.text.isEmpty) {
      asuka
          .showSnackBar(asuka.AsukaSnackbar.alert('Informe a idade do animal'));
      valid = false;
    } else if (int.tryParse(txtAge.text) == null) {
      asuka.showSnackBar(
          asuka.AsukaSnackbar.alert('A idade deve ser um número'));
      valid = false;
    } else if (int.parse(txtAge.text) < 0) {
      asuka.showSnackBar(
          asuka.AsukaSnackbar.alert('A idade não pode ser negativa'));
      valid = false;
    } else if (selectedAnimalType == null) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Informe o tipo de animal'));
      valid = false;
    } else if (selectedAnimalSex == null) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('Informe o sexo do animal'));
      valid = false;
    }
    return valid;
  }

  Future<void> saveAnimal(BuildContext context) async {
    if (formIsValid()) {
      final animalData = AnimalModel(
        name: txtName.text,
        breed: txtBreed.text,
        age: int.parse(txtAge.text),
        sex: selectedAnimalSex!.short,
        animalType: selectedAnimalType!,
      );

      if (animal == null) {
        await addAnmal(context, animalData);
      } else {
        await updateAnimal(context, animalData);
      }
    }
  }

  Future<void> addAnmal(
    BuildContext context,
    AnimalModel animalData,
  ) async {
    try {
      final response = await storage.create(animalData);
      animal = response;
      asuka.showSnackBar(asuka.AsukaSnackbar.success('Animal registrado'));
    } on ConnectionRefusedException {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert(
        'Sem conexão com o servidor',
      ));
    } on UnauthorizedException {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert(
        'Sessão encerrada, entre novamente',
      ));
      appData.setJWT('');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false,
      );
    } on HttpResponseException catch (error) {
      if (error.response.statusCode >= 500) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('Servidor indisponível'));
      }
    } catch (error) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('$error'));
    }
  }

  Future<void> updateAnimal(
    BuildContext context,
    AnimalModel animalData,
  ) async {
    try {
      await storage.upadte(animalData);
      asuka.showSnackBar(asuka.AsukaSnackbar.success('Dados  atualizados'));
    } on ConnectionRefusedException {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert(
        'Sem conexão com o servidor',
      ));
    } on UnauthorizedException {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert(
        'Sessão encerrada, entre novamente',
      ));
      appData.setJWT('');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false,
      );
    } on HttpResponseException catch (error) {
      if (error.response.statusCode >= 500) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('Servidor indisponível'));
      }
    } catch (error) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('$error'));
    }
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

  Future<void> removePhoto({
    required BuildContext context,
    required AnimalPhotoModel photo,
  }) async {
    try {
      await imageStorage.removePhoto(photo);
      animalPhotoList.remove(photo);
      asuka.showSnackBar(asuka.AsukaSnackbar.success('Imagem removida'));
      setUpdate();
    } on ConnectionRefusedException {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert(
        'Sem conexão com o servidor',
      ));
    } on UnauthorizedException {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert(
        'Sessão encerrada, entre novamente',
      ));
      appData.setJWT('');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false,
      );
    } on HttpResponseException catch (error) {
      if (error.response.statusCode >= 500) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('Servidor indisponível'));
      }
    } catch (error) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('$error'));
    }
  }

  Future<void> savePhotos(BuildContext context) async {
    try {
      for (final file in animalPhotoPendingList) {
        final response = await imageStorage.addPhoto(animal!, file.path);
        animalPhotoList.add(response);
      }
      animalPhotoPendingList.clear();
      asuka.showSnackBar(asuka.AsukaSnackbar.success('Imagens salvas'));
    } on ConnectionRefusedException {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert(
        'Sem conexão com o servidor',
      ));
    } on UnauthorizedException {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert(
        'Sessão encerrada, entre novamente',
      ));
      appData.setJWT('');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false,
      );
    } on HttpResponseException catch (error) {
      if (error.response.statusCode >= 500) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('Servidor indisponível'));
      }
    } catch (error) {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert('$error'));
    }
  }

  Future<void> registerVaccine() async {
    final vaccine = VaccineModel(name: txtVaccineName.text);
    final response = await vaccineStorage.addVaccine(vaccine, animal!);
    animalVaccineList.add(response);
    txtVaccineName.clear();
    setUpdate();
  }

  Future<void> removerVaccine(VaccineModel vaccine) async {
    final response = await vaccineStorage.removeVaccine(vaccine);
    animalVaccineList.remove(vaccine);
    setUpdate();
  }
}
