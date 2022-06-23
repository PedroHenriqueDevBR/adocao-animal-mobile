import 'package:adocao_local/src/modules/animal/models/animal_model.dart';

abstract class IAnimalStorage {
  Future<Map> dashboard();

  Future<List<AnimalModel>> allAnimals();

  Future<AnimalModel> create(AnimalModel animal);

  Future<void> upadte(AnimalModel animal);

  Future<void> delete(AnimalModel animal);

  Future<void> blockAnimal(AnimalModel animal);

  Future<void> unlockAnimal(AnimalModel animal);
}
