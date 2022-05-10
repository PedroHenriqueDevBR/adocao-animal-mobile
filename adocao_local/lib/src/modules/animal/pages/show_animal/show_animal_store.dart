import 'package:adocao_local/src/modules/animal/interfaces/animal_interface.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/modules/animal/pages/edit_animal/edit_animal_page.dart';
import 'package:adocao_local/src/modules/animal/pages/show_animal/show_animal_page.dart';
import 'package:adocao_local/src/shares/core/app_assets.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:adocao_local/src/shares/interfaces/client_http_interface.dart';
import 'package:adocao_local/src/shares/services/http_client_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'show_animal_store.g.dart';

class ShowAnimalStore extends _ShowAnimalStore with _$ShowAnimalStore {
  ShowAnimalStore({
    required IAppData appData,
    required IAnimalStorage storage,
    required BuildContext context,
    required AnimalModel animal,
  }) {
    super.appData = appData;
    super.storage = storage;
    super.context = context;
    super.animal = animal;
  }
}

abstract class _ShowAnimalStore with Store {
  late IAppData appData;
  late IAnimalStorage storage;
  late BuildContext context;
  late AnimalModel animal;

  @observable
  bool loading = false;
  @observable
  bool update = false;

  @action
  void setLoading(bool value) => loading = value;
  @action
  void setUpdate() => update = !update;

  Widget getAnimalPhoto() {
    if (animal.photos.isNotEmpty) {
      IClientHTTP client = HttpClientService();
      return Image.network(
        client.host + animal.photos.first.url,
        fit: BoxFit.cover,
      );
    }
    return Image.asset(
      AppAssets.catAndDog,
      fit: BoxFit.cover,
    );
  }
}
