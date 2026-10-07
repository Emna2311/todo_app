import 'package:flutter/material.dart';

import 'welcome_page.dart';

void main() => runApp(const TodoApp());

// Classe principale de l'application
class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  // Construction de l'interface
  @override
  Widget build(BuildContext context) => MaterialApp(

        title: 'TodoApp',
        // Masquer la bannière DEBUG
        debugShowCheckedModeBanner: false,

        // Configuration du thème de l'application
        theme: ThemeData(
          colorSchemeSeed: Colors.deepPurple,
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF6F1FA),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            titleTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D1B4E)),
          ),
        ),

        // Première page affichée au lancement
        home: const WelcomePage(),
      );
}