import 'package:adocao_local/src/modules/account/pages/login/login_page.dart';
import 'package:adocao_local/src/modules/animal/interfaces/animal_interface.dart';
import 'package:adocao_local/src/modules/animal/interfaces/animal_request_interface.dart';
import 'package:adocao_local/src/modules/animal/models/adoption_request_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
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

part 'show_animal_store.g.dart';

class ShowAnimalStore extends _ShowAnimalStore with _$ShowAnimalStore {
  ShowAnimalStore({
    required IAppData appData,
    required IAnimalStorage storage,
    required IAnimalRequestStorage adoptionStorage,
    required AnimalModel animal,
  }) {
    super.appData = appData;
    super.storage = storage;
    super.adoptionStorage = adoptionStorage;
    super.animal = animal;
  }
}

abstract class _ShowAnimalStore with Store {
  late IAppData appData;
  late IAnimalStorage storage;
  late IAnimalRequestStorage adoptionStorage;
  late AnimalModel animal;
  ObservableList<AdoptionRequestModel> adoptionRequests =
      ObservableList<AdoptionRequestModel>();

  @observable
  bool loading = false;
  @observable
  bool update = false;

  @action
  void setLoading(bool value) => loading = value;
  @action
  void setUpdate() => update = !update;

  Future<void> loadAnimalPhotos() async {
    final response = await adoptionStorage.allAdoptionRequestFromAnimal(animal);
    adoptionRequests.addAll(response);
  }

  Future<void> acceptAdoptionRequest(
      BuildContext context,
      AdoptionRequestModel adoptionRequest,
      ) async {
    try {
      await adoptionStorage.confirmAdoptionRequest(animal, adoptionRequest);
      adoptionRequest.accept;
      animal.adopted = true;
      asuka.showSnackBar(asuka.AsukaSnackbar.success(
        'Parabéns pela adoção do animal :D',
      ));
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

  Future<void> recuseAdoptionRequest(
    BuildContext context,
    AdoptionRequestModel adoptionRequest,
  ) async {
    try {
      await adoptionStorage.rejectAdoptionRequest(animal, adoptionRequest);
      adoptionRequest.reject;
      asuka.showSnackBar(asuka.AsukaSnackbar.success(
        'Solicitação recusada',
      ));
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

  ImageProvider getAnimalPhoto() {
    if (animal.photos.isNotEmpty) {
      IClientHTTP client = HttpClientService();
      return NetworkImage(
        client.host + animal.photos.first.url,
      );
    }
    return AssetImage(
      AppAssets.catAndDog,
    );
  }
}
