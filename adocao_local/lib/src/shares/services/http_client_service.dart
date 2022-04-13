import 'dart:convert';
import 'package:adocao_local/src/shares/exceptions/http_response_exception.dart';
import 'package:adocao_local/src/shares/models/http_response_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../interfaces/client_http_interface.dart';

class HttpClientService implements IClientHTTP {
  String host = 'http://192.168.2.3:8000';
  Uri _getBaseUrl(String path) => Uri.parse('${host}/$path');

  Map<String, String> _setAuthorization({String? key}) {
    Map<String, String> map = {};
    map['Content-Type'] = 'application/json';
    if (key != null) {
      map['Authorization'] = 'Bearer $key';
    }
    return map;
  }

  @override
  Future<HttpResponseModel> get(String url, {String? jwtKey}) async {
    Map<String, String> headers = _setAuthorization(key: jwtKey);
    final uri = _getBaseUrl(url);
    try {
      Response response = await http.get(uri, headers: headers);
      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(
            response.body.isNotEmpty ? utf8.decode(response.bodyBytes) : '{}'),
        headers: response.headers,
      );
    } catch (error) {
      throw HttpResponseException(
        response: HttpResponseModel(
          statusCode: 500,
          data: {},
          headers: {},
        ),
      );
    }
  }

  @override
  Future<HttpResponseModel> post(
    String url,
    Map<String, dynamic> data, {
    String? jwtKey,
  }) async {
    Map<String, String> headers = _setAuthorization(key: jwtKey);
    final uri = _getBaseUrl(url);
    try {
      Response response =
          await http.post(uri, body: jsonEncode(data), headers: headers);
      return HttpResponseModel(
        statusCode: response.statusCode,
        data: json.decode(
          utf8.decode(response.body.isNotEmpty
              ? response.body.codeUnits
              : '{}'.codeUnits),
        ),
        headers: response.headers,
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseModel> put(
    String url,
    Map<String, dynamic> data, {
    String? jwtKey,
  }) async {
    Map<String, String> headers = _setAuthorization(key: jwtKey);
    final uri = _getBaseUrl(url);

    try {
      Response response = await http.put(
        uri,
        body: jsonEncode(data),
        headers: headers,
      );
      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body.isNotEmpty ? response.body : '{}'),
        headers: response.headers,
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseModel> delete(String url, {String? jwtKey}) async {
    Map<String, String> headers = _setAuthorization(key: jwtKey);
    final uri = _getBaseUrl(url);
    try {
      Response response = await http.delete(uri, headers: headers);
      return HttpResponseModel(
        statusCode: response.statusCode,
        data: jsonDecode(response.body.isNotEmpty ? response.body : '{}'),
        headers: response.headers,
      );
    } catch (error) {
      rethrow;
    }
  }
}
