import 'package:adocao_local/src/modules/account/interfaces/location_interface.dart';
import 'package:adocao_local/src/modules/account/models/state_model.dart';
import 'package:adocao_local/src/shares/exceptions/http_response_exception.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:adocao_local/src/shares/interfaces/client_http_interface.dart';
import 'package:adocao_local/src/shares/models/http_response_model.dart';
import 'package:flutter/foundation.dart';

class LocationRepository implements ILocationStorage {
  final IClientHTTP _client;
  final IAppData _appData;

  LocationRepository({required IClientHTTP client, required IAppData appData})
      : _client = client,
        _appData = appData;

  @override
  Future<List<StateModel>> getStates() async {
    const path = 'location';
    final response = await _client.get(path);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return StateModel.fromMapList(response.data);
    } else {
      if (kDebugMode) {
        print('ERRO: buscar lista de estados');
      }
      throw HttpResponseException(
        response: HttpResponseModel(
          statusCode: response.statusCode,
          data: response.data,
        ),
      );
    }
  }
}
