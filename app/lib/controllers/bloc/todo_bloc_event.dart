part of 'todo_bloc_bloc.dart';

@immutable
abstract class TodoBlocEvent {}

class LoadTasks extends TodoBlocEvent {}

class AddTask extends TodoBlocEvent {
  final String title;
  final String dueDate;
  AddTask({required this.title, required this.dueDate});
}

class UpdateTask extends TodoBlocEvent {
  final String id;
  final bool isCompleted;
  UpdateTask({required this.id, required this.isCompleted});
}

class DeleteTask extends TodoBlocEvent {
  final String id;
  DeleteTask({required this.id});
}
