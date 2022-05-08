import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_type_model.dart';
import 'package:adocao_local/src/modules/animal/repositories/animal_repository.dart';
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

  AnimalRepository _repository = AnimalRepository(
    client: _client,
    appData: _appData,
  );

  test('Deve retornar a lista de animais pertencetes ao usuario logado',
      () async {
    when(() => _client.get(any(), jwtKey: any(named: 'jwtKey'))).thenAnswer(
      (_) async => HttpResponseModel(
        statusCode: 200,
        data: allAnimals,
        headers: {},
      ),
    );
    when(() => _appData.getJWT()).thenAnswer(
      (_) async => 'some_key',
    );

    List<AnimalModel> response = await _repository.allAnimals();
    expect(response.length, equals(3));
    expect(response[0].id, equals(1));
    expect(response[0].name, equals('Rex'));
    expect(response[0].sex, equals('M'));
    expect(response[0].age, equals(1));
    expect(response[0].adopted, equals(true));
    expect(response[0].blocked, equals(false));
    expect(response[0].formattedCreateAt, equals('27/03/2022'));
    expect(response[0].animalType.name, equals('Cachorro'));
    expect(response[0].photos.length, equals(1));
    expect(response[0].vaccines.length, equals(1));
  });

  test('Deve retornar os dados do animal cadastrado', () async {
    when(() => _client.post(any(), any(), jwtKey: any(named: 'jwtKey')))
        .thenAnswer(
      (_) async => HttpResponseModel(
        statusCode: 200,
        data: createdAndUpdatedResponse,
        headers: {},
      ),
    );
    when(() => _appData.getJWT()).thenAnswer(
      (_) async => 'some_key',
    );

    final animal = AnimalModel(
      name: 'Rex',
      breed: 'Vira lata',
      age: 1,
      sex: 'M',
      animalType: AnimalTypeModel(id: 1, name: 'Doguinho'),
    );

    AnimalModel response = await _repository.create(animal);
    expect(response.id, equals(4));
    expect(response.name, equals('Doguinho'));
    expect(response.sex, equals('M'));
    expect(response.age, equals(1));
    expect(response.adopted, equals(false));
    expect(response.blocked, equals(false));
    expect(response.formattedCreateAt, isNotNull);
    expect(response.animalType.name, equals('Cachorro'));
    expect(response.photos.length, equals(0));
    expect(response.vaccines.length, equals(0));
  });

  test('Deve retornar void nos dados do animal editado', () async {
    when(() => _client.put(any(), any(), jwtKey: any(named: 'jwtKey')))
        .thenAnswer(
      (_) async => HttpResponseModel(
        statusCode: 200,
        headers: {},
      ),
    );
    when(() => _appData.getJWT()).thenAnswer(
      (_) async => 'some_key',
    );

    final animal = AnimalModel(
      id: 4,
      name: 'Rex',
      breed: 'Vira lata',
      age: 1,
      sex: 'M',
      animalType: AnimalTypeModel(id: 1, name: 'Doguinho'),
    );

    await _repository.upadte(animal);
  });

  test('Deve retornar void ao deletar o animal', () async {
    when(() => _client.delete(any(), jwtKey: any(named: 'jwtKey'))).thenAnswer(
      (_) async => HttpResponseModel(
        statusCode: 200,
        headers: {},
      ),
    );
    when(() => _appData.getJWT()).thenAnswer(
      (_) async => 'some_key',
    );

    final animal = AnimalModel(
      id: 4,
      name: 'Rex',
      breed: 'Vira lata',
      age: 1,
      sex: 'M',
      animalType: AnimalTypeModel(id: 1, name: 'Doguinho'),
    );

    await _repository.delete(animal);
  });

  test('Deve retornar void ao bloquear animal', () async {
    when(() => _client.patch(any(), any(), jwtKey: any(named: 'jwtKey')))
        .thenAnswer(
      (_) async => HttpResponseModel(
        statusCode: 200,
        headers: {},
      ),
    );
    when(() => _appData.getJWT()).thenAnswer(
      (_) async => 'some_key',
    );

    final animal = AnimalModel(
      id: 4,
      name: 'Rex',
      breed: 'Vira lata',
      age: 1,
      sex: 'M',
      animalType: AnimalTypeModel(id: 1, name: 'Doguinho'),
    );

    await _repository.blockAnimal(animal);
  });

  test('Deve retornar void ao desbloquear animal', () async {
    when(() => _client.patch(any(), any(), jwtKey: any(named: 'jwtKey')))
        .thenAnswer(
      (_) async => HttpResponseModel(
        statusCode: 200,
        headers: {},
      ),
    );
    when(() => _appData.getJWT()).thenAnswer(
      (_) async => 'some_key',
    );

    final animal = AnimalModel(
      id: 4,
      name: 'Rex',
      breed: 'Vira lata',
      age: 1,
      sex: 'M',
      animalType: AnimalTypeModel(id: 1, name: 'Doguinho'),
    );

    await _repository.unlockAnimal(animal);
  });
}

final createdAndUpdatedResponse = {
  "id": 4,
  "name": "Doguinho",
  "breed": "Vira lata",
  "age": 1,
  "sex": "M",
  "owner": 1,
  "type": 'Cachorro',
};

final allAnimals = [
  {
    "id": 1,
    "name": "Rex",
    "breed": "Viralata",
    "age": 1,
    "sex": "M",
    "adopted": true,
    "blocked": false,
    "create_at": "2022-03-27",
    "owner": {
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
    },
    "type": "Cachorro",
    "all_photos": [
      {
        "id": 5,
        "photo":
            "/media/71d3099b-37ea-4023-bd49-2403f7f4eb3a-IMG_20220131_132118_706.jpg",
        "animal": 1
      }
    ],
    "all_vaccines": [
      {"id": 2, "vaccine_name": "Vermicida", "date": "2022-03-27", "animal": 1}
    ]
  },
  {
    "id": 2,
    "name": "Pandora",
    "breed": "Viralata",
    "age": 2,
    "sex": "F",
    "adopted": false,
    "blocked": false,
    "create_at": "2022-04-04",
    "owner": {
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
    },
    "type": "Gato",
    "all_photos": [
      {
        "id": 3,
        "photo": "/media/b0d5bcb5-485e-4347-ab5a-a42e6910b349-gato-0.jpeg",
        "animal": 2
      },
      {
        "id": 4,
        "photo": "/media/82b73168-fa90-427c-a8cb-ebcd57e247a2-gato-1.jpeg",
        "animal": 2
      }
    ],
    "all_vaccines": [
      {"id": 3, "vaccine_name": "Verme", "date": "2022-04-04", "animal": 2}
    ]
  },
  {
    "id": 3,
    "name": "Benedito",
    "breed": "Viralata",
    "age": 3,
    "sex": "M",
    "adopted": false,
    "blocked": false,
    "create_at": "2022-04-04",
    "owner": {
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
    },
    "type": "Cachorro",
    "all_photos": [
      {
        "id": 6,
        "photo": "/media/93ca9f76-35b4-405d-9570-3d096722e188-dog-0.jpg",
        "animal": 3
      }
    ],
    "all_vaccines": []
  }
];
