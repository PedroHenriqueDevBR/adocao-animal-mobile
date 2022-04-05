import 'package:adocao_local/src/shares/models/http_response_model.dart';

class HttpResponseException implements Exception {
  HttpResponseModel response;
  HttpResponseException({
    required this.response,
  });
}
