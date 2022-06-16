import 'package:adocao_local/src/modules/animal/models/animal_photo_model.dart';
import 'package:adocao_local/src/modules/animal/pages/show_animal/show_animal_store.dart';
import 'package:adocao_local/src/modules/animal/repositories/animal_repository.dart';
import 'package:adocao_local/src/modules/animal/repositories/animal_request_repository.dart';
import 'package:adocao_local/src/shares/services/app_preferences_service.dart';
import 'package:adocao_local/src/shares/services/http_client_service.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';

import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
      appData: appData,
      storage: AnimalRepository(
        client: client,
        appData: appData,
      ),
      adoptionStorage: AnimalRequestRepository(
        client: client,
        appData: appData,
      ),
      animal: widget.animal,
    );
    controller.loadAnimalPhotos();
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
            child: Observer(
              builder: (_) {
                return controller.adoptionRequests.length > 0
                    ? ListView.separated(
                        itemCount: controller.adoptionRequests.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (ctx, index) {
                          final adoptionRequest =
                              controller.adoptionRequests[index];
                          return ListTile(
                            title: Text(adoptionRequest.requester.name),
                            subtitle:
                                Text(adoptionRequest.requester.contact ?? ''),
                            tileColor: adoptionRequest.isAcepted == null
                                ? null
                                : adoptionRequest.isAcepted == true
                                    ? Colors.green.shade100
                                    : Colors.red.shade100,
                            trailing: adoptionRequest.isAcepted == null &&
                                    controller.animal.adopted == false
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        color: Colors.green,
                                        onPressed: () async {
                                          await controller.acceptAdoptionRequest(
                                              context, adoptionRequest);
                                          Navigator.pop(context);
                                          setState((){});
                                        },
                                        icon: const Icon(Icons.check),
                                      ),
                                      IconButton(
                                        color: Colors.red,
                                        onPressed: () async {
                                          await controller.recuseAdoptionRequest(
                                              context, adoptionRequest);
                                          Navigator.pop(context);
                                          setState((){});
                                        },
                                        icon: const Icon(Icons.close),
                                      ),
                                    ],
                                  )
                                : null,
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                            'Nenhuma solicitação para ser apresentada no momento!'),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(controller.animal.name,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            animalPhotoContainerWidget(),
            childrenWidgets(),
          ],
        ),
      ),
    );
  }

  Widget animalPhotoContainerWidget() => Container(
        height: 500.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: controller.getAnimalPhoto(),
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget childrenWidgets() => SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.only(bottom: 16.0),
              color: controller.animal.adopted
                  ? Colors.green
                  : controller.animal.blocked
                      ? Colors.red
                      : Colors.white,
              child: Center(
                child: Text(
                  controller.animal.adopted
                      ? 'Adotado'
                      : controller.animal.blocked
                          ? 'Bloqueado'
                          : 'Disponível para adoção',
                  style: _textStyle.textButton.copyWith(color:
                  controller.animal.adopted || controller.animal.blocked
                      ? Colors.white
                      : Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              child: Text(
                '${controller.animal.animalType.name} da raça ${controller.animal.breed}, sexo: ${controller.animal.sex}',
                textAlign: TextAlign.center,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: showBottomPage,
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.secondary,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 8.0),
                      ),
                      child: const Text('Solicitações'),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            albumWidget(context),
            const Divider(),
            Text(
              'Caderno de vacinação',
              style: _textStyle.textButton,
              textAlign: TextAlign.left,
            ),
            ListView.separated(
              itemCount: controller.animal.vaccines.length,
              itemBuilder: (_, index) {
                final vaccine = controller.animal.vaccines[index];
                return ListTile(
                  leading: const Icon(Icons.vaccines),
                  title: Text(vaccine.name),
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

  Widget albumWidget(BuildContext context) => controller.animal.photos.length > 0 ? Padding(
    padding: const EdgeInsets.all(8.0),
    child: GridView.builder(
      itemCount: controller.animal.photos.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemBuilder: (_, index) {
        AnimalPhotoModel photo = controller.animal.photos[index];
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(client.host + photo.url),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
          ],
        );
      },
    ),
  ) : const Text('Nnehuma foto adicionada ao perfil do animal!');
}
