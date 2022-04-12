class CityModel {
  dynamic id;
  String name;
  int? stateId;

  CityModel({
    this.id,
    this.stateId,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});

    return result;
  }

  factory CityModel.fromMap(Map<dynamic, dynamic> map) {
    final city = CityModel(
      id: map['id'],
      name: map['name'] ?? '',
    );
    if (map['state'] != null && int.tryParse(map['state'].toString()) != null) {
      city.stateId = int.parse(map['state'].toString());
    }
    return city;
  }

  static List<CityModel> fromMapList(List<dynamic> list) {
    List<CityModel> result = [];
    for (Map<String, dynamic> map in list) {
      result.add(CityModel.fromMap(map));
    }
    return result;
  }
}
