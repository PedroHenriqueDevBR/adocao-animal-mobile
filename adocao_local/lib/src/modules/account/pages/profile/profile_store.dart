import 'package:adocao_local/src/modules/account/interfaces/location_interface.dart';
import 'package:adocao_local/src/modules/account/interfaces/user_interface.dart';
import 'package:adocao_local/src/modules/account/models/city_model.dart';
import 'package:adocao_local/src/modules/account/models/state_model.dart';
import 'package:adocao_local/src/modules/account/models/user_model.dart';
import 'package:adocao_local/src/shares/exceptions/http_response_exception.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;

part 'profile_store.g.dart';

class ProfileStore extends _ProfileStore with _$ProfileStore {
  ProfileStore({
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

abstract class _ProfileStore with Store {
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
  String? image;
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController contact = TextEditingController();

  bool loading = false;
  @observable
  bool update = false;

  @action
  void setImage(String? value) => image = value;
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
      populateProfileData();
    }
  }

  void populateProfileData() async {
    try {
      setLoading(true);
      UserModel user = await userStorage.getLoggedUserData();
      if (user.image != null) {
        setImage(user.image!);
      }
      username.text = user.username;
      name.text = user.name;
      if (user.contact != null) {
        contact.text = user.contact!;
      }

      if (user.city.stateId != null) {
        final state = stateList.firstWhere(
          (element) => element.id == user.city.stateId,
        );
        selectState(state);

        final city = cityList.firstWhere(
          (element) => element.id == user.city.id,
        );
        selectCity(city);
      }
    } finally {
      setLoading(false);
      setUpdate();
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
    return name.text.length >= 3 &&
        username.text.length >= 5 &&
        phoneNumberIsValid(contact.text) &&
        selectedCity != null;
  }

  bool get cityListHasElements => cityList.isNotEmpty;

  bool phoneNumberIsValid(String value) {
    String pattern = r'(\(?\d{2}\)?\s)?(\d{4,5}\-\d{4})';
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(value)) return true;
    return false;
  }

  void updateUser() async {
    try {
      setLoading(true);
      FocusManager.instance.primaryFocus?.unfocus();
      final user = UserModel(
        name: name.text,
        username: username.text,
        contact: contact.text,
        city: selectedCity!,
      );

      await userStorage.updateData(user);
      asuka.showSnackBar(asuka.AsukaSnackbar.success('Dados atualizados'));
    } on HttpResponseException catch (error) {
      final responseError = error.response;
      if (responseError.statusCode == 406) {
        if (responseError.data['errors'] != null) {
          String errors = '';
          for (String error in responseError.data['errors']) {
            if (kDebugMode) {
              print(error);
            }
            errors += error + '\n';
          }
          asuka.showSnackBar(asuka.AsukaSnackbar.alert(errors));
        }
      }
    } finally {
      setLoading(false);
    }
  }

  void removeImage() async {
    try {
      setLoading(true);
      FocusManager.instance.primaryFocus?.unfocus();

      await userStorage.removeImage();
      setImage(null);
      asuka.showSnackBar(asuka.AsukaSnackbar.success('Imagem removida'));
    } on HttpResponseException catch (error) {
      final responseError = error.response;
      if (responseError.statusCode == 406) {
        if (responseError.data['errors'] != null) {
          String errors = '';
          for (String error in responseError.data['errors']) {
            if (kDebugMode) {
              print(error);
            }
            errors += error + '\n';
          }
          asuka.showSnackBar(asuka.AsukaSnackbar.alert(errors));
        }
      }
    } finally {
      setLoading(false);
    }
  }

  void logout() {
    appData.setJWT('');
    Navigator.pushNamedAndRemoveUntil(
      context,
      'account/login',
      (Route<dynamic> route) => false,
    );
  }
}
