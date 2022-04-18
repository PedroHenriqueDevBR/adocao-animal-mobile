import 'package:adocao_local/src/modules/animal/interfaces/animal_vaccine_interface.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/models/vaccine_book_model.dart';

class AnimalVaccineRepository implements IAnimalVaccine {
  @override
  Future<VaccineModel> addVaccine(VaccineModel vaccine) {
    // TODO: implement addVaccine
    throw UnimplementedError();
  }

  @override
  Future<List<VaccineModel>> allVaccinesFromAnimal(AnimalModel animal) {
    // TODO: implement allVaccinesFromAnimal
    throw UnimplementedError();
  }

  @override
  Future<void> removeVaccine(VaccineModel vaccine) {
    // TODO: implement removeVaccine
    throw UnimplementedError();
  }
}
