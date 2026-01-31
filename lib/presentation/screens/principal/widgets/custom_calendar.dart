// Necessário importar o pacote intl para usar DateFormat
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Exemplo de eventos (simulando os "cards" laranjas da imagem)
  final Map<DateTime, List<String>> _events = {};

  List<String> _getEventsForDay(DateTime day) {
    // Normaliza a data para ignorar horas/minutos na comparação
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _events[normalizedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    // Estilo comum para o container branco (Card)
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCustomHeader(),
          const SizedBox(height: 10),
          TableCalendar(
            locale: 'pt_BR',
            firstDay: DateTime.utc(2020, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: _getEventsForDay,

            // CONFIGURAÇÃO VISUAL
            headerVisible:
                false, // Desligamos o header padrão para usar o nosso
            daysOfWeekHeight: 40,

            calendarStyle: CalendarStyle(
              // Dia de Hoje (Círculo Laranja vazado ou cheio conforme preferir)
              todayDecoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              todayTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),

              // Dias selecionados
              selectedDecoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.5),
                shape: BoxShape.circle,
              ),

              // Dias fora do mês (cinza claro)
              outsideDaysVisible: true,
              outsideTextStyle: TextStyle(color: Colors.grey.shade300),
              defaultTextStyle: const TextStyle(color: Colors.black87),
              weekendTextStyle: const TextStyle(color: Colors.black87),
            ),

            // BUILDERS AVANÇADOS (Para os cards de evento laranjas)
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isEmpty) return const SizedBox();

                // Desenha os bloquinhos laranjas
                return Positioned(
                  bottom: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: events.take(2).map((event) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        width: 25, // Largura do "card"
                        height: 15,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        // Opcional: Texto dentro do marcador (ex: "1...")
                        child: Center(
                          child: Text(
                            "${events.indexOf(event as String) + 1}...",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Header customizado para ficar igual ao da imagem
  Widget _buildCustomHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Título: Janeiro 2026
        Text(
          _capitalizeMonth(
            DateFormat('MMMM yyyy', 'pt_BR').format(_focusedDay),
          ),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey, // Azul escuro do título
          ),
        ),

        // Controles: Botão Hoje e Setas
        Row(
          children: [
            // Botão "Hoje"
            TextButton(
              onPressed: () {
                setState(() {
                  _focusedDay = DateTime.now();
                });
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Hoje',
                style: TextStyle(color: Colors.black87),
              ),
            ),
            const SizedBox(width: 8),

            // Seta Esquerda
            _buildArrowButton(
              icon: Icons.chevron_left,
              onTap: () {
                setState(() {
                  _focusedDay = DateTime(
                    _focusedDay.year,
                    _focusedDay.month - 1,
                  );
                });
              },
            ),

            const SizedBox(width: 4),

            // Seta Direita
            _buildArrowButton(
              icon: Icons.chevron_right,
              onTap: () {
                setState(() {
                  _focusedDay = DateTime(
                    _focusedDay.year,
                    _focusedDay.month + 1,
                  );
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildArrowButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 20, color: Colors.blueGrey),
        onPressed: onTap,
      ),
    );
  }

  // Função auxiliar para deixar a primeira letra maiúscula
  String _capitalizeMonth(String text) {
    return "${text[0].toUpperCase()}${text.substring(1)}";
  }
}
