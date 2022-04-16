import 'package:adocao_local/src/modules/animal/models/adoption_request_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/models/vaccine_book_model.dart';

abstract class IAnimal {
  Future<List<AnimalModel>> allAnimals();

  Future<AnimalModel> create(AnimalModel animal);

  Future<void> upadte(AnimalModel animal);

  Future<void> delete(AnimalModel animal);

  Future<void> blockAnimal(AnimalModel animal);

  Future<void> unlockAnimal(AnimalModel animal);

  Future<List<AdoptionRequestModel>> allAdoptionRequestFromAnimal(
    AnimalModel animal,
  );

  Future<void> confirmAdoptionRequest(AdoptionRequestModel adoptionRequest);

  Future<void> rejectAdoptionRequest(AdoptionRequestModel adoptionRequest);
}
