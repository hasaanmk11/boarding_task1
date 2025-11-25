part of 'todo_bloc_bloc.dart';

@immutable
abstract class TodoBlocState {}

class TodoInitial extends TodoBlocState {}

class TodoLoading extends TodoBlocState {}

class TodoLoaded extends TodoBlocState {
  final List<TaskModel> tasks;
  final List<TaskModel> allTasks;

  TodoLoaded({required this.tasks, required this.allTasks});
}



class TodoError extends TodoBlocState {
  final String message;
  TodoError({required this.message});
}
