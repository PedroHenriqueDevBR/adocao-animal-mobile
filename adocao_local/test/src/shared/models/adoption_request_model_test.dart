import 'package:adocao_local/src/modules/account/models/city_model.dart';
import 'package:adocao_local/src/modules/account/models/user_model.dart';
import 'package:adocao_local/src/modules/animal/models/adoption_request_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AdoptionRequestModel adoptionRequestModel;
  final now = DateTime.now();

  setUpAll(() {
    final city = CityModel(name: 'name');
    final requester = UserModel(
      id: 1,
      username: 'username',
      name: 'name',
      city: city,
    );
    adoptionRequestModel =
        AdoptionRequestModel(createAt: now, requester: requester);
  });

  test('Deve ser possiel instanciar com o minimo de atributos', () {
    expect(adoptionRequestModel.id, isNull);
    expect(adoptionRequestModel.requester.id, equals(1));
    expect(adoptionRequestModel.isAcepted, isNull);
    expect(adoptionRequestModel.createAt, now);
  });

  test('isAcepted deve ser true', () {
    adoptionRequestModel.accept;
    expect(adoptionRequestModel.isAcepted, true);
  });

  test('isAcepted deve ser false', () {
    adoptionRequestModel.reject;
    expect(adoptionRequestModel.isAcepted, false);
  });

  test('O formato da data deve ser 00/00/0000', () {
    expect(
      adoptionRequestModel.formattedCreateAt,
      equals('${now.day}/${now.month}/${now.year}'),
    );
  });
}
