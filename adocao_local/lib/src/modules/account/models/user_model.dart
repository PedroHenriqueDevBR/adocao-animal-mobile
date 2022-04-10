import '../../animal/models/animal_model.dart';
import 'city_model.dart';

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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'username': username});
    result.addAll({'name': name});
    result.addAll({'city': city.toMap()});

    if (password != null) {
      result.addAll({'password': password});
    }
    if (image != null) {
      result.addAll({'image': image});
    }
    if (contact != null) {
      result.addAll({'contact': contact});
    }

    return result;
  }

  Map<String, dynamic> toRegisterMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'username': username});
    result.addAll({'name': name});
    result.addAll({'city': city.id});

    if (password != null) {
      result.addAll({'password': password});
    }
    if (image != null) {
      result.addAll({'image': image});
    }
    if (contact != null) {
      result.addAll({'contact': contact});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      password: map['password'],
      image: map['image'],
      contact: map['contact'],
      city: CityModel.fromMap(map['city']),
    );
  }
}
