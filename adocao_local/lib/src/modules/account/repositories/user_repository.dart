import 'package:adocao_local/src/modules/account/interfaces/user_interface.dart';
import 'package:adocao_local/src/modules/account/models/auth_token_model.dart';
import 'package:adocao_local/src/modules/account/models/user_model.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:adocao_local/src/shares/interfaces/client_http_interface.dart';

class UserRepository implements IUser {
  final IClientHTTP _client;
  final IAppData _appData;

  UserRepository({required IClientHTTP client, required IAppData appData})
      : _client = client,
        _appData = appData;

  @override
  Future<UserModel> getLoggedUserData() {
    // TODO: implement getLoggedUserData
    throw UnimplementedError();
  }

  @override
  Future<AuthTokenModel> login(String username, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> removeImage() {
    // TODO: implement removeImage
    throw UnimplementedError();
  }

  @override
  Future<void> updateData(UserModel user) {
    // TODO: implement updateData
    throw UnimplementedError();
  }

  @override
  Future<String> updateImage(UserModel user) {
    // TODO: implement updateImage
    throw UnimplementedError();
  }

  @override
  Future<void> updatePassword(UserModel user) {
    // TODO: implement updatePassword
    throw UnimplementedError();
  }
}
