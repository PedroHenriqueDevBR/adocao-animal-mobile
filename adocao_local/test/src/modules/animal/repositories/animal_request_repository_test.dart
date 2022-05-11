import 'package:adocao_local/src/modules/animal/models/adoption_request_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_type_model.dart';
import 'package:adocao_local/src/modules/animal/repositories/animal_request_repository.dart';
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

  AnimalRequestRepository _repository = AnimalRequestRepository(
    client: _client,
    appData: _appData,
  );

  test('deve retornar a lista e solicitações de adoção de um animal por ID',
      () async {
    when(() => _client.get(any(), jwtKey: any(named: 'jwtKey'))).thenAnswer(
      (_) async => HttpResponseModel(
        statusCode: 200,
        data: allAdoptionRequestsResponse,
        headers: {},
      ),
    );
    when(() => _appData.getJWT()).thenAnswer(
      (_) async => 'some_key',
    );

    AnimalModel animal = AnimalModel(
      id: 1,
      name: 'name',
      breed: 'breed',
      age: 1,
      sex: 'M',
      animalType: AnimalTypeModel(id: 1, name: 'name'),
    );
    List<AdoptionRequestModel> response =
        await _repository.allAdoptionRequestFromAnimal(animal);

    expect(response.length, equals(2));
    expect(response[0].id, equals(3));
    expect(response[0].formattedCreateAt, isA<String>());
    expect(response[0].formattedCreateAt, equals('10/05/2022'));
    expect(response[0].isAcepted, isNull);
    expect(response[0].requester.id, equals(6));
    expect(response[0].requester.image, isNull);
    expect(response[0].requester.name, equals('Aline da Silva'));
    expect(response[0].requester.contact, equals('(86) 91234-5678'));
    expect(response[0].requester.city.name, equals('Teresina'));
  });

  test('Deve aceitar a solicitação de adoção e retornar void', () async {
    when(() => _client.put(any(), any(), jwtKey: any(named: 'jwtKey')))
        .thenAnswer(
      (_) async => HttpResponseModel(
        statusCode: 200,
        data: allAdoptionRequestsResponse,
        headers: {},
      ),
    );
    when(() => _appData.getJWT()).thenAnswer(
      (_) async => 'some_key',
    );

    AnimalModel animal = AnimalModel(
      id: 1,
      name: 'name',
      breed: 'breed',
      age: 1,
      sex: 'M',
      animalType: AnimalTypeModel(id: 1, name: 'name'),
    );
    AdoptionRequestModel adoptionRequest =
        AdoptionRequestModel.fromMap(adoptionRequestExample);
    await _repository.confirmAdoptionRequest(animal, adoptionRequest);
  });

  test('Deve rejeitar a solicitação de adoção e retornar void', () async {
    when(() => _client.put(any(), any(), jwtKey: any(named: 'jwtKey')))
        .thenAnswer(
      (_) async => HttpResponseModel(
        statusCode: 200,
        data: allAdoptionRequestsResponse,
        headers: {},
      ),
    );
    when(() => _appData.getJWT()).thenAnswer(
      (_) async => 'some_key',
    );

    AnimalModel animal = AnimalModel(
      id: 1,
      name: 'name',
      breed: 'breed',
      age: 1,
      sex: 'M',
      animalType: AnimalTypeModel(id: 1, name: 'name'),
    );
    AdoptionRequestModel adoptionRequest =
        AdoptionRequestModel.fromMap(adoptionRequestExample);
    await _repository.rejectAdoptionRequest(animal, adoptionRequest);
  });

  test('Deve deletar a solicitação de adoção e retornar void', () async {
    when(() => _client.delete(any(), jwtKey: any(named: 'jwtKey'))).thenAnswer(
      (_) async => HttpResponseModel(
        statusCode: 200,
        data: allAdoptionRequestsResponse,
        headers: {},
      ),
    );
    when(() => _appData.getJWT()).thenAnswer(
      (_) async => 'some_key',
    );

    AnimalModel animal = AnimalModel(
      id: 1,
      name: 'name',
      breed: 'breed',
      age: 1,
      sex: 'M',
      animalType: AnimalTypeModel(id: 1, name: 'name'),
    );
    AdoptionRequestModel adoptionRequest =
        AdoptionRequestModel.fromMap(adoptionRequestExample);
    await _repository.deleteAdoptionRequest(animal, adoptionRequest);
  });
}

final adoptionRequestExample = {
  "id": 3,
  "create_at": "2022-05-10",
  "is_acepted": null,
  "requester": {
    "id": 6,
    "image": null,
    "name": "Aline da Silva",
    "username": "aline",
    "contact": "(86) 91234-5678",
    "latitude": "-5.0914727",
    "longitude": "-42.8371693",
    "is_moderator": false,
    "is_active": true,
    "is_admin": false,
    "city": {"id": 1, "name": "Teresina", "state": 1}
  },
  "animal": 3
};

final allAdoptionRequestsResponse = [
  {
    "id": 3,
    "create_at": "2022-05-10",
    "is_acepted": null,
    "requester": {
      "id": 6,
      "image": null,
      "name": "Aline da Silva",
      "username": "aline",
      "contact": "(86) 91234-5678",
      "latitude": "-5.0914727",
      "longitude": "-42.8371693",
      "is_moderator": false,
      "is_active": true,
      "is_admin": false,
      "city": {"id": 1, "name": "Teresina", "state": 1}
    },
    "animal": 3
  },
  {
    "id": 5,
    "create_at": "2022-05-11",
    "is_acepted": null,
    "requester": {
      "id": 7,
      "image": null,
      "name": "Tester",
      "username": "tester",
      "contact": "(86) 91234-5678",
      "latitude": "",
      "longitude": "",
      "is_moderator": false,
      "is_active": true,
      "is_admin": false,
      "city": {"id": 1, "name": "Teresina", "state": 1}
    },
    "animal": 3
  }
];

final acceptResponse = {
  "id": 3,
  "create_at": "2022-05-10",
  "is_acepted": true,
  "requester": {
    "id": 6,
    "image": null,
    "name": "Aline da Silva",
    "username": "aline",
    "contact": "(86) 91234-5678",
    "latitude": "-5.0914727",
    "longitude": "-42.8371693",
    "is_moderator": false,
    "is_active": true,
    "is_admin": false,
    "city": {"id": 1, "name": "Teresina", "state": 1}
  },
  "animal": 3
};

final rejectResponse = {
  "id": 3,
  "create_at": "2022-05-10",
  "is_acepted": false,
  "requester": {
    "id": 6,
    "image": null,
    "name": "Aline da Silva",
    "username": "aline",
    "contact": "(86) 91234-5678",
    "latitude": "-5.0914727",
    "longitude": "-42.8371693",
    "is_moderator": false,
    "is_active": true,
    "is_admin": false,
    "city": {"id": 1, "name": "Teresina", "state": 1}
  },
  "animal": 3
};
