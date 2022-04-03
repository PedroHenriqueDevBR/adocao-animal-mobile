import 'package:adocao_local/src/modules/account/models/city_model.dart';
import 'package:adocao_local/src/modules/account/models/user_model.dart';
import 'package:adocao_local/src/modules/animal/models/adoption_request_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_photo_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_type_model.dart';
import 'package:adocao_local/src/modules/animal/models/vaccine_book_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AnimalModel animalModel;

  setUpAll(() {
    final animalType = AnimalTypeModel(name: 'name');
    animalModel = AnimalModel(
      name: 'name',
      breed: 'breed',
      age: 0,
      sex: 'M',
      animalType: animalType,
    );
  });

  test('Os atributos devem ser validos', () {
    expect(animalModel.id, isNull);
    expect(animalModel.adopted, false);
    expect(animalModel.blocked, false);
    expect(animalModel.photos, isEmpty);
    expect(animalModel.vaccines, isEmpty);
    expect(animalModel.requests, isEmpty);
    expect(animalModel.createAt, isNotNull);
  });

  test('Deve ser possivel adicionar dados nas listas', () {
    animalModel.photos.add(AnimalPhotoModel(url: 'url'));
    animalModel.vaccines.add(VaccineModel(name: 'name'));

    final city = CityModel(
      name: 'name',
    );
    final requester = UserModel(
      id: 1,
      username: 'username',
      name: 'name',
      city: city,
    );
    animalModel.requests.add(
        AdoptionRequestModel(createAt: DateTime.now(), requester: requester));

    expect(animalModel.photos.length, equals(1));
    expect(animalModel.vaccines.length, equals(1));
    expect(animalModel.requests.length, equals(1));
  });

  test('O formato da data deve ser 00/00/0000', () {
    final now = DateTime.now();
    animalModel.createAt = now;
    expect(
      animalModel.formattedCreateAt,
      equals('${now.day}/${now.month}/${now.year}'),
    );
  });
}
