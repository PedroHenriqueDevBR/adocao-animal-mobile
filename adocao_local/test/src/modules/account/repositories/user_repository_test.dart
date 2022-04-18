import 'package:adocao_local/src/modules/account/repositories/user_repository.dart';
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

  UserRepository _repository = UserRepository(
    client: _client,
    appData: _appData,
  );

  test('Deve retornar os dados do usuario logado!', () async {
    when(() => _client.get(any(), jwtKey: any(named: 'jwtKey'))).thenAnswer(
      (_) async => HttpResponseModel(
        statusCode: 200,
        data: loggedUserData,
        headers: {},
      ),
    );
    when(() => _appData.getJWT()).thenAnswer(
      (_) async => 'some_key',
    );

    await _repository.getLoggedUserData();
  });

  test(
    'Deve retornar as chaves JWT',
    () async {
      when(() => _client.post(any(), any())).thenAnswer(
        (_) async => HttpResponseModel(
          statusCode: 200,
          data: loginResponse,
          headers: {},
        ),
      );
      when(() => _appData.setJWT(any())).thenAnswer(
        (_) async {},
      );
      await _repository.login('pedro', 'senha@123');
    },
  );
}

Map<String, dynamic> loginResponse = {
  "refresh":
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYzMTkzMjM5MCwianRpIjoiZmVmNWFmZWNjOTdkNDE5M2JiMWM2M2U0NzA2MjFjMTYiLCJ1c2VyX2lkIjoxfQ.xgxWolul7o96CPaTrbYAITc1nmY1rshRpIGg1UdbUFE",
  "access":
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjI5ODU4NzkwLCJqdGkiOiJmZmI0NGE1MWNlZDA0MTc5OTdjMTg5ZDcwZmI1MWRmOSIsInVzZXJfaWQiOjF9.hfGwCmSbRXD-Y-kiQPuPAtgBZn3YlDkVcQ8NVU5F8ck"
};

Map<String, dynamic> loggedUserData = {
  "id": 1,
  "image":
      "/media/c366deca-6930-493b-b29d-2963a4a94c54-image_picker7475552330743245129.webp",
  "name": "Pedro Henrique",
  "username": "pedro",
  "contact": "(86) 98863-1234",
  "latitude": "-5.09147",
  "longitude": "-42.8371694",
  "is_moderator": false,
  "is_active": true,
  "is_admin": false,
  "city": {"id": 1, "name": "Teresina", "state": 1}
};
