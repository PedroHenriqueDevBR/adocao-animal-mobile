import 'dart:io';

import '../interfaces/user_interface.dart';
import '../models/auth_token_model.dart';
import '../models/user_model.dart';
import '../../../shares/interfaces/app_data_interface.dart';
import '../../../shares/interfaces/client_http_interface.dart';

class UserRepository implements IUser {
  final IClientHTTP _client;
  final IAppData _appData;

  UserRepository({required IClientHTTP client, required IAppData appData})
      : _client = client,
        _appData = appData;

  @override
  Future<UserModel> getLoggedUserData() async {
    const path = 'user/';
    final jwtKey = await _appData.getJWT();
    final response = await _client.get(path, jwtKey: jwtKey);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return UserModel.fromMap(response.data);
    } else {
      throw HttpException(
        'ERRO: buscar dados do usuário',
        uri: Uri(path: path),
      );
    }
  }

  @override
  Future<AuthTokenModel> login(String username, String password) async {
    const path = 'user/login/';
    final response = await _client.post(path, {
      "username": username,
      "password": password,
    });
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return AuthTokenModel.fromJson(response.data);
    } else {
      throw HttpException(
        'ERRO: User login <<< ${response.statusCode} >>>',
        uri: Uri(path: path),
      );
    }
  }

  @override
  Future<void> removeImage() async {
    const path = 'user/image/';
    final jwtKey = await _appData.getJWT();
    final response = await _client.delete(path, jwtKey: jwtKey);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(
        'ERRO: remove user image',
        uri: Uri(path: path),
      );
    }
  }

  @override
  Future<void> updateData(UserModel user) async {
    const path = 'user/';
    final jwtKey = await _appData.getJWT();
    final response = await _client.put(path, user.toMap(), jwtKey: jwtKey);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(
        'ERRO: update user data',
        uri: Uri(path: path),
      );
    }
  }

  @override
  Future<void> updatePassword(UserModel user) {
    throw UnimplementedError();
  }

  @override
  Future<String> updateImage(UserModel user) {
    throw UnimplementedError();
  }
}
