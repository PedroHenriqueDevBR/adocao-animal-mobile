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

  get formattedCreateAt => '${createAt.day}/${createAt.month}/${createAt.year}';
}
