import 'dart:io' show Platform;

import 'package:adocao_local/src/modules/animal/models/vaccine_book_model.dart';
import 'package:adocao_local/src/modules/animal/pages/show_animal/show_animal_store.dart';
import 'package:adocao_local/src/modules/animal/repositories/animal_repository.dart';
import 'package:adocao_local/src/shares/core/app_assets.dart';
import 'package:adocao_local/src/shares/services/app_preferences_service.dart';
import 'package:adocao_local/src/shares/services/http_client_service.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:flutter/services.dart';

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
  late ShowAnimalStore controller;
  final appData = AppPreferenceService();
  final client = HttpClientService();

  @override
  void initState() {
    super.initState();
    controller = ShowAnimalStore(
      context: context,
      appData: appData,
      storage: AnimalRepository(
        client: client,
        appData: appData,
      ),
      animal: widget.animal,
    );
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Apresentação'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 350.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: controller.getAnimalPhoto(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            childrenWidgets(),
          ],
        ),
      ),
    );
  }

  Widget childrenWidgets() => SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8.0),
              color: controller.animal.adopted
                  ? Colors.green
                  : controller.animal.blocked
                      ? Colors.red
                      : Theme.of(context).primaryColor,
              child: Center(
                child: Text(
                  controller.animal.adopted
                      ? 'Adotado'
                      : controller.animal.blocked
                          ? 'Bloqueado'
                          : 'Disponível para adoção',
                  style: _textStyle.textButton.copyWith(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.animal.name,
                    style: _textStyle.titleStyle,
                  ),
                  ElevatedButton(
                    onPressed: showBottomPage,
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 8.0),
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
                          // child: Text(
                          //   '${controller.animal.requests.length}',
                          //   style: _textStyle.textButton,
                          // ),
                        ),
                        const Text('Solicitações'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              child: Text(
                '${controller.animal.animalType.name} da raça ${controller.animal.breed}, sexo: ${controller.animal.sex}',
                textAlign: TextAlign.center,
                style: _textStyle.descriptionStyle,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
            const Divider(),
            Text(
              'Caderno de vacinação',
              style: _textStyle.textButton,
            ),
            ListView.separated(
              itemCount: controller.animal.vaccines.length,
              itemBuilder: (_, index) {
                final vaccine = controller.animal.vaccines[index];
                return ListTile(
                  leading: const Icon(Icons.vaccines),
                  title: Text('${vaccine.name}'),
                  subtitle: Text(vaccine.formattedDate),
                );
              },
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
