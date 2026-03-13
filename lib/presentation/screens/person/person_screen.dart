import 'package:agenda_musical/core/constants/app_colors.dart';
import 'package:agenda_musical/presentation/screens/person/widgets/availability_widget.dart';
import 'package:agenda_musical/presentation/screens/person/widgets/info_widget.dart';
import 'package:agenda_musical/presentation/screens/person/widgets/multi_selection_widget.dart';
import 'package:agenda_musical/presentation/screens/person/widgets/photo_widget.dart';
import 'package:agenda_musical/presentation/screens/person/widgets/profile_header.dart';
import 'package:agenda_musical/presentation/widgets/my_roadie_app_bar.dart';
import 'package:flutter/material.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Esses dados depois podem vir de um Controller/Provider
    final List<String> instrumentos = [
      'Violão',
      'Guitarra',
      'Baixo',
      'Bateria',
      'Teclado',
      'Voz/Vocal',
    ];
    final List<String> estilos = ['MPB', 'Rock', 'Jazz', 'Samba', 'Sertanejo'];

    return Scaffold(
      appBar: const MyRoadieAppBar(selectedScreen: 'profile'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileHeader(),
            const SizedBox(height: 16),
            const PhotoWidget(),
            const InfoWidget(),

            MultiSelectionWidget(
              title: 'Instrumentos *',
              options: instrumentos,
              selectedItems: [],
              onToggle: (String) {},
            ),
            MultiSelectionWidget(
              title: 'Estilos Musicais *',
              options: estilos,
              selectedItems: [],
              onToggle: (String) {},
            ),

            AvailabilityWidget(
              isAvailable:
                  false, // Aqui você usará o ref.watch do Riverpod depois
              onChanged: (val) {},
            ),

            _buildSaveButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {},
        icon: const Icon(Icons.save, color: AppColors.textLight),
        label: const Text(
          "Salvar Perfil",
          style: TextStyle(
            color: AppColors.textLight,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
