import 'package:adocao_local/src/modules/animal/models/animal_type_model.dart';
import 'package:adocao_local/src/modules/animal/repositories/animal_type_repository.dart';
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

  AnimalTypeRepository _repository = AnimalTypeRepository(
    client: _client,
    appData: _appData,
  );

  test('Deve retornar uma lista de tipo de animais', () async {
    when(() => _client.get(any(), jwtKey: any(named: 'jwtKey'))).thenAnswer(
      (_) async => HttpResponseModel(
        statusCode: 200,
        data: typeList,
        headers: {},
      ),
    );
    when(() => _appData.getJWT()).thenAnswer(
      (_) async => 'some_key',
    );

    List<AnimalTypeModel> response = await _repository.allTypes();
    expect(response.length, equals(2));
    expect(response[0].id, equals(1));
    expect(response[0].name, equals('Cachorro'));
  });
}

List<Map<String, dynamic>> typeList = [
  {"id": 1, "name": "Cachorro"},
  {"id": 2, "name": "Gato"}
];
