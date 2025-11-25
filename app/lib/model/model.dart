class TaskModel {
  final String id;
  final String title;
  final bool isCompleted;
  final String date;

  TaskModel({
    required this.id,
    required this.date,
    required this.title,
    this.isCompleted = false,
  });

  TaskModel copyWith({String? title, bool? isCompleted}) {
    return TaskModel(
      id: id,
      date: date,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
