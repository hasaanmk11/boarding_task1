import 'package:app/model/model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

part 'todo_bloc_event.dart';
part 'todo_bloc_state.dart';

class TodoBlocBloc extends Bloc<TodoBlocEvent, TodoBlocState> {
  TodoBlocBloc() : super(TodoInitial()) {
    on<LoadTasks>((event, emit) async {
      emit(TodoLoading());
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection("todo")
            .orderBy("due_date_time")
            .get();
        final tasks = snapshot.docs.map((doc) {
          final data = doc.data();
          return TaskModel(
            id: doc.id,
            title: data['title'] ?? '',
            date: data['due_date_time'] ?? '',
            isCompleted: data['isCompleted'] ?? false,
          );
        }).toList();
        emit(TodoLoaded(tasks: tasks));
      } catch (e) {
        emit(TodoError(message: e.toString()));
      }
    });

    on<AddTask>((event, emit) async {
      await FirebaseFirestore.instance.collection('todo').add({
        'title': event.title,
        'due_date_time': event.dueDate,
        'isCompleted': false,
      });
      add(LoadTasks());
    });

    // Update task completion status
    on<UpdateTask>((event, emit) async {
      try {
        await FirebaseFirestore.instance
            .collection('todo')
            .doc(event.id)
            .update({'isCompleted': event.isCompleted});
        add(LoadTasks());
      } catch (e) {
        emit(TodoError(message: e.toString()));
      }
    });

    // Delete task
    on<DeleteTask>((event, emit) async {
      try {
        await FirebaseFirestore.instance
            .collection('todo')
            .doc(event.id)
            .delete();
        add(LoadTasks()); // Reload tasks after deletion
      } catch (e) {
        emit(TodoError(message: e.toString()));
      }
    });
  }
}
