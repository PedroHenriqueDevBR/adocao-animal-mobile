import 'package:adocao_local/src/modules/account/models/auth_token_model.dart';
import 'package:adocao_local/src/modules/account/models/user_model.dart';
import 'package:http/http.dart';

abstract class IUserStorage {
  Future<AuthTokenModel> login(String username, String password);

  Future<void> registerUser(UserModel user);

  Future<UserModel> getLoggedUserData();

  Future<void> updateData(UserModel user);

  Future<void> updatePassword(UserModel user);

  Future<ByteStream> updateImage(String path);

  Future<void> removeImage();
}
