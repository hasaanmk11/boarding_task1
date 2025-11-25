part of 'todo_bloc_bloc.dart';

@immutable
abstract class TodoBlocEvent {}

class LoadTasks extends TodoBlocEvent {}

class AddTask extends TodoBlocEvent {
  final String title;
  final String dueDate;
  AddTask({required this.title, required this.dueDate});
}

class UpdateTaskStatus extends TodoBlocEvent {
  final String id;
  final bool isCompleted;
  UpdateTaskStatus({required this.id, required this.isCompleted});
}


class EditTask extends TodoBlocEvent {
  final String id;
  final String newTitle;
  final String newDueDate;

  EditTask({
    required this.id,
    required this.newTitle,
    required this.newDueDate,
  });
}

class DeleteTask extends TodoBlocEvent {
  final String id;
  DeleteTask({required this.id});
}
