import 'package:adocao_local/src/shares/models/user_model.dart';

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

  get formattedCreateAt => '${createAt.day}/${createAt.month}/${createAt.year}';
}
