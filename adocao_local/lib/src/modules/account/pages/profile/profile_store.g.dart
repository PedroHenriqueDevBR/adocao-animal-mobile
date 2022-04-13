// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileStore on _ProfileStore, Store {
  Computed<bool>? _$formIsValidComputed;

  @override
  bool get formIsValid =>
      (_$formIsValidComputed ??= Computed<bool>(() => super.formIsValid,
              name: '_ProfileStore.formIsValid'))
          .value;

  final _$selectedCityAtom = Atom(name: '_ProfileStore.selectedCity');

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

  final _$imageAtom = Atom(name: '_ProfileStore.image');

  @override
  String? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(String? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$updateAtom = Atom(name: '_ProfileStore.update');

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

  final _$_ProfileStoreActionController =
      ActionController(name: '_ProfileStore');

  @override
  void setImage(String value) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.setImage');
    try {
      return super.setImage(value);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUpdate() {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.setUpdate');
    try {
      return super.setUpdate();
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedCity: ${selectedCity},
image: ${image},
update: ${update},
formIsValid: ${formIsValid}
    ''';
  }
}
