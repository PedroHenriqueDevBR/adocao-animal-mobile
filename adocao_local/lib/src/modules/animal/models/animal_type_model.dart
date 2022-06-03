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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});

    return result;
  }

  static List<AnimalTypeModel> fromMapList(List<dynamic> list) {
    List<AnimalTypeModel> result = [];
    for (Map<String, dynamic> map in list) {
      result.add(AnimalTypeModel.fromMap(map));
    }
    return result;
  }
}
