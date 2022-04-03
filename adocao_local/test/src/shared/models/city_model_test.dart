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
}
