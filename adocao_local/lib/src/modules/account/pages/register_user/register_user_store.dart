import 'package:adocao_local/src/modules/account/interfaces/user_interface.dart';
import 'package:adocao_local/src/modules/account/models/city_model.dart';
import 'package:adocao_local/src/modules/account/models/state_model.dart';
import 'package:adocao_local/src/modules/account/models/user_model.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;

part 'register_user_store.g.dart';

class RegisterUserStore extends _RegisterUserStore with _$RegisterUserStore {
  RegisterUserStore({
    required IAppData appData,
    required IUserStorage storage,
    required BuildContext context,
  }) {
    super.appData = appData;
    super.storage = storage;
    super.context = context;
  }
}

abstract class _RegisterUserStore with Store {
  late IAppData appData;
  late IUserStorage storage;
  late BuildContext context;

  ObservableList<StateModel> stateList = ObservableList<StateModel>();
  ObservableList<CityModel> cityList = ObservableList<CityModel>();
  StateModel? selectedState;
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

  void populateStates() {
    for (int i = 0; i < 10; i++) {
      final state = StateModel(id: i, name: 'Estado $i');
      state.cities = [CityModel(id: i, name: 'Cidade $i')];
      stateList.add(state);
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
    setLoading(true);
    FocusManager.instance.primaryFocus?.unfocus();

    CityModel city = CityModel(name: 'name');
    UserModel user = UserModel(
      name: name,
      username: username,
      contact: contact,
      password: password,
      city: city,
    );

    setLoading(false);
    asuka.showSnackBar(
      asuka.AsukaSnackbar.success('Usuário registrado com sucesso'),
    );
  }

  void goToLoginPage() {
    Navigator.pop(context);
  }
}
