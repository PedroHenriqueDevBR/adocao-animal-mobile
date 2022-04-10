import 'package:adocao_local/src/modules/account/models/city_model.dart';
import 'package:adocao_local/src/modules/account/models/state_model.dart';
import 'package:adocao_local/src/modules/account/pages/register_user/register_user_store.dart';
import 'package:adocao_local/src/modules/account/repositories/user_repository.dart';
import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:adocao_local/src/shares/services/app_preferences_service.dart';
import 'package:adocao_local/src/shares/services/http_client_service.dart';
import 'package:adocao_local/src/shares/widgets/dropdown_conrtainer/dropdown_container_widget.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({Key? key}) : super(key: key);

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  AppTextStyle appTextStyle = AppTextStyle();
  late RegisterUserStore controller;
  final client = HttpClientService();
  final appData = AppPreferenceService();

  @override
  void initState() {
    controller = RegisterUserStore(
      context: context,
      appData: appData,
      storage: UserRepository(client: client, appData: appData),
    );
    controller.populateStates();
    super.initState();
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Cadastrar-se'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: registerUserFormWidget(),
              ),
            ),
          ),
          controller.loading
              ? Container(
                  width: size.width,
                  height: size.height,
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'Carregando..',
                          style: appTextStyle.titleStyle
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget registerUserFormWidget() => Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Crie uma nova conta para publicar os seus aminais para adoção.',
              style: appTextStyle.textButton,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Dados pessoais',
                    style: appTextStyle.descriptionStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: (value) => controller.setName(value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (value.length < 3) {
                        return 'Mínimo de 3 caracteres';
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Nome completo',
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextFormField(
                    onChanged: (value) => controller.setUsername(value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      } else if (value.length < 5) {
                        return 'Mínimo de 5 caracteres';
                      }
                    },
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              onChanged: (value) => controller.setContact(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                } else if (!controller.phoneNumberIsValid(value)) {
                  return 'Número informado não é válido';
                }
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter(),
              ],
              decoration: const InputDecoration(
                labelText: 'Contato',
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Acesso à plataforma',
                    style: appTextStyle.descriptionStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Observer(
              builder: (_) => TextFormField(
                onChanged: (value) => controller.setPassword(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  } else if (value.length < 8) {
                    return 'Mínimo de 8 caracteres';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixIcon: IconButton(
                    onPressed: () => controller.toggleShowPassword(),
                    icon: Icon(
                      controller.showPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                obscureText: controller.showPassword ? false : true,
              ),
            ),
            const SizedBox(height: 8.0),
            Observer(
              builder: (_) => TextFormField(
                onChanged: (value) => controller.setRepeatPassword(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  } else if (value.length < 8) {
                    return 'Mínimo de 8 caracteres';
                  } else if (value != controller.password) {
                    return 'As senhas informadas não conferem';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Repetir senha',
                  suffixIcon: IconButton(
                    onPressed: () => controller.toggleRepeatShowPassword(),
                    icon: Icon(
                      controller.showRepeatPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                obscureText: controller.showRepeatPassword ? false : true,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Localização',
                    style: appTextStyle.descriptionStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: DropdownContainerWidget(
                    child: Observer(
                      builder: (_) => DropdownButton<StateModel>(
                        onChanged: controller.selectState,
                        isExpanded: true,
                        underline: const SizedBox(),
                        hint: const Text('Estado'),
                        value: controller.selectedState,
                        items: controller.stateList
                            .map(
                              (StateModel state) =>
                                  DropdownMenuItem<StateModel>(
                                value: state,
                                child: Text(state.name),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Observer(
                    builder: (_) => controller.cityListHasElements
                        ? Expanded(
                            child: DropdownContainerWidget(
                              child: Observer(
                                builder: (_) => DropdownButton<CityModel>(
                                  onChanged: controller.selectCity,
                                  elevation: 4,
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  hint: const Text('Cidade'),
                                  value: controller.selectedCity,
                                  items: controller.cityList
                                      .map(
                                        (CityModel city) =>
                                            DropdownMenuItem<CityModel>(
                                          value: city,
                                          child: Text(city.name),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          )
                        : Container()),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Observer(builder: (_) {
                    return ElevatedButton(
                      onPressed: controller.formIsValid
                          ? controller.registerUser
                          : null,
                      child: const Text('Registrar'),
                    );
                  }),
                ),
              ],
            ),
            TextButton(
              onPressed: controller.goToLoginPage,
              child: const Text(
                'Já tenho cadastro, retornar para a tela de login',
              ),
            ),
          ],
        ),
      );
}
