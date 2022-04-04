class AuthTokenModel {
  late String refresh;
  late String access;

  AuthTokenModel({
    required this.refresh,
    required this.access,
  });

  AuthTokenModel.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }
}
