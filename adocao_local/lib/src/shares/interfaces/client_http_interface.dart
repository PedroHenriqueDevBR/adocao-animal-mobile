import 'package:adocao_local/src/shares/models/http_response_model.dart';
import 'package:http/http.dart';

abstract class IClientHTTP {
  String host = '';

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

  Future<HttpResponseModel> multipartFormImage(
    String url,
    MultipartFile path, {
    String? jwtKey,
    String method,
  });

  Future<HttpResponseModel> multipartFormData(
    String url,
    MultipartFile path,
    Map<String, String> data, {
    String? jwtKey,
    String method,
  });
}
