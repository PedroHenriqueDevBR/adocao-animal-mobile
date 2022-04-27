import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:flutter/material.dart';

class ShowAnimalPage extends StatefulWidget {
  const ShowAnimalPage({Key? key}) : super(key: key);

  @override
  State<ShowAnimalPage> createState() => _ShowAnimalPageState();
}

class _ShowAnimalPageState extends State<ShowAnimalPage> {
  final _textStyle = AppTextStyle();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adoção App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
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
                    onPressed: () {},
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
          ],
        ),
      ),
    );
  }
}
