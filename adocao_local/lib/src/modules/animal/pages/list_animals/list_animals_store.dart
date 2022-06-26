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
  ObservableList<AnimalModel> showAnimalList = ObservableList<AnimalModel>();

  @observable
  bool loading = false;
  @observable
  bool update = false;

  @action
  void setLoading(bool value) => loading = value;
  @action
  void setUpdate() => update = !update;

  void search(String keyword) {
    List<AnimalModel> result = [];
    for (AnimalModel animal in animalList) {
      if (animal.name.toLowerCase().contains(keyword.toLowerCase())) {
        result.add(animal);
      }
    }
    showAnimalList.clear();
    showAnimalList.addAll(result);
  }

  Future<void> loadAnimals(BuildContext context) async {
    try {
      setLoading(true);
      List<AnimalModel> responseList = await storage.allAnimals();
      animalList.clear();
      animalList.addAll(responseList);
      showAnimalList.clear();
      showAnimalList.addAll(responseList);
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

  void goToCreateAnimalPage({
    required BuildContext context,
    AnimalModel? animal,
  }) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CreateAnimalPage(animal: animal)),
    ).then((_) async {
      loadAnimals(context);
      setUpdate();
    });
  }

  Future<void> blockAnimal(BuildContext context, AnimalModel animal) async {
    try {
      setLoading(true);
      await storage.blockAnimal(animal);
      animal.blocked = true;
      asuka.showSnackBar(asuka.AsukaSnackbar.success('Animal bloqueado'));
      setUpdate();
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

  Future<void> unlockAnimal(BuildContext context, AnimalModel animal) async {
    try {
      setLoading(true);
      await storage.unlockAnimal(animal);
      animal.blocked = false;
      asuka.showSnackBar(asuka.AsukaSnackbar.success('Animal desbloqueado'));
      setUpdate();
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

  Future<void> removeAnimal(BuildContext context, AnimalModel animal) async {
    try {
      setLoading(true);
      await storage.delete(animal);
      animalList.remove(animal);
      showAnimalList.clear();
      showAnimalList.addAll(animalList);
      asuka.showSnackBar(asuka.AsukaSnackbar.success('Animal deletado'));
      setUpdate();
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

  void goToShowAnimalPage(BuildContext context, AnimalModel animal) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ShowAnimalPage(animal: animal)),
    ).then((_) async {
      loadAnimals(context);
      setUpdate();
    });
  }

  ImageProvider getAnimalPhoto(AnimalModel animal) {
    if (animal.photos.isNotEmpty) {
      IClientHTTP client = HttpClientService();
      return NetworkImage(client.host + animal.photos.first.url);
    }
    return AssetImage(
      animal.animalType.name == 'Cachorro'
          ? AppAssets.dog
          : animal.animalType.name == 'Gato'
              ? AppAssets.cat
              : AppAssets.logo,
    );
  }
}
