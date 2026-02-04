import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Adicione este import
import 'package:agenda_musical/core/router.dart';

void main() {
  // Inicializa a formatação de data para o Brasil
  initializeDateFormatting('pt_BR', null).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MyRoadie',
      debugShowCheckedModeBanner: false,

      // Rotas
      routerConfig: router,

      // Configuração de Idioma (Para o calendário ficar em PT-BR)
      locale: const Locale('pt', 'BR'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],

      // Tema Personalizado com as cores do MyRoadie
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFf59e0b), // Laranja Principal
          primary: const Color(0xFFf59e0b),
          secondary: const Color(0xFF2c3e50), // Azul Escuro
          background: Colors.white, // Fundo branco limpo
        ),

        // Estilo padrão da AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent, // Remove o tint roxo do scroll
          centerTitle: false,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF2c3e50)),
        ),

        // Estilo padrão dos Inputs (Bordas arredondadas)
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFf59e0b), width: 2),
          ),
        ),
      ),
    );
  }
}
