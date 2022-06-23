import 'package:adocao_local/src/modules/animal/interfaces/animal_interface.dart';
import 'package:adocao_local/src/modules/animal/repositories/animal_repository.dart';
import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:adocao_local/src/shares/services/app_preferences_service.dart';
import 'package:adocao_local/src/shares/services/http_client_service.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final _textStyle = AppTextStyle();
  final storage = AnimalRepository(
    client: HttpClientService(),
    appData: AppPreferenceService(),
  );

  DashboardPage({Key? key}) : super(key: key);

  void getDashboardData() async {
    Map response = await storage.dashboard();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            cardInfo(
              Colors.white,
              '6',
              'Total de animais disponíveis para adoção no momento.',
              fullLine: true,
            ),
            Row(
              children: [
                Expanded(
                  child:
                      cardInfo(Colors.white, '35', 'Solicitações\npendentes'),
                ),
                Expanded(
                  child: cardInfo(Colors.white, '12', 'Animais\nadotados'),
                ),
              ],
            ),
            cardInfo(
              Colors.white,
              '120',
              'Total de visitas recebidas (Pendente)',
              fullLine: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget cardInfo(Color color, String number, String description,
          {fullLine = false}) =>
      Card(
        elevation: 0,
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: fullLine
              ? Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        number,
                        style: _textStyle.cardDashboardNumber,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        description,
                        softWrap: true,
                        style: _textStyle.descriptionStyle,
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      number,
                      style: _textStyle.cardDashboardNumber,
                    ),
                    Text(
                      description,
                      softWrap: true,
                      style: _textStyle.descriptionStyle,
                    ),
                  ],
                ),
        ),
      );
}
