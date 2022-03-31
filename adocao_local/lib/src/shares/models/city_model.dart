import 'package:adocao_local/src/shares/models/state_model.dart';
import 'package:adocao_local/src/shares/models/user_model.dart';

class CityModel {
  dynamic id;
  String name;
  List<UserModel> users = [];

  CityModel({
    this.id,
    required this.name,
  });
}
