import 'city_model.dart';

class StateModel {
  dynamic id;
  String name;
  List<CityModel> cities = [];

  StateModel({
    this.id,
    required this.name,
  });
}
