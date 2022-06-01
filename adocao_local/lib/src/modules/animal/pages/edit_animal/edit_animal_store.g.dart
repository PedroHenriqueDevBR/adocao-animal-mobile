// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_animal_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditAnimalStore on _EditAnimalStore, Store {
  final _$selectedAnimalTypeAtom =
      Atom(name: '_EditAnimalStore.selectedAnimalType');

  @override
  AnimalTypeModel? get selectedAnimalType {
    _$selectedAnimalTypeAtom.reportRead();
    return super.selectedAnimalType;
  }

  @override
  set selectedAnimalType(AnimalTypeModel? value) {
    _$selectedAnimalTypeAtom.reportWrite(value, super.selectedAnimalType, () {
      super.selectedAnimalType = value;
    });
  }

  final _$selectedAnimalSexAtom =
      Atom(name: '_EditAnimalStore.selectedAnimalSex');

  @override
  AnimalSexModel? get selectedAnimalSex {
    _$selectedAnimalSexAtom.reportRead();
    return super.selectedAnimalSex;
  }

  @override
  set selectedAnimalSex(AnimalSexModel? value) {
    _$selectedAnimalSexAtom.reportWrite(value, super.selectedAnimalSex, () {
      super.selectedAnimalSex = value;
    });
  }

  final _$loadingAtom = Atom(name: '_EditAnimalStore.loading');

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

  final _$updateAtom = Atom(name: '_EditAnimalStore.update');

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

  final _$_EditAnimalStoreActionController =
      ActionController(name: '_EditAnimalStore');

  @override
  void setUpdate() {
    final _$actionInfo = _$_EditAnimalStoreActionController.startAction(
        name: '_EditAnimalStore.setUpdate');
    try {
      return super.setUpdate();
    } finally {
      _$_EditAnimalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedAnimalType: ${selectedAnimalType},
selectedAnimalSex: ${selectedAnimalSex},
loading: ${loading},
update: ${update}
    ''';
  }
}
