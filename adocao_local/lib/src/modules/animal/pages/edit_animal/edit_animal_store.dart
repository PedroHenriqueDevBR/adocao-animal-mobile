import 'package:adocao_local/src/modules/animal/interfaces/animal_interface.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_sex_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_type_model.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'edit_animal_store.g.dart';

class EditAnimalStore extends _EditAnimalStore with _$EditAnimalStore {
  EditAnimalStore({
    required IAppData appData,
    required IAnimalStorage storage,
    required BuildContext context,
    AnimalModel? animal,
  }) {
    super.appData = appData;
    super.storage = storage;
    super.context = context;
    super.animal = animal;
  }
}

abstract class _EditAnimalStore with Store {
  late IAppData appData;
  late IAnimalStorage storage;
  late BuildContext context;
  late AnimalModel? animal;
  ObservableList<AnimalTypeModel> animalTypeList =
      ObservableList<AnimalTypeModel>();

  ObservableList<AnimalSexModel> animalSexList =
      ObservableList<AnimalSexModel>();

  @observable
  String txtName = '';
  @observable
  String txtBreed = '';
  @observable
  int txtAge = 0;
  @observable
  AnimalTypeModel? selectedAnimalType;
  @observable
  AnimalSexModel? selectedAnimalSex;
  @observable
  bool loading = false;
  @observable
  bool update = false;

  @action
  void setName(String value) => txtName = value;
  @action
  void setBreed(String value) => txtBreed = value;
  @action
  void setAge(int value) => txtAge = value;
  @action
  void setUpdate() => update = !update;

  void loadAnimalTypeList() {
    animalTypeList.addAll(
      [
        AnimalTypeModel(id: 1, name: 'Cachorro'),
        AnimalTypeModel(id: 1, name: 'Gato'),
      ],
    );
    animalSexList.addAll(
      [
        AnimalSexModel(short: 'M', name: 'Macho'),
        AnimalSexModel(short: 'F', name: 'Fêmea'),
      ],
    );
  }

  void selectAnimalType(AnimalTypeModel? animalType) {
    selectedAnimalType = animalType;
    setUpdate();
  }

  void selectAnimalSex(AnimalSexModel? animalSex) {
    selectedAnimalSex = animalSex;
    setUpdate();
  }
}
