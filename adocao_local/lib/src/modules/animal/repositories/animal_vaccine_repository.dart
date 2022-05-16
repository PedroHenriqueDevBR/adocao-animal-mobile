import 'package:adocao_local/src/modules/animal/interfaces/animal_vaccine_interface.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/models/vaccine_book_model.dart';
import 'package:adocao_local/src/shares/exceptions/http_response_exception.dart';
import 'package:adocao_local/src/shares/exceptions/unauthorized_exception.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:adocao_local/src/shares/interfaces/client_http_interface.dart';
import 'package:adocao_local/src/shares/models/http_response_model.dart';
import 'package:flutter/foundation.dart';

class AnimalVaccineRepository implements IAnimalVaccineStorage {
  final IClientHTTP _client;
  final IAppData _appData;

  AnimalVaccineRepository(
      {required IClientHTTP client, required IAppData appData})
      : _client = client,
        _appData = appData;

  @override
  Future<VaccineModel> addVaccine(
      VaccineModel vaccine, AnimalModel animal) async {
    const path = 'animal/vaccine';
    final jwtKey = await _appData.getJWT();

    try {
      final response =
          await _client.post(path, vaccine.toMap(animal), jwtKey: jwtKey);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return VaccineModel.fromMap(response.data);
      } else {
        if (kDebugMode) {
          print('ERRO: adicionar vacina');
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
  Future<List<VaccineModel>> allVaccinesFromAnimal(AnimalModel animal) async {
    throw UnimplementedError();
  }

  @override
  Future<void> removeVaccine(VaccineModel vaccine) async {
    final path = 'animal/vaccine/${vaccine.id}';
    final jwtKey = await _appData.getJWT();

    try {
      final response = await _client.delete(path, jwtKey: jwtKey);

      if (response.statusCode < 200 || response.statusCode >= 300) {
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
    } on HttpResponseException catch (error) {
      if (error.response.statusCode == 401) throw UnauthorizedException();
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
