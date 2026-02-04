import 'package:agenda_musical/domain/models/event_model.dart';
import 'package:agenda_musical/presentation/widgets/new_appointment_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Necessário para formatar a data (adicione no pubspec.yaml)
import 'package:intl/date_symbol_data_local.dart'; // Para carregar o pt_BR

class CommitmentsWidget extends StatefulWidget {
  final List<EventModel> commitments;
  final Function(EventModel) onConfirm;
  const CommitmentsWidget({
    super.key,
    required this.commitments,
    required this.onConfirm,
  });

  @override
  State<CommitmentsWidget> createState() => _CommitmentsWidgetState();
}

class _CommitmentsWidgetState extends State<CommitmentsWidget> {
  // --- 1. Controladores (Para pegar o texto digitado) ---
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _cacheController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializa a formatação de data em Português
    initializeDateFormatting('pt_BR', null);
  }

  @override
  void dispose() {
    // É boa prática limpar os controladores ao fechar a tela
    _titleController.dispose();
    _locationController.dispose();
    _cacheController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Ordenar a lista por data para garantir que o agrupamento funcione
    widget.commitments.sort((a, b) => a.date.compareTo(b.date));

    return Card(
      elevation:
          0, // O card "pai" na imagem parece não ter sombra, é flat no fundo branco
      margin: const EdgeInsets.all(16.0),
      color: Colors
          .transparent, // Deixei transparente para focar nos cards internos
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho Principal
          Row(
            children: const [
              Icon(
                Icons.calendar_month_outlined,
                size: 28,
                color: Color(0xFFf59e0b),
              ),
              SizedBox(width: 8),
              Text(
                "Próximos Compromissos",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Lógica de Construção da Lista com Cabeçalhos de Data
          ListView.builder(
            shrinkWrap: true, // Importante para usar ListView dentro de Column
            physics:
                const NeverScrollableScrollPhysics(), // A rolagem deve ser da tela, não do widget
            itemCount: widget.commitments.length,
            itemBuilder: (context, index) {
              final commitment = widget.commitments[index];

              // Verifica se precisa mostrar o cabeçalho da data
              bool showHeader = false;
              if (index == 0) {
                showHeader = true;
              } else {
                // Se a data deste item for diferente do anterior, mostra cabeçalho
                if (commitment.date != widget.commitments[index - 1].date) {
                  showHeader = true;
                }
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showHeader)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: Text(
                        _formatDateTitle(commitment.date.toIso8601String()),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  _commitmentCard(commitment),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Função para formatar a data igual à imagem: "Quinta-Feira, 12 De Fevereiro"
  String _formatDateTitle(String dateString) {
    DateTime date = DateTime.parse(dateString);
    // 'EEEE' = Dia da semana, 'd' = dia, 'MMMM' = Mês extenso
    String formatted = DateFormat("EEEE, d 'de' MMMM", 'pt_BR').format(date);
    // Deixar a primeira letra maiúscula
    return formatted[0].toUpperCase() + formatted.substring(1);
  }

  Widget _commitmentCard(EventModel event) {
    return Container(
      // Padding interno reduzido para ficar compacto como na foto
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 12.0), // Espaço entre os cards
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: const Border(
          left: BorderSide(color: Color(0xFFf59e0b), width: 6.0),
          top: BorderSide(color: Color(0xFFf59e0b), width: 1.0), // Borda fina
          right: BorderSide(color: Color(0xFFf59e0b), width: 1.0), // Borda fina
          bottom: BorderSide(
            color: Color(0xFFf59e0b),
            width: 1.0,
          ), // Borda fina
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Linha do Topo: Ícone + Tag + Ícones de Ação
          Row(
            children: [
              const Icon(
                // Icons.electric_guitar,
                Icons.queue_music,
                size: 20,
                color: Colors.purple,
              ), // Ícone guitarra (exemplo)
              const SizedBox(width: 8),

              // Tag "Show"
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFf59e0b),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.commitments.first.type,
                  style: TextStyle(
                    fontSize: 12, // CORRIGIDO: 24 era muito grande
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const Spacer(), // Empurra os ícones de edição para a direita

              IconButton(
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 28,
                  color: Colors.blueGrey,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(16),
                      child: NewAppointmentWidget(
                        event:
                            event, // <--- CORREÇÃO: Passa o evento atual que veio por parâmetro
                        onConfirm: (eventoEditado) {
                          // Passa para cima (PrincipalScreen) resolver
                          widget.onConfirm(eventoEditado);
                        },
                      ),
                    ),
                  );

                  // Fecha o modal
                  // context.pop();
                  // Futuro: Salvar no Firebase
                },
              ),
              const SizedBox(width: 16),
              Icon(Icons.delete_outline, size: 28, color: Colors.blueGrey[400]),
            ],
          ),

          const SizedBox(height: 12),

          // Título e Detalhes
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              event.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Informações (Hora, Local, Preço)
          _buildInfoRow(
            Icons.schedule,
            "${event.startTime} - ${event.endTime}",
          ),
          const SizedBox(height: 4),
          _buildInfoRow(Icons.location_on_outlined, event.location),
          const SizedBox(height: 4),
          _buildInfoRow(
            Icons.attach_money,
            "R\$ ${event.fee.toStringAsFixed(2)}",
            textColor: Colors.teal, // Cor verde do dinheiro
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para não repetir código nas linhas de informação
  Widget _buildInfoRow(
    IconData icon,
    String text, {
    Color textColor = Colors.grey,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            color: textColor == Colors.grey ? Colors.grey[700] : textColor,
            fontSize: 14,
            fontWeight: textColor == Colors.grey
                ? FontWeight.normal
                : FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
