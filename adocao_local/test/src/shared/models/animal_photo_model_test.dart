import 'package:adocao_local/src/shares/models/animal_photo_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Deve ser possivel instanciar com o minimo de atributos!', () {
    final animalPhotoModel = AnimalPhotoModel(url: 'name');
    expect(animalPhotoModel.id, isNull);
  });
}
