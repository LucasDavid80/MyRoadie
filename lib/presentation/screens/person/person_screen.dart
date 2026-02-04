import 'package:agenda_musical/presentation/screens/person/widgets/info_widget.dart';
import 'package:agenda_musical/presentation/screens/person/widgets/multi_selection_widget.dart';
import 'package:agenda_musical/presentation/screens/person/widgets/photo_widget.dart';
import 'package:agenda_musical/presentation/widgets/my_roadie_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Listas de dados
    final List<String> instrumentos = [
      'Violão',
      'Guitarra',
      'Baixo',
      'Bateria',
      'Teclado',
      'Piano',
      'Saxofone',
      'Trompete',
      'Violino',
      'Flauta',
      'Cavaquinho',
      'Percussão',
      'Voz/Vocal',
      'Outro',
    ];

    final List<String> estilos = [
      'MPB',
      'Rock',
      'Jazz',
      'Blues',
      'Samba',
      'Forró',
      'Sertanejo',
      'Pop',
      'Gospel',
      'Clássico',
      'Eletrônica',
      'Funk',
      'Rap',
      'Reggae',
      'Outro',
    ];

    return Scaffold(
      appBar: const MyRoadieAppBar(selectedScreen: 'profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          bottom: 40,
        ), // Espaço no final da rolagem
        child: Column(
          children: [
            // --- Cabeçalho ---
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFf59e0b),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Icon(
                      Icons.music_note,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Meu Perfil de Músico",
                        style: TextStyle(
                          fontSize: 20, // Ajustei levemente o tamanho
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Configure seu perfil profissional",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // --- Widgets do Conteúdo ---
            const SizedBox(height: 16), // Espaçamento
            const PhotoWidget(),

            const InfoWidget(), // InfoWidget aparece apenas uma vez aqui
            // Lista de Instrumentos (Direto na Column, sem ListView)
            MultiSelectionWidget(
              title: 'Instrumentos *',
              options: instrumentos,
            ),

            // Lista de Estilos Musicais (Direto na Column)
            MultiSelectionWidget(title: 'Estilos Musicais *', options: estilos),
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Disponíbilidade',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (bool? value) {
                          // Atualiza o valor do checkbox
                          // setState(() {
                          //   // Aqui você atualizaria o estado do checkbox
                          // });
                        },
                      ),
                      Text(
                        'Estou disponível para contratação',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFf59e0b),
                  minimumSize: const Size((double.infinity), 50),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.save, color: Colors.white, size: 28),
                    SizedBox(width: 8),
                    Text(
                      "Salvar Perfil",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
