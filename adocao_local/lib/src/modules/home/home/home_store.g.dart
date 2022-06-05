// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  late final _$showDrawerMenuAtom =
      Atom(name: '_HomeStore.showDrawerMenu', context: context);

  @override
  bool get showDrawerMenu {
    _$showDrawerMenuAtom.reportRead();
    return super.showDrawerMenu;
  }

  @override
  set showDrawerMenu(bool value) {
    _$showDrawerMenuAtom.reportWrite(value, super.showDrawerMenu, () {
      super.showDrawerMenu = value;
    });
  }

  late final _$pageIndexAtom =
      Atom(name: '_HomeStore.pageIndex', context: context);

  @override
  int get pageIndex {
    _$pageIndexAtom.reportRead();
    return super.pageIndex;
  }

  @override
  set pageIndex(int value) {
    _$pageIndexAtom.reportWrite(value, super.pageIndex, () {
      super.pageIndex = value;
    });
  }

  late final _$_HomeStoreActionController =
      ActionController(name: '_HomeStore', context: context);

  @override
  void setPageIndex(int value) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setPageIndex');
    try {
      return super.setPageIndex(value);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleShowDrawer() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.toggleShowDrawer');
    try {
      return super.toggleShowDrawer();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
showDrawerMenu: ${showDrawerMenu},
pageIndex: ${pageIndex}
    ''';
  }
}
