import 'package:flutter/material.dart';

class ListAnimalsPage extends StatefulWidget {
  const ListAnimalsPage({Key? key}) : super(key: key);

  @override
  State<ListAnimalsPage> createState() => _ListAnimalsPageState();
}

class _ListAnimalsPageState extends State<ListAnimalsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Listagem dos animais!'),
      ),
    );
  }
}
