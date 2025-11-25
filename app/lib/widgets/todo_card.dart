import 'package:app/controllers/bloc/todo_bloc_bloc.dart';
import 'package:app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TodoCard extends StatelessWidget {
  final TaskModel task;

  const TodoCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    DateTime? dueDate;
    try {
      dueDate = DateTime.parse(task.date);
    } catch (e) {
      dueDate = null;
    }

    String formattedDate = dueDate != null
        ? DateFormat('dd MMM yyyy, hh:mm a').format(dueDate)
        : 'No date';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: const Color.fromARGB(255, 46, 46, 46),
      ),
      width: double.infinity,
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  value: task.isCompleted,
                  onChanged: (value) {
                    context.read<TodoBlocBloc>().add(
                      UpdateTask(id: task.id, isCompleted: value ?? false),
                    );
                  },
                  activeColor: Colors.lightBlue,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16,
                          color: task.isCompleted
                              ? const Color.fromARGB(255, 110, 110, 110)
                              : Colors.white,
                          fontFamily: "Poppins",
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationColor: Colors.white,
                          decorationThickness: 2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Due: $formattedDate",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color.fromARGB(180, 255, 255, 255),
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: Color.fromARGB(110, 255, 255, 255),
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () {
                  context.read<TodoBlocBloc>().add(DeleteTask(id: task.id));
                },
                child: const Icon(
                  Icons.delete_outline,
                  size: 22,
                  color: Color.fromARGB(110, 255, 255, 255),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
