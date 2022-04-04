import 'package:adocao_local/src/modules/account/models/city_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CityModel cityModel;

  setUpAll(() {
    cityModel = CityModel(name: 'name');
  });

  group('Testes de instaciacao', () {
    test('Id deve ser nulo', () {
      expect(cityModel.id, isNull);
    });
  });

  group('Conversão dos dados', () {
    test('Deve converter de map para objeto', () {
      final city = CityModel.fromMap(cityMap);
      expect(city.id, equals(1));
      expect(city.name, equals('Teresina'));
    });

    test('Deve converter uma lista de map para lista de objetos', () {
      final cityList = CityModel.fromMapList(cityMapList);
      expect(cityList.length, equals(4));
      expect(cityList.first.id, equals(1));
      expect(cityList.first.name, equals('Teresina'));
    });
  });
}

Map<String, dynamic> cityMap = {"id": 1, "name": "Teresina", "state": "Piauí"};

List<Map<String, dynamic>> cityMapList = [
  {"id": 1, "name": "Teresina", "state": "Piauí"},
  {"id": 2, "name": "Campo Maior", "state": "Piauí"},
  {"id": 3, "name": "Picos", "state": "Piauí"},
  {"id": 4, "name": "União", "state": "Piauí"}
];
