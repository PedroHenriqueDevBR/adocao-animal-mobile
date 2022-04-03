abstract class IAppData {
  Future<void> setJWT(String jwt);

  Future<String> getJWT();
}
