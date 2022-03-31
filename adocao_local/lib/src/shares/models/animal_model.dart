import 'package:adocao_local/src/shares/models/adoption_request_model.dart';
import 'package:adocao_local/src/shares/models/animal_photo_model.dart';
import 'package:adocao_local/src/shares/models/animal_type_model.dart';
import 'package:adocao_local/src/shares/models/vaccine_book_model.dart';

class AnimalModel {
  dynamic id;
  String name;
  String breed;
  String age;
  String sex;
  bool adopted;
  bool blocked;
  AnimalTypeModel animalType;
  List<AnimalPhotoModel> photos = [];
  List<VaccineModel> vaccines = [];
  List<AdoptionRequestModel> requests = [];
  DateTime createAt = DateTime.now();

  AnimalModel({
    this.id,
    required this.name,
    required this.breed,
    required this.age,
    required this.sex,
    required this.animalType,
    this.adopted = false,
    this.blocked = false,
  });
}
