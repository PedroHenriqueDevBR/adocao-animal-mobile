// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_animals_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListAnimalsStore on _ListAnimalsStore, Store {
  final _$loadingAtom = Atom(name: '_ListAnimalsStore.loading');

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

  final _$updateAtom = Atom(name: '_ListAnimalsStore.update');

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

  final _$_ListAnimalsStoreActionController =
      ActionController(name: '_ListAnimalsStore');

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_ListAnimalsStoreActionController.startAction(
        name: '_ListAnimalsStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ListAnimalsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUpdate() {
    final _$actionInfo = _$_ListAnimalsStoreActionController.startAction(
        name: '_ListAnimalsStore.setUpdate');
    try {
      return super.setUpdate();
    } finally {
      _$_ListAnimalsStoreActionController.endAction(_$actionInfo);
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
