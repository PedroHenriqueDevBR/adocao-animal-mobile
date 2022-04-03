class HttpResponseModel {
  int statusCode;
  dynamic data;
  Map<String, dynamic> headers;

  HttpResponseModel({
    required this.statusCode,
    required this.data,
    required this.headers,
  });
}
