import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
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
          _buildCustomField(
            label: 'Nome Artístico *',
            hint: 'Lucas David Oliveira',
          ),

          _buildCustomField(
            label: 'Anos de Experiência',
            hint: 'Ex: 10',
            keyboardType: TextInputType.number,
          ),

          _buildCustomField(
            label: 'Telefone/WhatsApp *',
            hint: '(11) 99999-9999',
            keyboardType: TextInputType.phone,
          ),

          _buildCustomField(label: 'Instagram', hint: '@seuinstagram'),

          _buildCustomField(label: 'Cidade *', hint: 'São Paulo'),

          _buildCustomField(label: 'Estado *', hint: 'SP'),

          _buildCustomField(
            label: 'Cachê Mínimo (R\$)',
            hint: '500',
            keyboardType: TextInputType.number,
          ),

          _buildCustomField(
            label: 'Link do Vídeo (YouTube)',
            hint: 'https://youtube.com/...',
            keyboardType: TextInputType.url,
          ),

          _buildCustomField(
            label: 'Biografia *',
            hint:
                'Conte sobre sua trajetória musical, experiência e diferenciais...',
            maxLines: 4, // Caixa maior para biografia
          ),
        ],
      ),
    );
  }

  // Método auxiliar para criar os campos padronizados
  Widget _buildCustomField({
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. O Rótulo (Label) fora da caixa
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600, // Semi-negrito
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0), // Espaço entre o rótulo e o input
          // 2. O Campo de Texto
          TextField(
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: hint, // Texto de exemplo cinza
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              // Borda quando não está focado (Cinza clarinho)
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  6,
                ), // Borda levemente arredondada
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              // Borda quando clicado (Azul ou a cor primária do app)
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.blue, width: 1.5),
              ),
              isDense: true,
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
