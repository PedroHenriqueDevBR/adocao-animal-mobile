import 'package:adocao_local/src/modules/animal/models/animal_type_model.dart';

abstract class IAnimalTypeStorage {
  Future<List<AnimalTypeModel>> allTypes();
  Future<AnimalTypeModel> typeById(int id);
}
