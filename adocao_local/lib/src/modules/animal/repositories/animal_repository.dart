import 'package:adocao_local/src/modules/animal/interfaces/animal_interface.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/shares/exceptions/http_response_exception.dart';
import 'package:adocao_local/src/shares/exceptions/unauthorized_exception.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:adocao_local/src/shares/interfaces/client_http_interface.dart';
import 'package:adocao_local/src/shares/models/http_response_model.dart';
import 'package:flutter/foundation.dart';

class AnimalRepository implements IAnimalStorage {
  final IClientHTTP _client;
  final IAppData _appData;

  AnimalRepository({required IClientHTTP client, required IAppData appData})
      : _client = client,
        _appData = appData;

  @override
  Future<List<AnimalModel>> allAnimals() async {
    const path = 'animal/my';
    final jwtKey = await _appData.getJWT();

    try {
      final response = await _client.get(path, jwtKey: jwtKey);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return AnimalModel.fromMapList(response.data);
      } else if (response.statusCode >= 401) {
        return throw UnauthorizedException();
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
  Future<AnimalModel> create(AnimalModel animal) async {
    const path = 'animal/my';
    final jwtKey = await _appData.getJWT();

    try {
      final response = await _client.post(path, animal.toMap(), jwtKey: jwtKey);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return AnimalModel.fromMap(response.data);
      } else {
        if (kDebugMode) {
          print('ERRO: Cadastrar novo animal');
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
  Future<void> upadte(AnimalModel animal) async {
    final path = 'animal/my/${animal.id}';
    final jwtKey = await _appData.getJWT();

    try {
      final response = await _client.put(path, animal.toMap(), jwtKey: jwtKey);

      if (!(response.statusCode >= 200 && response.statusCode < 300)) {
        if (kDebugMode) {
          print('ERRO: Atualizar dados do animal');
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
  Future<void> delete(AnimalModel animal) async {
    final path = 'animal/my/${animal.id}';
    final jwtKey = await _appData.getJWT();

    try {
      final response = await _client.delete(path, jwtKey: jwtKey);

      if (!(response.statusCode >= 200 && response.statusCode < 300)) {
        if (kDebugMode) {
          print('ERRO: Deletar animal');
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
  Future<void> blockAnimal(AnimalModel animal) async {
    final path = 'animal/my/${animal.id}/block';
    final jwtKey = await _appData.getJWT();

    try {
      final response = await _client.patch(path, {}, jwtKey: jwtKey);

      if (!(response.statusCode >= 200 && response.statusCode < 300)) {
        if (kDebugMode) {
          print('ERRO: Bloquear animal');
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
  Future<void> unlockAnimal(AnimalModel animal) async {
    final path = 'animal/my/${animal.id}/unlock';
    final jwtKey = await _appData.getJWT();

    try {
      final response = await _client.patch(path, {}, jwtKey: jwtKey);

      if (!(response.statusCode >= 200 && response.statusCode < 300)) {
        if (kDebugMode) {
          print('ERRO: Desbloquear animal');
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
