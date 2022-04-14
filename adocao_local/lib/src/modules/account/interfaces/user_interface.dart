import 'package:adocao_local/src/modules/account/models/auth_token_model.dart';
import 'package:adocao_local/src/modules/account/models/user_model.dart';

abstract class IUserStorage {
  Future<AuthTokenModel> login(String username, String password);

  Future<void> registerUser(UserModel user);

  Future<UserModel> getLoggedUserData();

  Future<void> updateData(UserModel user);

  Future<void> updatePassword(UserModel user);

  Future<UserModel> updateImage(String path);

  Future<void> removeImage();
}
