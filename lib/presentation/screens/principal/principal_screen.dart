import 'package:agenda_musical/presentation/screens/principal/widgets/commitments_widget.dart';
import 'package:agenda_musical/presentation/screens/principal/widgets/custom_calendar.dart';
import 'package:agenda_musical/presentation/screens/principal/widgets/header_widget.dart';
import 'package:agenda_musical/presentation/screens/principal/widgets/infos_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrincipalScreen extends StatelessWidget {
  const PrincipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Adicionei datas diferentes para testar o agrupamento
    final List<Map<String, dynamic>> events = [
      {
        "title": "Carnaval cxb",
        "initialTime": "19:00",
        "finalTime": "21:00",
        "location": "Calçadão",
        "fee": 3000.0,
        "date": "2026-02-12", // Quinta
        "type": "Show",
      },
      {
        "title": "Show na Praça",
        "initialTime": "21:00",
        "finalTime": "00:00",
        "location": "Calçadão",
        "fee": 3000.0,
        "date": "2026-02-15", // Domingo
        "type": "Ensaio",
      },
    ];

    double calcFee(dynamic fee) {
      double cacheTotal = 0.0;

      for (var event in events) {
        cacheTotal += event['fee'];
      }

      return cacheTotal;
    }

    int totalCompromissos = events.length;

    int calcShows() {
      int showsMonth = 0;
      DateTime now = DateTime.now();
      for (var event in events) {
        // Percorre todos os eventos
        DateTime eventDate = DateTime.parse(
          event['date'],
        ); // Converte a string para DateTime
        if (eventDate.month == now.month && eventDate.year == now.year) {
          // Verifica se o evento é do mês atual
          showsMonth++;
        }
      }
      return showsMonth;
    }

    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset(
          'assets/images/logo.svg',
          width: 100, // Defina o tamanho que quiser
          height: 100,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 8.0,
          children: [
            IconButton(
              icon: Icon(Icons.calendar_today, color: Color(0xFFf59e0b)),
              onPressed: () {
                // Ação do calendário
                // Navega para a tela do calendário ou página principal
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Ação do calendário
                // Navega para a tela de Perfil do Usuário
              },
            ),
            const SizedBox(
              height: 40, // Define a altura da barra
              child: VerticalDivider(
                color: Colors.grey,
                thickness: 2, // Espessura da linha
                indent: 5, // Espaço no topo
                endIndent: 5, // Espaço na base
              ),
            ),
            Icon(Icons.logout),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 8,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: HeaderWidget(),
              ),
            ),
            InfosWidget(
              compromissosTotal: totalCompromissos,
              compromissosConcluidos: 0,
              shows: calcShows(),
              faturamento: calcFee(0.0),
            ),
            CustomCalendar(),
            CommitmentsWidget(commitments: events),
          ],
        ),
      ),
    );
  }
}
