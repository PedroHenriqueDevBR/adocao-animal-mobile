import 'package:adocao_local/src/modules/account/models/auth_token_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Map<String, String> json = {
    "refresh":
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY1NDIwNTc4NiwianRpIjoiMmQ3ZDQ5ZWE3ZGFmNGRlMDk4YzE4YTMyNTlhZjMwNDciLCJ1c2VyX2lkIjoyfQ.HOju1IAmGY8DaKAPVMysYNqPcIlw5hH1khcGq1gBkDM",
    "access":
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjUxNjEzNzg2LCJqdGkiOiI0ZmYxZTg0MGRhYTE0NjU1OGUzOGE5MTk3ZWVmMmMwNiIsInVzZXJfaWQiOjJ9.2GX9h1FXu0RplR43sRoultVN2OdY50j6okK4_yH3L4E"
  };

  test('Deve converter de map para Authtoken', () {
    final authToken = AuthTokenModel.fromJson(json);
    expect(authToken.access, equals(json['access']));
    expect(authToken.refresh, equals(json['refresh']));
  });
}
