import 'package:adocao_local/src/modules/animal/models/adoption_request_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';

abstract class IAnimalRequestStorage {
  Future<List<AdoptionRequestModel>> allAdoptionRequestFromAnimal(
    AnimalModel animal,
  );

  Future<void> confirmAdoptionRequest(
    AnimalModel animal,
    AdoptionRequestModel adoptionRequest,
  );

  Future<void> rejectAdoptionRequest(
    AnimalModel animal,
    AdoptionRequestModel adoptionRequest,
  );

  Future<void> deleteAdoptionRequest(
    AnimalModel animal,
    AdoptionRequestModel adoptionRequest,
  );
}
