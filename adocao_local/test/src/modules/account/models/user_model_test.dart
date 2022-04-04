import 'package:adocao_local/src/modules/account/models/city_model.dart';
import 'package:adocao_local/src/modules/account/models/user_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_type_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UserModel userModel;

  setUpAll(() {
    CityModel cityModel = CityModel(id: 1, name: 'Name');
    userModel = UserModel(
      username: 'pedro',
      name: 'Pedro Henrique',
      city: cityModel,
    );
  });

  group('Testes de instanciacao', () {
    test('A instancia deve ser possivel com o minimo de atributos fornecidos!',
        () {
      expect(userModel, isA<UserModel>());
    });

    test('Os atributos listas devem estar vazios', () {
      expect(userModel.animals, isEmpty);
      expect(userModel.id, isNull);
      expect(userModel.password, isNull);
      expect(userModel.contact, isNull);
      expect(userModel.image, isNull);
    });

    test('Deve ser possivel adicionar um novo animal', () {
      userModel.animals.add(
        AnimalModel(
          name: 'name',
          breed: 'breed',
          age: 0,
          sex: 'M',
          animalType: AnimalTypeModel(name: 'name'),
        ),
      );

      expect(userModel.animals.length, equals(1));
    });

    test('City deve possuir ID', () {
      expect(userModel.city, isNotNull);
      expect(userModel.city.id, equals(1));
    });
  });

  group('Conversão dos dados', () {
    test('Deve converter de map para objeto', () {
      final userModel = UserModel.fromMap(userMap);
      expect(userModel.id, equals(1));
      expect(userModel.username, equals('pedro'));
      expect(userModel.name, equals('Pedro Henrique de Lima Ribeiro'));
      expect(userModel.password, isNull);
      expect(userModel.contact, equals('(86) 98863-9775'));
      expect(userModel.city.id, equals(1));
      expect(userModel.city.name, equals('Teresina'));
      expect(userModel.animals, isEmpty);
      expect(
        userModel.image,
        equals('/media/7803c778-16d7-4dea-8b57-3a79f892e80c-avatar.svg'),
      );
    });
  });
}

Map<String, dynamic> userMap = {
  "id": 1,
  "image": "/media/7803c778-16d7-4dea-8b57-3a79f892e80c-avatar.svg",
  "name": "Pedro Henrique de Lima Ribeiro",
  "username": "pedro",
  "contact": "(86) 98863-9775",
  "latitude": "-5.0914818",
  "longitude": "-42.8371654",
  "is_moderator": false,
  "is_active": true,
  "is_admin": false,
  "city": {"id": 1, "name": "Teresina", "state": 1},
};
