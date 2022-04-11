import 'package:adocao_local/src/modules/account/models/state_model.dart';

abstract class ILocationStorage {
  Future<List<StateModel>> getStates();
}
