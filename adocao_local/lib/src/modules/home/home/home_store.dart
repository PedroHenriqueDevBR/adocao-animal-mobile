import 'package:adocao_local/src/modules/account/pages/profile/profile_page.dart';
import 'package:adocao_local/src/modules/animal/pages/dashboard/dashboard_page.dart';
import 'package:adocao_local/src/modules/animal/pages/list_animals/list_animals_page.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore extends _HomeStore with _$HomeStore {}

abstract class _HomeStore with Store {
  @observable
  bool showDrawerMenu = false;
  @observable
  int pageIndex = 0;

  List<Widget> pages = [
    DashboardPage(),
    const ListAnimalsPage(),
    const ProfilePage(),
  ];

  @action
  void setPageIndex(int value) => pageIndex = value;

  @action
  void toggleShowDrawer() => showDrawerMenu = !showDrawerMenu;
}
