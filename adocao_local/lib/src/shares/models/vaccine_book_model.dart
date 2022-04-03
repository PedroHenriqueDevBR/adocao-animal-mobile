class VaccineModel {
  dynamic id;
  String name;
  late DateTime date;

  VaccineModel({
    this.id,
    required this.name,
    DateTime? date,
  }) {
    this.date = date ?? DateTime.now();
  }
}
