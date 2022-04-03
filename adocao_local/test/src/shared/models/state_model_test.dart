import 'package:adocao_local/src/modules/account/models/city_model.dart';
import 'package:adocao_local/src/modules/account/models/state_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late StateModel stateModel;

  setUpAll(() {
    stateModel = StateModel(name: 'name');
  });

  group('Testes de instaciacao', () {
    test('Id deve ser nulo', () {
      expect(stateModel.id, isNull);
    });

    test('A lista de cidades deve estar vazia', () {
      expect(stateModel.cities, isEmpty);
    });

    test('Deve ser possivel adicionar uma nova cidade na lista', () {
      CityModel cityModel = CityModel(name: 'name');
      stateModel.cities.add(cityModel);
      expect(stateModel.cities.length, equals(1));
    });
  });
}
