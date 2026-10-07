import 'package:flutter/material.dart';
import 'task.dart';

// Fenêtre utilisée pour ajouter ou modifier une tâche
class TaskDialog extends StatefulWidget {

  // Tâche existante en cas de modification
  final Task? task;

  const TaskDialog({super.key, this.task});

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {

  // Contrôleur du champ titre
  // Si on modifie une tâche, le titre existant est affiché
  late final TextEditingController _title =
      TextEditingController(text: widget.task?.title ?? '');
  late final TextEditingController _content =
      TextEditingController(text: widget.task?.content ?? '');

  @override
  void dispose() {
    // Libération des contrôleurs lorsqu'ils ne sont plus utilisés
    _title.dispose();
    _content.dispose();
    super.dispose();
  }

  InputDecoration _deco(String label) => InputDecoration(
        hintText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );

  @override
  Widget build(BuildContext context) {

    // Vérifie si on est en mode modification
    final isEdit = widget.task != null;

    return AlertDialog(
      backgroundColor: const Color(0xFFEEE5EE),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),

      // Le titre change selon l'action
      title: Text(isEdit ? 'Edit Task' : 'Add Task'),

      // Champs de saisie
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _title,
            decoration: _deco('Title'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _content,
            decoration: _deco('Content'),
          ),
        ],
      ),

      // Boutons du popup
      actions: [

        // Fermer la fenêtre sans enregistrer
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),

        // Ajouter ou modifier la tâche
        FilledButton.tonal(
          onPressed: () {
            final title = _title.text.trim();

            // Le titre est obligatoire
            if (title.isEmpty) return;

            // Retourne la tâche créée ou modifiée
            Navigator.pop(
              context,
              Task(
                title: title,
                content: _content.text.trim(),
              ),
            );
          },

          // Le texte du bouton change selon le mode
          child: Text(isEdit ? 'Save' : 'Add'),
        ),
      ],
    );
  }
}