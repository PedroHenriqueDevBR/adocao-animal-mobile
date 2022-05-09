import 'package:adocao_local/src/modules/animal/interfaces/animal_interface.dart';
import 'package:adocao_local/src/modules/animal/models/animal_model.dart';
import 'package:adocao_local/src/shares/core/app_assets.dart';
import 'package:adocao_local/src/shares/interfaces/app_data_interface.dart';
import 'package:adocao_local/src/shares/interfaces/client_http_interface.dart';
import 'package:adocao_local/src/shares/services/http_client_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'list_animals_store.g.dart';

class ListAnimalsStore extends _ListAnimalsStore with _$ListAnimalsStore {
  ListAnimalsStore({
    required IAppData appData,
    required IAnimalStorage storage,
    required BuildContext context,
  }) {
    super.appData = appData;
    super.storage = storage;
    super.context = context;
  }
}

abstract class _ListAnimalsStore with Store {
  late IAppData appData;
  late IAnimalStorage storage;
  late BuildContext context;

  ObservableList<AnimalModel> animalList = ObservableList<AnimalModel>();

  @observable
  bool loading = false;
  @observable
  bool update = false;

  @action
  void setLoading(bool value) => loading = value;
  @action
  void setUpdate() => update = !update;

  void loadAnimals() async {
    try {
      setLoading(true);
      List<AnimalModel> responseList = await storage.allAnimals();
      animalList.addAll(responseList);
    } finally {
      setLoading(false);
    }
  }

  ImageProvider getAnimalPhoto(AnimalModel animal) {
    if (animal.photos.isNotEmpty) {
      IClientHTTP client = HttpClientService();
      return NetworkImage(client.host + animal.photos.first.url);
    }
    return AssetImage(AppAssets.catAndDog);
  }
}
