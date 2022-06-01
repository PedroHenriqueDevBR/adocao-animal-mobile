import 'package:adocao_local/src/modules/animal/interfaces/animal_type_interface.dart';
import 'package:adocao_local/src/modules/animal/models/animal_type_model.dart';
import 'package:adocao_local/src/shares/exceptions/http_response_exception.dart';
import 'package:adocao_local/src/shares/exceptions/unauthorized_exception.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:adocao_local/src/shares/interfaces/client_http_interface.dart';
import 'package:adocao_local/src/shares/models/http_response_model.dart';
import 'package:flutter/foundation.dart';

class AnimalTypeRepository implements IAnimalTypeStorage {
  final IClientHTTP _client;
  final IAppData _appData;

  AnimalTypeRepository({required IClientHTTP client, required IAppData appData})
      : _client = client,
        _appData = appData;

  @override
  Future<List<AnimalTypeModel>> allTypes() async {
    const path = 'animal/all_types';
    final jwtKey = await _appData.getJWT();

    try {
      final response = await _client.get(path, jwtKey: jwtKey);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return AnimalTypeModel.fromMapList(response.data);
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
    } on HttpResponseException catch (error) {
      if (error.response.statusCode == 401) throw UnauthorizedException();
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
