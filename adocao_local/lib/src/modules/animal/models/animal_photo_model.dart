class AnimalPhotoModel {
  dynamic id;
  String url;

  AnimalPhotoModel({
    this.id,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'photo': url});

    return result;
  }

  factory AnimalPhotoModel.fromMap(Map<String, dynamic> map) {
    return AnimalPhotoModel(
      id: map['id'],
      url: map['photo'] ?? '',
    );
  }
}
