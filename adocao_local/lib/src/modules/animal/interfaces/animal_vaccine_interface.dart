import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/models/vaccine_book_model.dart';

abstract class IAnimalVaccineStorage {
  Future<List<VaccineModel>> allVaccinesFromAnimal(AnimalModel animal);

  Future<VaccineModel> addVaccine(VaccineModel vaccine, AnimalModel animal);

  Future<void> removeVaccine(VaccineModel vaccine);
}
