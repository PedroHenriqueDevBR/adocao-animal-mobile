import 'package:adocao_local/src/modules/animal/models/vaccine_book_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Deve ser possivel instanciar com o minimo de atributos!', () {
    final vaccineModel = VaccineModel(name: 'name');
    expect(vaccineModel.id, isNull);
  });
}
