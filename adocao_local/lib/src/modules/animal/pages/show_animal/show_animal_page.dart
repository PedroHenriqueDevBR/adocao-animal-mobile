import 'dart:io' show Platform;

import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/shares/core/app_text_theme.dart';

class ShowAnimalPage extends StatefulWidget {
  AnimalModel animal;
  ShowAnimalPage({
    Key? key,
    required this.animal,
  }) : super(key: key);

  @override
  State<ShowAnimalPage> createState() => _ShowAnimalPageState();
}

class _ShowAnimalPageState extends State<ShowAnimalPage> {
  final _textStyle = AppTextStyle();

  void showBottomPage() {
    asuka.showModalBottomSheet(
      builder: (context) => Column(
        children: [
          AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: const Text('Solicitações'),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (ctx, index) => ListTile(
                title: const Text('Nome do solicitante'),
                subtitle: const Text('(86) 91234-5678'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      color: Colors.green,
                      onPressed: () {},
                      icon: const Icon(Icons.check_circle),
                    ),
                    IconButton(
                      color: Colors.red,
                      onPressed: () {},
                      icon: const Icon(Icons.cancel),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adoção App'),
      ),
      body: Platform.isAndroid || Platform.isIOS
          ? childrenWidgets()
          : desktopChildrenWidgets(size),
    );
  }

  Widget desktopChildrenWidgets(Size size) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://images.pexels.com/photos/1904105/pexels-photo-1904105.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rex',
                            style: _textStyle.titleStyle,
                          ),
                          ElevatedButton(
                            onPressed: showBottomPage,
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).colorScheme.secondary,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 4.0),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4.0),
                                  margin: const EdgeInsets.only(right: 4.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                  ),
                                  child: Text(
                                    '5',
                                    style: _textStyle.textButton,
                                  ),
                                ),
                                const Text('Solicitações'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Cachorro viralata muito bem cuidado e buscando um novo lar.',
                        textAlign: TextAlign.center,
                        style: _textStyle.descriptionStyle,
                      ),
                    ),
                    const Divider(),
                    Text(
                      'Caderno de vacinação',
                      style: _textStyle.textButton,
                    ),
                    ListView.separated(
                      itemCount: 5,
                      itemBuilder: (ctx, index) => ListTile(
                        leading: const Icon(Icons.vaccines),
                        title: Text('data ${index + 1}'),
                        subtitle: const Text('00/00/0000'),
                      ),
                      separatorBuilder: (_, __) => const Divider(),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget childrenWidgets() => SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://images.pexels.com/photos/1904105/pexels-photo-1904105.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rex',
                    style: _textStyle.titleStyle,
                  ),
                  ElevatedButton(
                    onPressed: showBottomPage,
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 4.0),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          margin: const EdgeInsets.only(right: 4.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                          child: Text(
                            '5',
                            style: _textStyle.textButton,
                          ),
                        ),
                        const Text('Solicitações'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Cachorro viralata muito bem cuidado e buscando um novo lar.',
                textAlign: TextAlign.center,
                style: _textStyle.descriptionStyle,
              ),
            ),
            const Divider(),
            Text(
              'Caderno de vacinação',
              style: _textStyle.textButton,
            ),
            ListView.separated(
              itemCount: 5,
              itemBuilder: (ctx, index) => ListTile(
                leading: const Icon(Icons.vaccines),
                title: Text('data ${index + 1}'),
                subtitle: const Text('00/00/0000'),
              ),
              separatorBuilder: (_, __) => const Divider(),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
            ),
            const SizedBox(height: 100.0),
          ],
        ),
      );
}
