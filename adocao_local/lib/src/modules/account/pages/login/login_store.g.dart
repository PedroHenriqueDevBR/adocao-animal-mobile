// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  Computed<bool>? _$formIsValidComputed;

  @override
  bool get formIsValid =>
      (_$formIsValidComputed ??= Computed<bool>(() => super.formIsValid,
              name: '_LoginStore.formIsValid'))
          .value;

  final _$txtLoginAtom = Atom(name: '_LoginStore.txtLogin');

  @override
  String get txtLogin {
    _$txtLoginAtom.reportRead();
    return super.txtLogin;
  }

  @override
  set txtLogin(String value) {
    _$txtLoginAtom.reportWrite(value, super.txtLogin, () {
      super.txtLogin = value;
    });
  }

  final _$txtPasswordAtom = Atom(name: '_LoginStore.txtPassword');

  @override
  String get txtPassword {
    _$txtPasswordAtom.reportRead();
    return super.txtPassword;
  }

  @override
  set txtPassword(String value) {
    _$txtPasswordAtom.reportWrite(value, super.txtPassword, () {
      super.txtPassword = value;
    });
  }

  final _$showPasswordAtom = Atom(name: '_LoginStore.showPassword');

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

  final _$loadingAtom = Atom(name: '_LoginStore.loading');

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

  final _$_LoginStoreActionController = ActionController(name: '_LoginStore');

  @override
  void setLogin(String value) {
    final _$actionInfo =
        _$_LoginStoreActionController.startAction(name: '_LoginStore.setLogin');
    try {
      return super.setLogin(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleShowPassword() {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.toggleShowPassword');
    try {
      return super.toggleShowPassword();
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
txtLogin: ${txtLogin},
txtPassword: ${txtPassword},
showPassword: ${showPassword},
loading: ${loading},
formIsValid: ${formIsValid}
    ''';
  }
}
