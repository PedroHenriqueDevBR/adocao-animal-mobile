
import 'adoption_request_model.dart';
import 'animal_photo_model.dart';
import 'animal_type_model.dart';
import 'vaccine_book_model.dart';

class AnimalModel {
  dynamic id;
  String name;
  String breed;
  int age;
  String sex;
  bool adopted;
  bool blocked;
  AnimalTypeModel animalType;
  List<AnimalPhotoModel> photos = [];
  List<VaccineModel> vaccines = [];
  List<AdoptionRequestModel> requests = [];
  late DateTime createAt;

  AnimalModel({
    this.id,
    required this.name,
    required this.breed,
    required this.age,
    required this.sex,
    required this.animalType,
    this.adopted = false,
    this.blocked = false,
    DateTime? createAt,
  }) {
    this.createAt = createAt ?? DateTime.now();
  }

  get formattedCreateAt =>
      '${formatDateNumber(createAt.day)}/${formatDateNumber(createAt.month)}/${createAt.year}';

  String formatDateNumber(int number) => number >= 10 ? '$number' : '0$number';

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'breed': breed});
    result.addAll({'age': age});
    result.addAll({'sex': sex});
    result.addAll({'type': animalType.id});

    return result;
  }

  factory AnimalModel.fromMap(Map<String, dynamic> map) {
    AnimalTypeModel animalType = AnimalTypeModel(
      name: map['type'] ?? 'Não definido',
    );

    final animalModel = AnimalModel(
      id: map['id'],
      name: map['name'] ?? '',
      breed: map['breed'] ?? '',
      age: map['age']?.toInt() ?? 0,
      sex: map['sex'] ?? '',
      adopted: map['adopted'] ?? false,
      blocked: map['blocked'] ?? false,
      createAt: map['create_at'] != null
          ? DateTime.parse(map['create_at'])
          : DateTime.now(),
      animalType: animalType,
    );
    if (map['all_photos'] != null) {
      animalModel.photos = List<AnimalPhotoModel>.from(
        map['all_photos']?.map((x) => AnimalPhotoModel.fromMap(x)),
      );
    }
    if (map['all_vaccines'] != null) {
      animalModel.vaccines = List<VaccineModel>.from(
        map['all_vaccines']?.map((x) => VaccineModel.fromMap(x)),
      );
    }
    return animalModel;
  }

  static List<AnimalModel> fromMapList(List<dynamic> list) {
    List<AnimalModel> result = [];
    for (Map<String, dynamic> map in list) {
      result.add(AnimalModel.fromMap(map));
    }
    return result;
  }
}
