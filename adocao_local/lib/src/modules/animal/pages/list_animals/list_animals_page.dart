import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/repositories/animal_repository.dart';
import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:adocao_local/src/shares/services/app_preferences_service.dart';
import 'package:adocao_local/src/shares/services/http_client_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
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
      appData: appData,
      storage: AnimalRepository(
        client: client,
        appData: appData,
      ),
    );
    controller.loadAnimals(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reaction(
      (_) => controller.update,
      (_) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
            color: Colors.white,
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
        onPressed: () => controller.goToCreateAnimalPage(context: context),
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }

  Widget animalCard(AnimalModel animal) => GestureDetector(
        onTap: () => controller.goToShowAnimalPage(context, animal),
        child: Card(
          color: Colors.white,
          elevation: 0,
          margin: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      image: DecorationImage(
                        image: controller.getAnimalPhoto(animal),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                      ),
                    ),
                  ),
                  animal.blocked
                      ? Container(
                          padding: const EdgeInsets.all(2),
                          width: 150,
                          color: Colors.red,
                          child: Center(
                            child: Text(
                              'Bloqueado',
                              style: _textStyle.descriptionStyle.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  animal.adopted
                      ? Container(
                          padding: const EdgeInsets.all(2),
                          width: 150,
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              'Adotado',
                              style: _textStyle.descriptionStyle.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Container(),
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
                            animal.name,
                            style: _textStyle.titleStyle,
                          ),
                          PopupMenuButton(
                            onSelected: (value) {
                              if (value == '1') {
                                controller.goToCreateAnimalPage(
                                    context: context, animal: animal);
                              }
                              if (value == '2') {
                                controller.blockAnimal(context, animal);
                              }
                              if (value == '3') {
                                controller.unlockAnimal(context, animal);
                              }
                              if (value == '4') {
                                controller.removeAnimal(context, animal);
                              }
                            },
                            itemBuilder: (_) => <PopupMenuItem<String>>[
                              const PopupMenuItem(
                                value: '1',
                                child: Text('Editar'),
                              ),
                              !animal.blocked
                                  ? const PopupMenuItem(
                                      value: '2',
                                      child: Text('Bloquear'),
                                    )
                                  : const PopupMenuItem(
                                      value: '3',
                                      child: Text('Desbloquear'),
                                    ),
                              const PopupMenuItem(
                                value: '4',
                                child: Text('Deletar'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Text(
                            '-> ${animal.animalType.name}\n -> Raça ${animal.breed}\n -> Sexo: ${animal.sex}',
                            textAlign: TextAlign.left,
                            style: _textStyle.descriptionStyle,
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
