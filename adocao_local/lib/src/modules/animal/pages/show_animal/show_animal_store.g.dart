// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_animal_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ShowAnimalStore on _ShowAnimalStore, Store {
  final _$loadingAtom = Atom(name: '_ShowAnimalStore.loading');

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

  final _$updateAtom = Atom(name: '_ShowAnimalStore.update');

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

  final _$_ShowAnimalStoreActionController =
      ActionController(name: '_ShowAnimalStore');

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_ShowAnimalStoreActionController.startAction(
        name: '_ShowAnimalStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ShowAnimalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUpdate() {
    final _$actionInfo = _$_ShowAnimalStoreActionController.startAction(
        name: '_ShowAnimalStore.setUpdate');
    try {
      return super.setUpdate();
    } finally {
      _$_ShowAnimalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
update: ${update}
    ''';
  }
}
