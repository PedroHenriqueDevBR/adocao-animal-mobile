import 'dart:io';

import 'package:adocao_local/src/modules/animal/models/animal_photo_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_sex_model.dart';
import 'package:adocao_local/src/modules/animal/models/animal_type_model.dart';
import 'package:adocao_local/src/modules/animal/models/vaccine_book_model.dart';
import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:adocao_local/src/shares/widgets/dropdown_conrtainer/dropdown_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AnimalFormWidget extends StatelessWidget {
  final AppTextStyle textStyle;
  final TextEditingController txtName;
  final TextEditingController txtBreed;

  final Function selectAnimalType;
  final AnimalTypeModel? selectedAnimalType;
  final List<AnimalTypeModel> animalTypeList;

  final Function selectAnimalSex;
  final AnimalSexModel? selectedAnimalSex;
  final List<AnimalSexModel> animalSexList;

  final Function confirmImageProvider;
  final Function removeImageAnimalPhoto;
  final Function removeImageFromPhotoPending;
  final Function addVaccineDialog;

  final List<AnimalPhotoModel> animalPhotoList;
  final List<File> animalPhotoPendingList;
  final List<VaccineModel> animalVaccineList;

  const AnimalFormWidget({
    Key? key,
    required this.textStyle,
    required this.txtName,
    required this.txtBreed,
    required this.selectAnimalType,
    required this.selectedAnimalType,
    required this.animalTypeList,
    required this.selectAnimalSex,
    required this.selectedAnimalSex,
    required this.animalSexList,
    required this.confirmImageProvider,
    required this.addVaccineDialog,
    required this.removeImageAnimalPhoto,
    required this.removeImageFromPhotoPending,
    required this.animalPhotoList,
    required this.animalPhotoPendingList,
    required this.animalVaccineList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dados do animal',
          textAlign: TextAlign.left,
          style: textStyle.titleStyle,
        ),
        const SizedBox(height: 16.0),
        Form(child: firstAnimalData(context)),
        const SizedBox(height: 8.0),
        const Divider(),
        Row(
          children: [
            Expanded(
              child: Text(
                'Album de fotos',
                textAlign: TextAlign.left,
                style: textStyle.titleStyle,
              ),
            ),
            IconButton(
              onPressed: () => confirmImageProvider(),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        animalPhotoList.isNotEmpty ? albumWidget(context) : Container(),
        animalPhotoPendingList.isNotEmpty ? pedingPhotos(context) : Container(),
        const SizedBox(height: 8.0),
        const Divider(),
        Row(
          children: [
            Expanded(
              child: Text(
                'Caderneta de vacinação',
                textAlign: TextAlign.left,
                style: textStyle.titleStyle,
              ),
            ),
            IconButton(
              onPressed: () => addVaccineDialog(),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        vaccineBookWidget(),
      ],
    );
  }

  Widget sectionHeaderWidget(
    BuildContext context,
    String title,
    Function action,
  ) =>
      Row(
        children: [
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: textStyle.titleStyle,
            ),
          ),
          IconButton(
            onPressed: () => action(),
            icon: const Icon(Icons.add),
          ),
        ],
      );

  Widget albumWidget(BuildContext context) => GridView.builder(
        itemCount: animalPhotoList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        itemBuilder: (_, index) {
          AnimalPhotoModel photo = animalPhotoList[index];
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(photo.url),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.withAlpha(150),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                    ),
                  ),
                  child: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      onPressed: () => removeImageAnimalPhoto()),
                ),
              ),
            ],
          );
        },
      );

  Widget pedingPhotos(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          const Divider(),
          Text(
            'Imagens preparadas',
            textAlign: TextAlign.left,
            style: textStyle.titleStyle,
          ),
          const SizedBox(height: 12.0),
          GridView.builder(
            itemCount: animalPhotoPendingList.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
            itemBuilder: (_, index) {
              File file = animalPhotoPendingList[index];
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(file),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red.withAlpha(150),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                        ),
                      ),
                      child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: () => removeImageFromPhotoPending()),
                    ),
                  ),
                ],
              );
            },
          )
        ],
      );

  Widget vaccineBookWidget() => ListView.separated(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (_, __) => const Divider(),
        itemCount: animalVaccineList.length,
        itemBuilder: (_, index) {
          VaccineModel vaccine = animalVaccineList[index];
          return ListTile(
            title: Text(vaccine.name),
            subtitle: Text(vaccine.formattedDate),
            trailing: TextButton(
              onPressed: () {},
              child: const Text('Editar'),
            ),
          );
        },
      );

  Widget firstAnimalData(BuildContext context) => Column(
        children: [
          TextFormField(
            controller: txtName,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              labelText: 'Nome do animal (*)',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatório';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: txtBreed,
                  decoration: const InputDecoration(
                    labelText: 'Raça (*)',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Idade (*)',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: DropdownContainerWidget(
                  child: Observer(
                    builder: (_) => DropdownButton<AnimalTypeModel>(
                      onChanged: (value) => selectAnimalType(value),
                      isExpanded: true,
                      underline: const SizedBox(),
                      hint: const Text('Tipo de animal'),
                      value: selectedAnimalType,
                      items: animalTypeList
                          .map(
                            (AnimalTypeModel animalType) =>
                                DropdownMenuItem<AnimalTypeModel>(
                              value: animalType,
                              child: Text(animalType.name),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: DropdownContainerWidget(
                  child: Observer(
                    builder: (_) => DropdownButton<AnimalSexModel>(
                      onChanged: (value) => selectAnimalSex(value),
                      isExpanded: true,
                      underline: const SizedBox(),
                      hint: const Text('Sexo'),
                      value: selectedAnimalSex,
                      items: animalSexList
                          .map(
                            (AnimalSexModel animalSex) =>
                                DropdownMenuItem<AnimalSexModel>(
                              value: animalSex,
                              child: Text(animalSex.name),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
