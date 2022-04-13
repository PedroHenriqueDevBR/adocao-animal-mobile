import 'package:adocao_local/src/modules/account/models/city_model.dart';
import 'package:adocao_local/src/modules/account/models/state_model.dart';
import 'package:adocao_local/src/modules/account/repositories/location_repository.dart';
import 'package:adocao_local/src/modules/account/repositories/user_repository.dart';
import 'package:adocao_local/src/shares/core/app_assets.dart';
import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:adocao_local/src/shares/services/app_preferences_service.dart';
import 'package:adocao_local/src/shares/services/http_client_service.dart';
import 'package:adocao_local/src/shares/widgets/dropdown_conrtainer/dropdown_container_widget.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import './profile_store.dart';
import 'package:mobx/mobx.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AppTextStyle appTextStyle = AppTextStyle();
  late ProfileStore controller;
  final client = HttpClientService();
  final appData = AppPreferenceService();

  @override
  void initState() {
    controller = ProfileStore(
      context: context,
      appData: appData,
      userStorage: UserRepository(client: client, appData: appData),
      locationStorage: LocationRepository(client: client, appData: appData),
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
    final size = MediaQuery.of(context).size;
    return Observer(
        builder: (_) => Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        padding: const EdgeInsets.all(16.0),
                        color: Theme.of(context).colorScheme.secondary,
                        child: Observer(builder: (_) {
                          return Column(
                            children: [
                              Image.asset(
                                AppAssets.avatar,
                                width: 150,
                                fit: BoxFit.fill,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Atualizar Imagem',
                                        style: appTextStyle.textButton.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Remover Imagem',
                                        style: appTextStyle.textButton.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        }),
                      ),
                      Container(
                        color: Theme.of(context).backgroundColor,
                        padding: const EdgeInsets.all(16.0),
                        child: updateUserFormWidget(),
                      )
                    ],
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
            ));
  }

  Widget updateUserFormWidget() => Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            TextFormField(
              controller: controller.username,
              readOnly: true,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: controller.name,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                } else if (value.length < 3) {
                  return 'Mínimo de 3 caracteres';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Nome completo',
              ),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: controller.contact,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                } else if (!controller.phoneNumberIsValid(value)) {
                  return 'Número informado não é válido';
                }
                return null;
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
            const SizedBox(height: 8.0),
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
                      : Container(),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Atualizar dados'),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Encerrar sessão'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
