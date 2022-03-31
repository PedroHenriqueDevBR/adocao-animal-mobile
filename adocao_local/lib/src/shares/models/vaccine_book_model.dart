class VaccineModel {
  dynamic id;
  String name;
  DateTime date = DateTime.now();

  VaccineModel({
    this.id,
    required this.name,
  });
}
