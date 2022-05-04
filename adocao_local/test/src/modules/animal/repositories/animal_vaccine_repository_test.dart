import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_type_model.dart';
import 'package:adocao_local/src/modules/animal/models/vaccine_book_model.dart';
import 'package:adocao_local/src/modules/animal/repositories/animal_vaccine_repository.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:adocao_local/src/shares/interfaces/client_http_interface.dart';
import 'package:adocao_local/src/shares/models/http_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class HttpMock extends Mock implements IClientHTTP {}

class JwtMock extends Mock implements IAppData {}

void main() {
  final _client = HttpMock();
  final _appData = JwtMock();

  AnimalVaccineRepository _repository = AnimalVaccineRepository(
    client: _client,
    appData: _appData,
  );

  test('Deve retornar um objeto do tipo vacina', () async {
    when(() => _client.post(any(), any(), jwtKey: any(named: 'jwtKey')))
        .thenAnswer(
      (_) async => HttpResponseModel(
        statusCode: 200,
        data: addedVaccineResponse,
        headers: {},
      ),
    );
    when(() => _appData.getJWT()).thenAnswer(
      (_) async => 'some_key',
    );

    AnimalModel animal = AnimalModel(
      name: '',
      breed: '',
      age: 1,
      sex: '',
      animalType: AnimalTypeModel(name: 'name'),
    );
    VaccineModel vaccine = VaccineModel(name: 'name');
    VaccineModel response = await _repository.addVaccine(
      vaccine,
      animal,
    );
    expect(response.id, equals(4));
    expect(response.name, equals('Vacina teste'));
    expect(response.date!.day, equals(17));
    expect(response.date!.month, equals(4));
    expect(response.date!.year, equals(2022));
  });

  test('Deve remover a vacina e retornar void', () async {
    when(() => _client.delete(any(), jwtKey: any(named: 'jwtKey'))).thenAnswer(
      (_) async => HttpResponseModel(
        statusCode: 200,
        headers: {},
      ),
    );
    when(() => _appData.getJWT()).thenAnswer(
      (_) async => 'some_key',
    );

    VaccineModel vaccine = VaccineModel(name: 'name');
    await _repository.removeVaccine(vaccine);
  });
}

Map<String, dynamic> addedVaccineResponse = {
  "id": 4,
  "vaccine_name": "Vacina teste",
  "date": "2022-04-17",
  "animal": 1
};
