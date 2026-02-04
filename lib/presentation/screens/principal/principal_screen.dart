import 'package:agenda_musical/domain/models/event_model.dart';
import 'package:agenda_musical/presentation/screens/principal/widgets/commitments_widget.dart';
import 'package:agenda_musical/presentation/screens/principal/widgets/custom_calendar.dart';
import 'package:agenda_musical/presentation/screens/principal/widgets/header_widget.dart';
import 'package:agenda_musical/presentation/screens/principal/widgets/infos_widget.dart';
import 'package:agenda_musical/presentation/widgets/my_roadie_app_bar.dart';
import 'package:agenda_musical/presentation/widgets/new_appointment_widget.dart'; // Importe o modal
import 'package:flutter/material.dart';

// 1. Mudamos para StatefulWidget para poder atualizar a lista
class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  // 1. A lista agora é tipada! Adeus Map<String, dynamic>
  List<EventModel> events = [
    EventModel(
      id: '1',
      title: "Carnaval cxb",
      startTime: "19:00",
      endTime: "21:00",
      location: "Calçadão",
      fee: 3000.0,
      date: DateTime(2026, 2, 12),
      type: "Show",
    ),
  ];

  // 2. Função de adicionar recebe o objeto
  void _addNewEvent(EventModel newEvent) {
    setState(() {
      events.add(newEvent);
    });
  }

  // 3. Cálculos muito mais seguros (sem ['fee'] que pode dar erro)
  double calcFee() {
    // fold é um jeito chique de somar lista
    return events.fold(0.0, (sum, event) => sum + event.fee);
  }

  int calcShows() {
    final now = DateTime.now();
    // Olha como ficou legível acessar .date e .month!
    return events
        .where(
          (event) =>
              event.date.month == now.month && event.date.year == now.year,
        )
        .length;
  }

  @override
  Widget build(BuildContext context) {
    // Função para lidar com salvar (Novo ou Edição)
    void _handleEvent(EventModel eventData) {
      setState(() {
        // Procura se já existe um evento com esse ID na lista
        final index = events.indexWhere((e) => e.id == eventData.id);

        if (index != -1) {
          // Se achou (index diferente de -1), é EDIÇÃO: substitui o antigo pelo novo
          events[index] = eventData;
        } else {
          // Se não achou, é NOVO: adiciona na lista
          events.add(eventData);
        }
      });
    }

    return Scaffold(
      appBar: const MyRoadieAppBar(selectedScreen: 'calendar'),

      // 4. Botão Flutuante para Adicionar
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFf59e0b), // Laranja
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // Abre o Modal como Dialog
          showDialog(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(16),
              child: NewAppointmentWidget(
                event: null, // Opcional, pode nem passar esse parâmetro
                onConfirm: _handleEvent, // Usa a mesma função
              ),
            ),
          );
        },
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
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: HeaderWidget(),
              ),
            ),

            // Os Widgets agora recebem os dados atualizados automaticamente
            InfosWidget(
              compromissosTotal: events.length,
              compromissosConcluidos: 0,
              shows: calcShows(),
              faturamento: calcFee(),
            ),

            CustomCalendar(events: events),

            // A lista de cards atualiza quando 'events' muda
            CommitmentsWidget(
              commitments: events,
              onConfirm: _handleEvent, // Usa a mesma função
            ),

            // Espaço extra pro botão flutuante não tampar o último card
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
