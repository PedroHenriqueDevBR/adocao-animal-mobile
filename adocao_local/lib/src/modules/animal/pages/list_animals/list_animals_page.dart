import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ListAnimalsPage extends StatefulWidget {
  const ListAnimalsPage({Key? key}) : super(key: key);

  @override
  State<ListAnimalsPage> createState() => _ListAnimalsPageState();
}

class _ListAnimalsPageState extends State<ListAnimalsPage> {
  final _textStyle = AppTextStyle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
            color: Theme.of(context).backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Pesquisar...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.filter_list,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Platform.isAndroid || Platform.isIOS
                ? ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => animalCard(),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    addAutomaticKeepAlives: true,
                    addRepaintBoundaries: true,
                    itemCount: 10,
                    semanticChildCount: 2,
                    itemBuilder: (context, index) => animalgridCard(),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget animalgridCard() => Card(
        margin: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: 200,
                    height: double.maxFinite,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        bottomLeft: Radius.circular(4.0),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://images.pexels.com/photos/1904105/pexels-photo-1904105.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rex',
                          style: _textStyle.titleStyle,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert),
                        ),
                      ],
                    ),
                    const Divider(),
                    Flexible(
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        strutStyle: const StrutStyle(fontSize: 12.0),
                        text: TextSpan(
                            style: _textStyle.descriptionStyle,
                            text:
                                'Mussum Ipsum, cacilds vidis litro abertis. Mé faiz elementum girarzis, nisi eros vermeio.Quem num gosta di mé, boa gentis num é.Sapien in monti palavris qui num significa nadis i pareci latim.Delegadis gente finis, bibendum egestas augue arcu ut est. Mussum Ipsum, cacilds vidis litro abertis. Mé faiz elementum girarzis, nisi eros vermeio.Quem num gosta di mé, boa gentis num é.Sapien in monti palavris qui num significa nadis i pareci latim.Delegadis gente finis, bibendum egestas augue arcu ut est.'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget animalCard() => Card(
        margin: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://images.pexels.com/photos/1904105/pexels-photo-1904105.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rex',
                          style: _textStyle.titleStyle,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert),
                        ),
                      ],
                    ),
                    const Divider(),
                    Text(
                      'Cachorro viralata muito bem cuidado e buscando um novo lar. ',
                      style: _textStyle.descriptionStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
