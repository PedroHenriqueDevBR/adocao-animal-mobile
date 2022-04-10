// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegisterUserStore on _RegisterUserStore, Store {
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
  String toString() {
    return '''
name: ${name},
username: ${username},
contact: ${contact},
password: ${password},
repeatPassword: ${repeatPassword}
    ''';
  }
}
