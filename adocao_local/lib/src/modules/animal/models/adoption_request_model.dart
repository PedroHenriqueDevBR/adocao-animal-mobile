import 'dart:convert';

import '../../account/models/user_model.dart';

class AdoptionRequestModel {
  dynamic id;
  bool? isAcepted;
  DateTime createAt;
  UserModel requester;

  AdoptionRequestModel({
    this.id,
    this.isAcepted,
    required this.createAt,
    required this.requester,
  });

  get accept => isAcepted = true;

  get reject => isAcepted = false;

  get formattedCreateAt =>
      '${formatDateNumber(createAt.day)}/${formatDateNumber(createAt.month)}/${createAt.year}';

  String formatDateNumber(int number) => number >= 10 ? '$number' : '0$number';

  AdoptionRequestModel copyWith({
    dynamic? id,
    bool? isAcepted,
    DateTime? createAt,
    UserModel? requester,
  }) {
    return AdoptionRequestModel(
      id: id ?? this.id,
      isAcepted: isAcepted ?? this.isAcepted,
      createAt: createAt ?? this.createAt,
      requester: requester ?? this.requester,
    );
  }

  factory AdoptionRequestModel.fromMap(Map<String, dynamic> map) {
    return AdoptionRequestModel(
      id: map['id'],
      isAcepted: map['is_acepted'],
      createAt: map['create_at'] != null
          ? DateTime.parse(map['create_at'])
          : DateTime.now(),
      requester: UserModel.fromMap(map['requester']),
    );
  }

  static List<AdoptionRequestModel> fromMapList(List<dynamic> list) {
    List<AdoptionRequestModel> result = [];
    for (Map<String, dynamic> map in list) {
      result.add(AdoptionRequestModel.fromMap(map));
    }
    return result;
  }
}
