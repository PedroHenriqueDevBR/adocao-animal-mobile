import 'package:adocao_local/src/shares/models/http_response_model.dart';

abstract class IClientHTTP {
  Future<HttpResponseModel> get(
    String url, {
    String? jwtKey,
  });

  Future<HttpResponseModel> post(
    String url,
    Map<String, dynamic> data, {
    String? jwtKey,
  });

  Future<HttpResponseModel> put(
    String url,
    Map<String, dynamic> data, {
    String? jwtKey,
  });

  Future<HttpResponseModel> delete(
    String url, {
    String? jwtKey,
  });
}
