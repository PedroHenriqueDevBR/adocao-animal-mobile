import 'dart:convert';

class CityModel {
  dynamic id;
  String name;

  CityModel({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});

    return result;
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: map['id'],
      name: map['name'] ?? '',
    );
  }

  static List<CityModel> fromMapList(List<Map<String, dynamic>> list) {
    List<CityModel> result = [];
    for (Map<String, dynamic> map in list) {
      result.add(CityModel.fromMap(map));
    }
    return result;
  }
}
