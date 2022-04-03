import 'city_model.dart';
import '../../animal/models/animal_model.dart';

class UserModel {
  dynamic id;
  String username;
  String name;
  String? password;
  String? image;
  String? contact;
  CityModel city;
  List<AnimalModel> animals = [];

  UserModel({
    this.id,
    required this.username,
    required this.name,
    required this.city,
    this.password,
    this.contact,
    this.image,
  });
}
