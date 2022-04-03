import 'package:adocao_local/src/shares/models/animal_model.dart';
import 'package:adocao_local/src/shares/models/animal_type_model.dart';
import 'package:adocao_local/src/shares/models/city_model.dart';
import 'package:adocao_local/src/shares/models/user_model.dart';
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
}
