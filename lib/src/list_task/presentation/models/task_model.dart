class TaskModel {
  final String title;
  final String description;
  bool isCompleted;

  TaskModel({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  toggleValue({required bool isCompleted}) {
    return TaskModel(
      title: title,
      description: description,
      isCompleted: isCompleted,
    );
  }
}
