import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/repositories/animal_repository.dart';
import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:adocao_local/src/shares/services/app_preferences_service.dart';
import 'package:adocao_local/src/shares/services/http_client_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import './list_animals_store.dart';

class ListAnimalsPage extends StatefulWidget {
  const ListAnimalsPage({Key? key}) : super(key: key);

  @override
  State<ListAnimalsPage> createState() => _ListAnimalsPageState();
}

class _ListAnimalsPageState extends State<ListAnimalsPage> {
  final _textStyle = AppTextStyle();
  late ListAnimalsStore controller;
  final appData = AppPreferenceService();
  final client = HttpClientService();

  @override
  void initState() {
    super.initState();
    controller = ListAnimalsStore(
      context: context,
      appData: appData,
      storage: AnimalRepository(
        client: client,
        appData: appData,
      ),
    );
    controller.loadAnimals();
  }

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
            child: Observer(builder: (_) {
              return ListView.builder(
                itemCount: controller.animalList.length,
                itemBuilder: (_, index) => animalCard(
                  controller.animalList[index],
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.goToCreateAnimalPage(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget animalCard(AnimalModel animal) => GestureDetector(
        onTap: () => controller.goToShowAnimalPage(animal),
        child: Card(
          margin: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: controller.getAnimalPhoto(animal),
                    fit: BoxFit.cover,
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
                            animal.name,
                            style: _textStyle.titleStyle,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '-> ${animal.animalType.name}\n -> Raça ${animal.breed}\n -> Sexo: ${animal.sex}',
                              textAlign: TextAlign.left,
                              style: _textStyle.descriptionStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
