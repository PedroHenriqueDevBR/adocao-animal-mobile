import 'package:adocao_local/src/modules/animal/interfaces/animal_request_interface.dart';
import 'package:adocao_local/src/modules/animal/models/adoption_request_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/shares/exceptions/http_response_exception.dart';
import 'package:adocao_local/src/shares/exceptions/unauthorized_exception.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:adocao_local/src/shares/interfaces/client_http_interface.dart';
import 'package:adocao_local/src/shares/models/http_response_model.dart';
import 'package:flutter/foundation.dart';

class AnimalRequestRepository implements IAnimalRequestStorage {
  final IClientHTTP _client;
  final IAppData _appData;

  AnimalRequestRepository(
      {required IClientHTTP client, required IAppData appData})
      : _client = client,
        _appData = appData;

  @override
  Future<List<AdoptionRequestModel>> allAdoptionRequestFromAnimal(
    AnimalModel animal,
  ) async {
    final path = 'adoption/${animal.id}';
    final jwtKey = await _appData.getJWT();
    try {
      final response = await _client.get(path, jwtKey: jwtKey);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return AdoptionRequestModel.fromMapList(response.data);
      } else {
        if (kDebugMode) {
          print('ERRO: buscar animais do dono');
        }
        throw HttpResponseException(
          response: HttpResponseModel(
            statusCode: response.statusCode,
            data: response.data,
          ),
        );
      }
    } on HttpResponseException catch (error) {
      if (error.response.statusCode == 401) throw UnauthorizedException();
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> confirmAdoptionRequest(
    AnimalModel animal,
    AdoptionRequestModel adoptionRequest,
  ) async {
    final path = 'adoption/${animal.id}/accept/${adoptionRequest.id}';
    final jwtKey = await _appData.getJWT();

    try {
      final response = await _client.put(path, {}, jwtKey: jwtKey);

      if (!(response.statusCode >= 200 && response.statusCode < 300)) {
        if (kDebugMode) {
          print('ERRO: buscar animais do dono');
        }
        throw HttpResponseException(
          response: HttpResponseModel(
            statusCode: response.statusCode,
            data: response.data,
          ),
        );
      }
    } on HttpResponseException catch (error) {
      if (error.response.statusCode == 401) throw UnauthorizedException();
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> rejectAdoptionRequest(
    AnimalModel animal,
    AdoptionRequestModel adoptionRequest,
  ) async {
    final path = 'adoption/${animal.id}/reject/${adoptionRequest.id}';
    final jwtKey = await _appData.getJWT();
    try {
      final response = await _client.put(path, {}, jwtKey: jwtKey);
      if (!(response.statusCode >= 200 && response.statusCode < 300)) {
        if (kDebugMode) {
          print('ERRO: buscar animais do dono');
        }
        throw HttpResponseException(
          response: HttpResponseModel(
            statusCode: response.statusCode,
            data: response.data,
          ),
        );
      }
    } on HttpResponseException catch (error) {
      if (error.response.statusCode == 401) throw UnauthorizedException();
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAdoptionRequest(
    AnimalModel animal,
    AdoptionRequestModel adoptionRequest,
  ) async {
    final path = 'adoption/${animal.id}/delete/${adoptionRequest.id}';
    final jwtKey = await _appData.getJWT();
    try {
      final response = await _client.delete(path, jwtKey: jwtKey);

      if (!(response.statusCode >= 200 && response.statusCode < 300)) {
        if (kDebugMode) {
          print('ERRO: buscar animais do dono');
        }
        throw HttpResponseException(
          response: HttpResponseModel(
            statusCode: response.statusCode,
            data: response.data,
          ),
        );
      }
    } on HttpResponseException catch (error) {
      if (error.response.statusCode == 401) throw UnauthorizedException();
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
