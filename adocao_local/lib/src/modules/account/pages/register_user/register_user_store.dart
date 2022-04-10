import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'register_user_store.g.dart';

class RegisterUserStore extends _RegisterUserStore with _$RegisterUserStore {}

abstract class _RegisterUserStore with Store {
  @observable
  String name = '';
  @observable
  String username = '';
  @observable
  String contact = '';
  @observable
  String password = '';
  @observable
  String repeatPassword = '';

  ObservableList<State> states = ObservableList<State>();

  @action
  void setName(String value) => name = value;
  @action
  void setUsername(String value) => username = value;
  @action
  void setContact(String value) => contact = value;
  @action
  void setPassword(String value) => password = value;
  @action
  void setRepeatPassword(String value) => repeatPassword = value;
}
