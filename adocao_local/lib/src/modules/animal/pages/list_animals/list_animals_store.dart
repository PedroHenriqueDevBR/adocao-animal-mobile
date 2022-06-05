import 'package:adocao_local/src/modules/account/pages/login/login_page.dart';
import 'package:adocao_local/src/modules/animal/interfaces/animal_interface.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/pages/edit_animal/edit_animal_page.dart';
import 'package:adocao_local/src/modules/animal/pages/show_animal/show_animal_page.dart';
import 'package:adocao_local/src/shares/core/app_assets.dart';
import 'package:adocao_local/src/shares/exceptions/connection_refused_exception.dart';
import 'package:adocao_local/src/shares/exceptions/http_response_exception.dart';
import 'package:adocao_local/src/shares/exceptions/unauthorized_exception.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:adocao_local/src/shares/interfaces/client_http_interface.dart';
import 'package:adocao_local/src/shares/services/http_client_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;

part 'list_animals_store.g.dart';

class ListAnimalsStore extends _ListAnimalsStore with _$ListAnimalsStore {
  ListAnimalsStore({
    required IAppData appData,
    required IAnimalStorage storage,
  }) {
    super.appData = appData;
    super.storage = storage;
  }
}

abstract class _ListAnimalsStore with Store {
  late IAppData appData;
  late IAnimalStorage storage;

  ObservableList<AnimalModel> animalList = ObservableList<AnimalModel>();

  @observable
  bool loading = false;
  @observable
  bool update = false;

  @action
  void setLoading(bool value) => loading = value;
  @action
  void setUpdate() => update = !update;

  void loadAnimals(BuildContext context) async {
    try {
      setLoading(true);
      List<AnimalModel> responseList = await storage.allAnimals();
      animalList.addAll(responseList);
    } on ConnectionRefusedException {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert(
        'Sem conexão com o servidor',
      ));
    } on UnauthorizedException {
      asuka.showSnackBar(asuka.AsukaSnackbar.alert(
        'Sessão encerrada, entre novamente',
      ));
      appData.setJWT('');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false,
      );
    } on HttpResponseException catch (error) {
      if (error.response.statusCode >= 500) {
        asuka.showSnackBar(asuka.AsukaSnackbar.alert('Servidor indisponível'));
      }
    } finally {
      setLoading(false);
    }
  }

  void goToCreateAnimalPage(
      {required BuildContext context, AnimalModel? animal}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CreateAnimalPage(animal: animal)),
    );
  }

  void goToShowAnimalPage(BuildContext context, AnimalModel animal) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ShowAnimalPage(animal: animal)),
    );
  }

  ImageProvider getAnimalPhoto(AnimalModel animal) {
    if (animal.photos.isNotEmpty) {
      IClientHTTP client = HttpClientService();
      return NetworkImage(client.host + animal.photos.first.url);
    }
    return AssetImage(AppAssets.catAndDog);
  }
}
