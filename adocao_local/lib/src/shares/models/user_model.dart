import 'package:adocao_local/src/shares/models/animal_model.dart';

class UserModel {
  dynamic id;
  String username;
  String? password;
  String name;
  String image;
  String contact;
  List<AnimalModel> animals = [];

  UserModel({
    this.id,
    required this.username,
    required this.name,
    this.password,
    this.image = '',
    this.contact = '',
  });
}
