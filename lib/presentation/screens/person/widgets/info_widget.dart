import 'package:agenda_musical/core/constants/app_colors.dart';
import 'package:agenda_musical/core/constants/app_strings.dart';
import 'package:agenda_musical/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // Sombra mais suave
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alinha tudo à esquerda
        mainAxisSize: MainAxisSize.min,
        children: [
          // Título da Seção
          const Text(
            'Informações Básicas',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24.0),

          // Campos do formulário usando o método auxiliar
          CustomTextField(
            label: AppStrings.labelArtistName,
            hint: AppStrings.hintArtistName,
            isRequired: true,
            onChanged: (val) => print(val),
          ),

          CustomTextField(
            label: AppStrings.labelExperience,
            hint: AppStrings.hintExperience,
            keyboardType: TextInputType.number,
          ),

          CustomTextField(
            label: AppStrings.labelPhone,
            hint: AppStrings.hintPhone,
            keyboardType: TextInputType.phone,
          ),

          CustomTextField(
            label: AppStrings.labelInstagram,
            hint: AppStrings.hintInstagram,
            keyboardType: TextInputType.url,
          ),

          CustomTextField(
            label: AppStrings.labelCity,
            hint: AppStrings.hintCity,
          ),

          CustomTextField(
            label: AppStrings.labelState,
            hint: AppStrings.hintState,
          ),

          CustomTextField(
            label: AppStrings.labelMinimumFee,
            hint: AppStrings.hintMinimumFee,
            keyboardType: TextInputType.number,
          ),

          CustomTextField(
            label: AppStrings.labelVideoLink,
            hint: AppStrings.hintVideoLink,
            keyboardType: TextInputType.url,
          ),

          CustomTextField(
            label: AppStrings.labelBio,
            hint: AppStrings.hintBio,
            maxLines: 4, // Caixa maior para biografia
          ),
        ],
      ),
    );
  }
}
