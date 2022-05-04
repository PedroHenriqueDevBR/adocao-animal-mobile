import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_photo_model.dart';

abstract class IAnimalImage {
  Future<List<AnimalPhotoModel>> allPhotosFromAnimal(AnimalModel animal);

  Future<AnimalPhotoModel> addPhoto(AnimalModel animal, String pat);

  Future<void> removePhoto(AnimalPhotoModel photo);
}
