import 'package:adocao_local/src/shares/models/vaccine_book_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Deve ser possivel instanciar com o minimo de atributos', () {
    final vaccineModel = VaccineModel(name: 'name');
    expect(vaccineModel.id, isNull);
    expect(vaccineModel.date, isNotNull);
  });

  test('Deve ser possivel instanciar com uma data inicial', () {
    final date = DateTime.now();
    final vaccineModel = VaccineModel(name: 'name', date: date);
    expect(vaccineModel.id, isNull);
    expect(vaccineModel.date, equals(date));
  });
}
