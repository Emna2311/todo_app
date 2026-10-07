// Modèle d'une tâche
class Task {
  String title;
  String content;
  bool isCompleted;

  Task({required this.title, this.content = '', this.isCompleted = false});
}