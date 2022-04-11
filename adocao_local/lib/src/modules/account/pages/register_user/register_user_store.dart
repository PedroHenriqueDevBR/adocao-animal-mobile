import 'package:adocao_local/src/modules/account/interfaces/location_interface.dart';
import 'package:adocao_local/src/modules/account/interfaces/user_interface.dart';
import 'package:adocao_local/src/modules/account/models/city_model.dart';
import 'package:adocao_local/src/modules/account/models/state_model.dart';
import 'package:adocao_local/src/modules/account/models/user_model.dart';
import 'package:adocao_local/src/shares/exceptions/http_response_exception.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;

part 'register_user_store.g.dart';

class RegisterUserStore extends _RegisterUserStore with _$RegisterUserStore {
  RegisterUserStore({
    required IAppData appData,
    required IUserStorage userStorage,
    required ILocationStorage locationStorage,
    required BuildContext context,
  }) {
    super.appData = appData;
    super.userStorage = userStorage;
    super.context = context;
    super.locationStorage = locationStorage;
  }
}

abstract class _RegisterUserStore with Store {
  late IAppData appData;
  late IUserStorage userStorage;
  late ILocationStorage locationStorage;
  late BuildContext context;

  ObservableList<StateModel> stateList = ObservableList<StateModel>();
  ObservableList<CityModel> cityList = ObservableList<CityModel>();
  StateModel? selectedState;
  @observable
  CityModel? selectedCity;

  @observable
  String name = '';
  @observable
  String username = '';
  @observable
  String contact = '';
  @observable
  String password = '';
  @observable
  String repeatPassword = '';
  @observable
  bool showPassword = false;
  @observable
  bool showRepeatPassword = false;
  @observable
  bool loading = false;
  @observable
  bool update = false;

  @action
  void setName(String value) => name = value;
  @action
  void setUsername(String value) => username = value.toLowerCase();
  @action
  void setContact(String value) => contact = value;
  @action
  void setPassword(String value) => password = value;
  @action
  void setRepeatPassword(String value) => repeatPassword = value;
  @action
  void toggleShowPassword() => showPassword = !showPassword;
  @action
  void toggleRepeatShowPassword() => showRepeatPassword = !showRepeatPassword;
  @action
  void setLoading(bool value) => loading = value;
  @action
  void setUpdate() => update = !update;

  void populateStates() async {
    try {
      setLoading(true);
      List<StateModel> states = await locationStorage.getStates();
      stateList.addAll(states);
    } finally {
      setLoading(false);
    }
  }

  void selectState(StateModel? state) {
    selectedState = state;
    cityList.clear();
    selectedCity = null;
    cityList.addAll(state!.cities);
    setUpdate();
  }

  void selectCity(CityModel? city) {
    selectedCity = city;
    setUpdate();
  }

  @computed
  bool get formIsValid {
    return name.length >= 3 &&
        username.length >= 5 &&
        phoneNumberIsValid(contact) &&
        password.length >= 8 &&
        selectedCity != null &&
        repeatPassword == password;
  }

  bool get cityListHasElements => cityList.isNotEmpty;

  bool phoneNumberIsValid(String value) {
    String pattern = r'(\(?\d{2}\)?\s)?(\d{4,5}\-\d{4})';
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(value)) return true;
    return false;
  }

  void registerUser() async {
    try {
      setLoading(true);
      FocusManager.instance.primaryFocus?.unfocus();
      final user = UserModel(
        name: name,
        username: username,
        contact: contact,
        password: password,
        city: selectedCity!,
      );

      await userStorage.registerUser(user).then((_) async {
        final token = await userStorage.login(username, password);
        appData.setJWT(token.access);
        asuka.showSnackBar(
          asuka.AsukaSnackbar.success('Usuário registrado com sucesso'),
        );
        goToHomePage();
      });
    } on HttpResponseException catch (error) {
      final responseError = error.response;
      if (responseError.statusCode == 406) {
        if (responseError.data['errors'] != null) {
          String errors = '';
          for (String error in responseError.data['errors']) {
            print(error);
            errors += error + '\n';
          }
          asuka.showSnackBar(asuka.AsukaSnackbar.alert(errors));
        }
      }
    } finally {
      setLoading(false);
    }
  }

  void goToHomePage() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      'home',
      (Route<dynamic> route) => false,
    );
  }

  void goToLoginPage() {
    Navigator.pop(context);
  }
}
