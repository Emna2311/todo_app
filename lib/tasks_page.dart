import 'package:flutter/material.dart';
import 'task.dart';
import 'task_dialog.dart';

// Page principale qui affiche et gère les tâches
class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {

  // Liste qui contient toutes les tâches
  final List<Task> _tasks = [];
  Future<void> _openDialog({Task? task}) async {
    final result = await showDialog<Task>(
      context: context,
      builder: (_) => TaskDialog(task: task),
    );

    if (result == null) return;

    setState(() {
      if (task == null) {
        // Ajouter une nouvelle tâche
        _tasks.add(result);
      } else {
        // Modifier une tâche existante
        task.title = result.title;
        task.content = result.content;
      }
    });
  }

  // Supprime une tâche avec la possibilité d'annuler
  void _delete(int i) {
    final removed = _tasks[i];

    setState(() => _tasks.removeAt(i));

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('"${removed.title}" supprimée'),
          action: SnackBarAction(
            label: 'Annuler',
            onPressed: () => setState(
              () => _tasks.insert(
                i.clamp(0, _tasks.length),
                removed,
              ),
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {

    // Nombre total de tâches
    final total = _tasks.length;

    // Nombre de tâches terminées
    final done = _tasks.where((t) => t.isCompleted).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Mes tâches')),

      // Bouton pour ajouter une nouvelle tâche
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openDialog(),
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),

      // Affichage différent selon si la liste est vide ou non
      body: total == 0
          ? _emptyState()
          : Column(
              children: [
                _progressCard(done, total),

                // Affiche la liste des tâches
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 90),
                    itemCount: total,
                    itemBuilder: (context, i) => _taskCard(i),
                  ),
                ),
              ],
            ),
    );
  }

  // Affichage lorsqu'il n'y a aucune tâche
  Widget _emptyState() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 90,
              color: Colors.deepPurple.shade200,
            ),
            const SizedBox(height: 16),
            const Text(
              'Aucune tâche pour le moment',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Appuyez sur Add pour commencer',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      );

  // Carte qui affiche la progression des tâches
  Widget _progressCard(int done, int total) => Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF7E57C2), Color(0xFF4527A0)],
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$done / $total terminées',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Barre de progression
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: total == 0 ? 0 : done / total,
                minHeight: 8,
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          ],
        ),
      );

  // Construit une carte représentant une tâche
  Widget _taskCard(int i) {
    final t = _tasks[i];

    return Dismissible(
      key: ObjectKey(t),

      // Permet de supprimer la tâche en la faisant glisser vers la gauche
      direction: DismissDirection.endToStart,

      onDismissed: (_) => _delete(i),

      // Arrière-plan affiché pendant la suppression
      background: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(right: 24),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),

      child: Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 10),

        // Change la couleur de la carte si la tâche est terminée
        color: t.isCompleted
            ? const Color(0xFFEDE7F6)
            : Colors.white,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),

        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),

          // Case à cocher pour terminer une tâche
          leading: Checkbox(
            value: t.isCompleted,
            shape: const CircleBorder(),

            // Change l'état de la tâche
            onChanged: (v) =>
                setState(() => t.isCompleted = v ?? false),
          ),

          // Titre de la tâche
          title: Text(
            t.title,
            style: TextStyle(
              fontWeight: FontWeight.w600,

              // Barre le titre si la tâche est terminée
              decoration: t.isCompleted
                  ? TextDecoration.lineThrough
                  : null,

              color: t.isCompleted
                  ? Colors.grey
                  : const Color(0xFF2D1B4E),
            ),
          ),

          // Contenu de la tâche
          subtitle: t.content.isEmpty ? null : Text(t.content),

          // Boutons Modifier et Supprimer
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              // Modifier une tâche
              IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  color: Colors.deepPurple.shade400,
                ),
                onPressed: () => _openDialog(task: t),
              ),

              // Supprimer une tâche
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red.shade400,
                ),
                onPressed: () => _delete(i),
              ),
            ],
          ),
        ),
      ),
    );
  }
}