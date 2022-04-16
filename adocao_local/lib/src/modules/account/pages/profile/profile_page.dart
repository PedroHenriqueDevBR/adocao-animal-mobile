import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:mobx/mobx.dart';
import 'package:asuka/asuka.dart' as asuka;

import './profile_store.dart';
import '../../models/city_model.dart';
import '../../models/state_model.dart';
import '../../repositories/location_repository.dart';
import '../../repositories/user_repository.dart';
import '../../../../shares/core/app_assets.dart';
import '../../../../shares/core/app_text_theme.dart';
import '../../../../shares/services/app_preferences_service.dart';
import '../../../../shares/services/http_client_service.dart';
import '../../../../shares/widgets/dropdown_conrtainer/dropdown_container_widget.dart';

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
                  color: Theme.of(context).colorScheme.secondary,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 36.0),
                      Observer(
                        builder: (_) => controller.image != null
                            ? Container(
                                height: 175.0,
                                width: 175.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 6,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    100.0,
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                    image: NetworkImage(
                                      '${client.host}${controller.image}',
                                    ),
                                  ),
                                ),
                              )
                            : Image.asset(
                                AppAssets.avatar,
                                width: 175,
                                fit: BoxFit.fill,
                              ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextButton(
                              child: Text(
                                'Atualizar Imagem',
                                style: appTextStyle.textButton.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () => asuka.showModalBottomSheet(
                                builder: (modalContext) {
                                  return updateImageModal(modalContext, size);
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              child: Text(
                                'Remover Imagem',
                                style: appTextStyle.textButton.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: controller.image != null
                                  ? () => asuka.showDialog(
                                        builder: (dialogContext) {
                                          return confirmImageRemove(
                                            dialogContext,
                                          );
                                        },
                                      )
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).backgroundColor,
                  padding: const EdgeInsets.all(16.0),
                  child: updateUserFormWidget(),
                )
              ],
            ),
          ),
          controller.loading ? loadingWidget(size) : Container(),
        ],
      ),
    );
  }

  Widget loadingWidget(Size size) => Container(
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
                style: appTextStyle.titleStyle.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      );

  Widget confirmImageRemove(BuildContext dialogContext) {
    return AlertDialog(
      title: const Text(
        'Atenção',
      ),
      content: const Text(
        'Confirmar a remoção da imagem?',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(dialogContext);
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            controller.removeImage();
            Navigator.pop(dialogContext);
          },
          child: const Text('Confirmar'),
        ),
      ],
    );
  }

  Widget updateImageModal(BuildContext modalContext, Size size) {
    return StatefulBuilder(
      builder: (_, StateSetter setState) {
        return Column(
          children: [
            Container(
              width: size.width,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Atualizar imagem',
                    style:
                        appTextStyle.textButton.copyWith(color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(modalContext);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              color: Theme.of(context).colorScheme.secondary,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  Platform.isAndroid || Platform.isIOS
                      ? await controller.getImageFromGalery().then(
                            (value) => setState(() {}),
                          )
                      : await controller.getImageFromGaleryDesktop().then(
                            (value) => setState(() {}),
                          );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade900,
                    image: controller.selectedImage != null
                        ? DecorationImage(
                            image: FileImage(
                              controller.selectedImage!,
                            ),
                          )
                        : DecorationImage(
                            image: AssetImage(AppAssets.avatar),
                          ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    Platform.isAndroid || Platform.isIOS
                        ? await controller.getImageFromGalery().then(
                              (value) => setState(() {}),
                            )
                        : await controller.getImageFromGaleryDesktop().then(
                              (value) => setState(() {}),
                            );
                  },
                  child: const Text('Abrir galeria'),
                ),
                TextButton(
                  onPressed: () => controller.updateImage(modalContext),
                  child: const Text('Salvar imagem'),
                ),
              ],
            )
          ],
        );
      },
    );
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
                    onPressed: controller.updateUser,
                    child: const Text('Atualizar dados'),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.logout,
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
