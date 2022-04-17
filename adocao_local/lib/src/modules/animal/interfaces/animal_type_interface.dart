import 'package:adocao_local/src/modules/animal/models/animal_type_model.dart';

abstract class IAnimalType {
  Future<List<AnimalTypeModel>> allTypes();
}
