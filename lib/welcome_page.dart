import 'package:flutter/material.dart';

import 'tasks_page.dart';

// Page d'accueil de l'application
class WelcomePage extends StatelessWidget {

  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Conteneur principal avec un arrière-plan en dégradé
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF7E57C2), Color(0xFF4527A0)],
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),

            // Organisation des éléments verticalement
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Icône principale de l'application
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.task_alt,
                    size: 90,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 40),

                // Nom de l'application
                const Text(
                  'TodoApp',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 12),

                // Description de l'application
                Text(
                  'Organisez vos tâches simplement',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),

                const SizedBox(height: 56),

                // Bouton pour accéder à la liste des tâches
                SizedBox(
                  width: 240,
                  height: 54,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF4527A0),
                    ),

                    // Navigation vers la page des tâches
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TasksPage(),
                      ),
                    ),

                    icon: const Icon(Icons.arrow_forward),

                    // Texte du bouton
                    label: const Text(
                      'go to the list',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}