import 'package:adocao_local/src/shares/models/http_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Deve ser possivel instaciar com o minimo de atributos', () {
    final httpResponseModel = HttpResponseModel(statusCode: 200);
    expect(httpResponseModel.statusCode, equals(200));
    expect(httpResponseModel.data, isNull);
    expect(httpResponseModel.headers, isNull);
  });

  test('Deve ser possivel instaciar com data de atributo', () {
    final httpResponseModel = HttpResponseModel(statusCode: 200, data: {});
    expect(httpResponseModel.statusCode, equals(200));
    expect(httpResponseModel.data, isNotNull);
    expect(httpResponseModel.headers, isNull);
  });

  test('Deve ser possivel instaciar com o minimo de atributos', () {
    final httpResponseModel =
        HttpResponseModel(statusCode: 200, data: {}, headers: {});
    expect(httpResponseModel.statusCode, equals(200));
    expect(httpResponseModel.data, isNotNull);
    expect(httpResponseModel.headers, isNotNull);
  });
}
