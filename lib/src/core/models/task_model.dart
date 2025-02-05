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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
    );
  }

  toggleValue({required bool isCompleted}) {
    return TaskModel(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
    );
  }
}
