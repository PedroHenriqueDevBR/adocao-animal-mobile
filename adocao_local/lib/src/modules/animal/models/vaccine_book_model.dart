import 'package:adocao_local/src/modules/animal/models/animal_model.dart';

class VaccineModel {
  dynamic id;
  String name;
  late DateTime? date;

  VaccineModel({
    this.id,
    required this.name,
    DateTime? date,
  }) {
    this.date = date ?? DateTime.now();
  }

  Map<String, dynamic> toMap(AnimalModel animal) {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'vaccine_name': name});
    result.addAll({'animal': animal.id});
    return result;
  }

  factory VaccineModel.fromMap(Map<String, dynamic> map) {
    return VaccineModel(
      id: map['id'],
      name: map['vaccine_name'] ?? '',
      date: DateTime.tryParse(map['date']),
    );
  }

  static List<VaccineModel> fromMapList(List<dynamic> list) {
    List<VaccineModel> result = [];
    for (Map<String, dynamic> map in list) {
      result.add(VaccineModel.fromMap(map));
    }
    return result;
  }
}
