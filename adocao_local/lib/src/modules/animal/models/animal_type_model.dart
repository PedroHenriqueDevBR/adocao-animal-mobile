import 'dart:convert';

class AnimalTypeModel {
  dynamic id;
  String name;

  AnimalTypeModel({
    this.id,
    required this.name,
  });

  factory AnimalTypeModel.fromMap(Map<String, dynamic> map) {
    return AnimalTypeModel(
      id: map['id'],
      name: map['name'] ?? '',
    );
  }

  static List<AnimalTypeModel> fromMapList(List<dynamic> list) {
    List<AnimalTypeModel> result = [];
    for (Map<String, dynamic> map in list) {
      result.add(AnimalTypeModel.fromMap(map));
    }
    return result;
  }
}
