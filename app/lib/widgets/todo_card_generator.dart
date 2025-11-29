import 'package:app/model/model.dart';
import 'package:app/widgets/todo_card.dart';
import 'package:flutter/material.dart';

class TodoCradGenerator extends StatelessWidget {
  const TodoCradGenerator({super.key, required this.tasks});

  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TodoCard(task: task),
        );
      },
    );
  }
}
