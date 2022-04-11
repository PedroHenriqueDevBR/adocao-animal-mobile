// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegisterUserStore on _RegisterUserStore, Store {
  Computed<bool>? _$formIsValidComputed;

  @override
  bool get formIsValid =>
      (_$formIsValidComputed ??= Computed<bool>(() => super.formIsValid,
              name: '_RegisterUserStore.formIsValid'))
          .value;

  final _$selectedCityAtom = Atom(name: '_RegisterUserStore.selectedCity');

  @override
  CityModel? get selectedCity {
    _$selectedCityAtom.reportRead();
    return super.selectedCity;
  }

  @override
  set selectedCity(CityModel? value) {
    _$selectedCityAtom.reportWrite(value, super.selectedCity, () {
      super.selectedCity = value;
    });
  }

  final _$nameAtom = Atom(name: '_RegisterUserStore.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$usernameAtom = Atom(name: '_RegisterUserStore.username');

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  final _$contactAtom = Atom(name: '_RegisterUserStore.contact');

  @override
  String get contact {
    _$contactAtom.reportRead();
    return super.contact;
  }

  @override
  set contact(String value) {
    _$contactAtom.reportWrite(value, super.contact, () {
      super.contact = value;
    });
  }

  final _$passwordAtom = Atom(name: '_RegisterUserStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$repeatPasswordAtom = Atom(name: '_RegisterUserStore.repeatPassword');

  @override
  String get repeatPassword {
    _$repeatPasswordAtom.reportRead();
    return super.repeatPassword;
  }

  @override
  set repeatPassword(String value) {
    _$repeatPasswordAtom.reportWrite(value, super.repeatPassword, () {
      super.repeatPassword = value;
    });
  }

  final _$showPasswordAtom = Atom(name: '_RegisterUserStore.showPassword');

  @override
  bool get showPassword {
    _$showPasswordAtom.reportRead();
    return super.showPassword;
  }

  @override
  set showPassword(bool value) {
    _$showPasswordAtom.reportWrite(value, super.showPassword, () {
      super.showPassword = value;
    });
  }

  final _$showRepeatPasswordAtom =
      Atom(name: '_RegisterUserStore.showRepeatPassword');

  @override
  bool get showRepeatPassword {
    _$showRepeatPasswordAtom.reportRead();
    return super.showRepeatPassword;
  }

  @override
  set showRepeatPassword(bool value) {
    _$showRepeatPasswordAtom.reportWrite(value, super.showRepeatPassword, () {
      super.showRepeatPassword = value;
    });
  }

  final _$loadingAtom = Atom(name: '_RegisterUserStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$updateAtom = Atom(name: '_RegisterUserStore.update');

  @override
  bool get update {
    _$updateAtom.reportRead();
    return super.update;
  }

  @override
  set update(bool value) {
    _$updateAtom.reportWrite(value, super.update, () {
      super.update = value;
    });
  }

  final _$_RegisterUserStoreActionController =
      ActionController(name: '_RegisterUserStore');

  @override
  void setName(String value) {
    final _$actionInfo = _$_RegisterUserStoreActionController.startAction(
        name: '_RegisterUserStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_RegisterUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUsername(String value) {
    final _$actionInfo = _$_RegisterUserStoreActionController.startAction(
        name: '_RegisterUserStore.setUsername');
    try {
      return super.setUsername(value);
    } finally {
      _$_RegisterUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setContact(String value) {
    final _$actionInfo = _$_RegisterUserStoreActionController.startAction(
        name: '_RegisterUserStore.setContact');
    try {
      return super.setContact(value);
    } finally {
      _$_RegisterUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_RegisterUserStoreActionController.startAction(
        name: '_RegisterUserStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_RegisterUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRepeatPassword(String value) {
    final _$actionInfo = _$_RegisterUserStoreActionController.startAction(
        name: '_RegisterUserStore.setRepeatPassword');
    try {
      return super.setRepeatPassword(value);
    } finally {
      _$_RegisterUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleShowPassword() {
    final _$actionInfo = _$_RegisterUserStoreActionController.startAction(
        name: '_RegisterUserStore.toggleShowPassword');
    try {
      return super.toggleShowPassword();
    } finally {
      _$_RegisterUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleRepeatShowPassword() {
    final _$actionInfo = _$_RegisterUserStoreActionController.startAction(
        name: '_RegisterUserStore.toggleRepeatShowPassword');
    try {
      return super.toggleRepeatShowPassword();
    } finally {
      _$_RegisterUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_RegisterUserStoreActionController.startAction(
        name: '_RegisterUserStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_RegisterUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUpdate() {
    final _$actionInfo = _$_RegisterUserStoreActionController.startAction(
        name: '_RegisterUserStore.setUpdate');
    try {
      return super.setUpdate();
    } finally {
      _$_RegisterUserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedCity: ${selectedCity},
name: ${name},
username: ${username},
contact: ${contact},
password: ${password},
repeatPassword: ${repeatPassword},
showPassword: ${showPassword},
showRepeatPassword: ${showRepeatPassword},
loading: ${loading},
update: ${update},
formIsValid: ${formIsValid}
    ''';
  }
}
