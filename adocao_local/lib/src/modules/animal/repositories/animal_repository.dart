import 'package:adocao_local/src/modules/animal/interfaces/animal_interface.dart';
import 'package:adocao_local/src/modules/animal/models/adoption_request_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';

class AnimalRepository implements IAnimal {
  @override
  Future<List<AdoptionRequestModel>> allAdoptionRequestFromAnimal(
      AnimalModel animal) {
    // TODO: implement allAdoptionRequestFromAnimal
    throw UnimplementedError();
  }

  @override
  Future<List<AnimalModel>> allAnimals() {
    // TODO: implement allAnimals
    throw UnimplementedError();
  }

  @override
  Future<void> blockAnimal(AnimalModel animal) {
    // TODO: implement blockAnimal
    throw UnimplementedError();
  }

  @override
  Future<void> confirmAdoptionRequest(AdoptionRequestModel adoptionRequest) {
    // TODO: implement confirmAdoptionRequest
    throw UnimplementedError();
  }

  @override
  Future<AnimalModel> create(AnimalModel animal) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(AnimalModel animal) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> rejectAdoptionRequest(AdoptionRequestModel adoptionRequest) {
    // TODO: implement rejectAdoptionRequest
    throw UnimplementedError();
  }

  @override
  Future<void> unlockAnimal(AnimalModel animal) {
    // TODO: implement unlockAnimal
    throw UnimplementedError();
  }

  @override
  Future<void> upadte(AnimalModel animal) {
    // TODO: implement upadte
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAdoptionRequest(AdoptionRequestModel adoptionRequest) {
    // TODO: implement deleteAdoptionRequest
    throw UnimplementedError();
  }
}
