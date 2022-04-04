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

  group('Conversão dos dados', () {
    test('Deve converter de map para objeto', () {
      final state = StateModel.fromMap(stateMap);
      expect(state.id, equals(1));
      expect(state.name, equals('Piauí'));
    });

    test('Deve converter uma lista de map para lista de objetos', () {
      final stateList = StateModel.fromMapList(stateMapList);
      expect(stateList.length, equals(2));
      expect(stateList.first.id, equals(1));
      expect(stateList.first.name, equals('Piauí'));
      expect(stateList.first.cities.length, equals(4));
      expect(stateList.first.cities.first.id, equals(1));
      expect(stateList.first.cities.first.name, equals('Teresina'));
    });
  });
}

Map<String, dynamic> stateMap = {
  "id": 1,
  "name": "Piauí",
  "cities": [
    {"id": 1, "name": "Teresina", "state": "Piauí"},
    {"id": 2, "name": "Campo Maior", "state": "Piauí"},
    {"id": 3, "name": "Picos", "state": "Piauí"},
    {"id": 4, "name": "União", "state": "Piauí"}
  ]
};

List<Map<String, dynamic>> stateMapList = [
  {
    "id": 1,
    "name": "Piauí",
    "cities": [
      {"id": 1, "name": "Teresina", "state": "Piauí"},
      {"id": 2, "name": "Campo Maior", "state": "Piauí"},
      {"id": 3, "name": "Picos", "state": "Piauí"},
      {"id": 4, "name": "União", "state": "Piauí"}
    ]
  },
  {
    "id": 2,
    "name": "Maranhão",
    "cities": [
      {"id": 5, "name": "Timon", "state": "Maranhão"},
      {"id": 6, "name": "São Luís", "state": "Maranhão"}
    ]
  }
];
