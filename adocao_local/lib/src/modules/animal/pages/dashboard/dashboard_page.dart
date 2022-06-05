import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final _textStyle = AppTextStyle();

  DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            cardInfo(
              '6',
              'Total de animais disponíveis para adoção no momento.',
              fullLine: true,
            ),
            Row(
              children: [
                Expanded(
                  child: cardInfo('35', 'Solicitações\npendentes'),
                ),
                Expanded(
                  child: cardInfo('12', 'Animais\nadotados'),
                ),
              ],
            ),
            cardInfo(
              '120',
              'Total de visitas recebidas (Pendente)',
              fullLine: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget cardInfo(String number, String description, {fullLine = false}) =>
      Card(
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
