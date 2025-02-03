class TaskModel {
  final String title;
  final String description;
  bool isCompleted;

  TaskModel({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}
