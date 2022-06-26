import 'package:adocao_local/src/modules/animal/repositories/animal_repository.dart';
import 'package:adocao_local/src/shares/core/app_text_theme.dart';
import 'package:adocao_local/src/shares/services/app_preferences_service.dart';
import 'package:adocao_local/src/shares/services/http_client_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _textStyle = AppTextStyle();
  int pedding_requests = 0;
  int available_animal_adoption = 0;
  int adopted_animals = 0;
  bool loading = true;

  final storage = AnimalRepository(
    client: HttpClientService(),
    appData: AppPreferenceService(),
  );

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  void getDashboardData() async {
    setLoading(true);
    try {
      Map response = await storage.dashboard();
      setState(() {
        pedding_requests = response['pedding_requests'];
        available_animal_adoption = response['available_animals'];
        adopted_animals = response['adopted_animals'];
      });
    } catch (error) {
      if (kDebugMode) {
        print('Erro ao carregar dados do dashboard');
        print(error);
      }
    } finally {
      setLoading(false);
    }
  }

  @override
  void initState() {
    getDashboardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  cardInfo(
                    Colors.white,
                    '$available_animal_adoption',
                    'Total de animais disponíveis para adoção no momento.',
                    fullLine: true,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: cardInfo(Colors.white, '$pedding_requests',
                            'Solicitações\npendentes'),
                      ),
                      Expanded(
                        child: cardInfo(Colors.white, '$adopted_animals',
                            'Animais\nadotados'),
                      ),
                    ],
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
