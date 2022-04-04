import 'city_model.dart';

class StateModel {
  dynamic id;
  String name;
  List<CityModel> cities = [];

  StateModel({
    this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});

    return result;
  }

  factory StateModel.fromMap(Map<String, dynamic> map) {
    final stateModel = StateModel(
      id: map['id'],
      name: map['name'] ?? '',
    );
    stateModel.cities = CityModel.fromMapList(map['cities']);
    return stateModel;
  }

  static List<StateModel> fromMapList(List<Map<String, dynamic>> list) {
    List<StateModel> result = [];
    for (Map<String, dynamic> map in list) {
      result.add(StateModel.fromMap(map));
    }
    return result;
  }
}
