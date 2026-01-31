import 'package:flutter/material.dart';

class InfosWidget extends StatelessWidget {
  int compromissosTotal, compromissosConcluidos, shows;
  double faturamento;
  InfosWidget({
    super.key,
    required this.compromissosTotal,
    required this.compromissosConcluidos,
    required this.shows,
    required this.faturamento,
  });

  @override
  Widget build(BuildContext context) {
    int proximosCompromissos = compromissosTotal - compromissosConcluidos;
    return Column(
      spacing: 16.0,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.0,
          children: [
            infoCard(
              "Este Mês",
              compromissosTotal.toString(),
              Icons.event,
              Color(0xFF3B82F6),
            ),
            infoCard(
              "Próximos",
              proximosCompromissos.toString(),
              Icons.check_circle,
              Color(0xFF10B981),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.0,
          children: [
            infoCard(
              "Shows/Mês",
              shows.toString(),
              Icons.music_note,
              Color(0xFFF59E0B),
            ),
            infoCard(
              "Cachê/Mês",
              faturamento.toString(),
              Icons.attach_money,
              Color(0xFF8B5CF6),
            ),
          ],
        ),
      ],
    );
  }
}

Widget infoCard(String title, String description, IconData icon, Color color) {
  return Card(
    // 1. Força o fundo a ser Branco
    color: Colors.white,
    // 2. Remove a "sujeira" (tint) cinza/azulada causada pela sombra no Material 3
    surfaceTintColor: Colors.white,

    elevation: 2, // Opcional: controla o tamanho da sombra
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ), // Opcional: arredondamento

    child: Container(
      width: 180,
      padding: EdgeInsets.all(8),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 24, color: color),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}
