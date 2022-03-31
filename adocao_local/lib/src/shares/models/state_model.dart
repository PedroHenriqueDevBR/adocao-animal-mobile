import 'package:adocao_local/src/shares/models/city_model.dart';

class StateModel {
  dynamic id;
  String name;
  List<CityModel> cities = [];

  StateModel({
    this.id,
    required this.name,
  });
}
