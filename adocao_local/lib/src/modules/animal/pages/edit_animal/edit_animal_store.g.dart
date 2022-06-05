// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_animal_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditAnimalStore on _EditAnimalStore, Store {
  late final _$selectedAnimalTypeAtom =
      Atom(name: '_EditAnimalStore.selectedAnimalType', context: context);

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

  late final _$selectedAnimalSexAtom =
      Atom(name: '_EditAnimalStore.selectedAnimalSex', context: context);

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

  late final _$loadingAtom =
      Atom(name: '_EditAnimalStore.loading', context: context);

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

  late final _$updateAtom =
      Atom(name: '_EditAnimalStore.update', context: context);

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

  late final _$_EditAnimalStoreActionController =
      ActionController(name: '_EditAnimalStore', context: context);

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
