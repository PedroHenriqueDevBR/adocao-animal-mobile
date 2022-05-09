import 'package:adocao_local/src/modules/animal/interfaces/animal_image_interface.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_photo_model.dart';
import 'package:adocao_local/src/shares/exceptions/http_response_exception.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:adocao_local/src/shares/interfaces/client_http_interface.dart';
import 'package:adocao_local/src/shares/models/http_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class AnimalImageRepository implements IAnimalImageStorage {
  final IClientHTTP _client;
  final IAppData _appData;

  AnimalImageRepository(
      {required IClientHTTP client, required IAppData appData})
      : _client = client,
        _appData = appData;

  @override
  Future<AnimalPhotoModel> addPhoto(AnimalModel animal, String path) async {
    const uri = 'animal/photo';
    final jwtKey = await _appData.getJWT();
    Map<String, String> animalData = {'animal': animal.id};
    try {
      final file = await MultipartFile.fromPath('image', path);
      final response = await _client.multipartFormData(
        uri,
        file,
        animalData,
        jwtKey: jwtKey,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return AnimalPhotoModel.fromMap(response.data);
      } else {
        throw HttpResponseException(
          response: HttpResponseModel(
            statusCode: response.statusCode,
            data: response.data,
          ),
        );
      }
    } catch (error) {
      if (kDebugMode) {
        print('======================================');
        print(error);
        print('======================================');
      }
      rethrow;
    }
  }

  @override
  Future<List<AnimalPhotoModel>> allPhotosFromAnimal(AnimalModel animal) {
    throw UnimplementedError();
  }

  @override
  Future<void> removePhoto(AnimalPhotoModel photo) async {
    final path = 'animal/photo/${photo.id}';
    final jwtKey = await _appData.getJWT();
    final response = await _client.delete(path, jwtKey: jwtKey);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      if (kDebugMode) {
        print('ERRO: remove animal photo');
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
