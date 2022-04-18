import 'package:adocao_local/src/modules/animal/interfaces/animal_image_interface.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_photo_model.dart';

class AnimalImageRepository implements IAnimalImage {
  @override
  Future<AnimalPhotoModel> addPhoto(String path) {
    // TODO: implement addPhoto
    throw UnimplementedError();
  }

  @override
  Future<List<AnimalPhotoModel>> allPhotosFromAnimal(AnimalModel animal) {
    // TODO: implement allPhotosFromAnimal
    throw UnimplementedError();
  }

  @override
  Future<void> removePhoto(AnimalPhotoModel photo) {
    // TODO: implement removePhoto
    throw UnimplementedError();
  }
}
