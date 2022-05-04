import 'package:adocao_local/src/modules/animal/interfaces/animal_interface.dart';
import 'package:adocao_local/src/modules/animal/models/adoption_request_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/shares/exceptions/http_response_exception.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:adocao_local/src/shares/interfaces/client_http_interface.dart';
import 'package:adocao_local/src/shares/models/http_response_model.dart';
import 'package:flutter/foundation.dart';

class AnimalRepository implements IAnimal {
  final IClientHTTP _client;
  final IAppData _appData;

  AnimalRepository({required IClientHTTP client, required IAppData appData})
      : _client = client,
        _appData = appData;

  @override
  Future<List<AnimalModel>> allAnimals() async {
    const path = 'animal/my';
    final jwtKey = await _appData.getJWT();

    final response = await _client.get(path, jwtKey: jwtKey);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return AnimalModel.fromMapList(response.data);
    } else {
      if (kDebugMode) {
        print('ERRO: buscar dados do usuário');
      }
      throw HttpResponseException(
        response: HttpResponseModel(
          statusCode: response.statusCode,
          data: response.data,
        ),
      );
    }
  }

  @override
  Future<List<AdoptionRequestModel>> allAdoptionRequestFromAnimal(
    AnimalModel animal,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<void> blockAnimal(AnimalModel animal) async {
    // TODO: implement blockAnimal
    throw UnimplementedError();
  }

  @override
  Future<void> confirmAdoptionRequest(
      AdoptionRequestModel adoptionRequest) async {
    // TODO: implement confirmAdoptionRequest
    throw UnimplementedError();
  }

  @override
  Future<AnimalModel> create(AnimalModel animal) async {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(AnimalModel animal) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> rejectAdoptionRequest(
      AdoptionRequestModel adoptionRequest) async {
    // TODO: implement rejectAdoptionRequest
    throw UnimplementedError();
  }

  @override
  Future<void> unlockAnimal(AnimalModel animal) async {
    // TODO: implement unlockAnimal
    throw UnimplementedError();
  }

  @override
  Future<void> upadte(AnimalModel animal) async {
    // TODO: implement upadte
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAdoptionRequest(
      AdoptionRequestModel adoptionRequest) async {
    // TODO: implement deleteAdoptionRequest
    throw UnimplementedError();
  }
}
