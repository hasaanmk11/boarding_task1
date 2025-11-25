class TaskModel {
  final String id;
  final String title;
  final bool isCompleted;

  TaskModel({required this.id, required this.title, this.isCompleted = false});

  TaskModel copyWith({String? title, bool? isCompleted}) {
    return TaskModel(
      id: id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
