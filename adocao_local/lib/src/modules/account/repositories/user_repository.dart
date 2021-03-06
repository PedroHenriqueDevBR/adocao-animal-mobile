import 'package:adocao_local/src/shares/exceptions/http_response_exception.dart';
import 'package:adocao_local/src/shares/exceptions/unauthorized_exception.dart';
import 'package:adocao_local/src/shares/models/http_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../interfaces/user_interface.dart';
import '../models/auth_token_model.dart';
import '../models/user_model.dart';
import '../../../shares/interfaces/app_data_interface.dart';
import '../../../shares/interfaces/client_http_interface.dart';

class UserRepository implements IUserStorage {
  final IClientHTTP _client;
  final IAppData _appData;

  UserRepository({required IClientHTTP client, required IAppData appData})
      : _client = client,
        _appData = appData;

  @override
  Future<UserModel> getLoggedUserData() async {
    const path = 'user/';
    final jwtKey = await _appData.getJWT();
    try {
      final response = await _client.get(path, jwtKey: jwtKey);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return UserModel.fromMap(response.data);
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

  @override
  Future<AuthTokenModel> login(String username, String password) async {
    const path = 'user/login/';
    try {
      final response = await _client.post(path, {
        "username": username,
        "password": password,
      });
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return AuthTokenModel.fromJson(response.data);
      } else {
        if (kDebugMode) {
          print('ERRO: User login <<< ${response.statusCode} >>>');
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
  Future<void> registerUser(UserModel user) async {
    const path = 'user/register';
    final data = user.toRegisterMap();
    try {
      final response = await _client.post(path, data);
      if (response.statusCode < 200 || response.statusCode >= 300) {
        if (kDebugMode) {
          print('ERRO: User register <<< ${response.statusCode} >>>');
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
  Future<void> removeImage() async {
    const path = 'user/image/';
    final jwtKey = await _appData.getJWT();
    try {
      final response = await _client.delete(path, jwtKey: jwtKey);
      if (response.statusCode < 200 || response.statusCode >= 300) {
        if (kDebugMode) {
          print('ERRO: remove user image');
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
  Future<void> updateData(UserModel user) async {
    const path = 'user/';
    final jwtKey = await _appData.getJWT();
    try {
      final response =
          await _client.put(path, user.toUpdateMap(), jwtKey: jwtKey);
      if (response.statusCode < 200 || response.statusCode >= 300) {
        if (kDebugMode) {
          print('ERRO: update user data');
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
  Future<void> updatePassword(UserModel user) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> updateImage(String imagePath) async {
    const uri = 'user/image/';
    final jwtKey = await _appData.getJWT();
    try {
      final file = await MultipartFile.fromPath('image', imagePath);
      final response = await _client.multipartFormImage(
        uri,
        file,
        jwtKey: jwtKey,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return UserModel.fromMap(response.data);
      } else {
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
