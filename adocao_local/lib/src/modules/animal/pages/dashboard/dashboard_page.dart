import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final _textStyle = AppTextStyle();

  DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          cardInfo('6', 'Total de animais disponíveis para adoção no momento.'),
          Row(
            children: [
              Expanded(
                child: cardInfo('35', 'Solicitações pendentes para adoção'),
              ),
              Expanded(
                child: cardInfo('12', 'Animais adotados'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget cardInfo(String number, String description) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
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
          ),
        ),
      );
}
