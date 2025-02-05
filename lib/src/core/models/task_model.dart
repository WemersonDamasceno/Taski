class TaskModel {
  final int id;
  final String title;
  final String description;
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  toggleValue({required bool isCompleted}) {
    return TaskModel(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
    );
  }
}
