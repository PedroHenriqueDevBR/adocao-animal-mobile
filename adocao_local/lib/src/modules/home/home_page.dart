import 'dart:io';

import 'package:adocao_local/src/modules/home/home/home_store.dart';
import 'package:adocao_local/src/shares/core/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:rive/rive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adoção App'),
        automaticallyImplyLeading:
            Platform.isWindows || Platform.isLinux ? false : true,
        leading: Platform.isWindows || Platform.isLinux
            ? IconButton(
                onPressed: controller.toggleShowDrawer,
                icon: const Icon(Icons.menu),
              )
            : null,
      ),
      body: Row(
        children: [
          Observer(
            builder: (_) {
              return controller.showDrawerMenu
                  ? Drawer(
                      backgroundColor: Theme.of(context).cardColor,
                      child: ListView(
                        children: [
                          DrawerHeader(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: RiveAnimation.asset(
                                AppAnimations.logoLoopAnimation),
                          ),
                          ListTile(
                            leading: const Icon(Icons.home),
                            title: const Text('Home'),
                            onTap: () => controller.setPageIndex(0),
                          ),
                          ListTile(
                            leading: const Icon(Icons.pets),
                            title: const Text('Meus Animais'),
                            onTap: () => controller.setPageIndex(1),
                          ),
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text('Perfil'),
                            onTap: () => controller.setPageIndex(2),
                          ),
                        ],
                      ),
                    )
                  : Container();
            },
          ),
          const VerticalDivider(
            width: 0,
            color: Colors.grey,
          ),
          Observer(builder: (_) {
            return Expanded(
              child: controller.pages[controller.pageIndex],
            );
          }),
        ],
      ),
      bottomNavigationBar: Platform.isAndroid || Platform.isIOS
          ? Observer(
              builder: (_) => BottomNavigationBar(
                currentIndex: controller.pageIndex,
                onTap: (int value) => controller.setPageIndex(value),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.pets),
                    label: 'Meus Animais',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Perfil',
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
