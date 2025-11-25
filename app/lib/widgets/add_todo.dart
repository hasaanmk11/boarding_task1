import 'package:app/controllers/bloc/todo_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController addTaskController = TextEditingController();
  final ValueNotifier<DateTime?> selectedDateTime = ValueNotifier<DateTime?>(
    null,
  );

  @override
  void dispose() {
    addTaskController.dispose();
    selectedDateTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            "Add Task",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // TextField persists across rebuilds
          TextField(
            controller: addTaskController,
            decoration: InputDecoration(
              hintText: "Enter task...",
              hintStyle: const TextStyle(color: Colors.white),
              filled: true,
              isDense: true,
              fillColor: Colors.white12,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.2),
                  width: 2,
                ),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 12),

          // Only date/time selector rebuilds
          ValueListenableBuilder<DateTime?>(
            valueListenable: selectedDateTime,
            builder: (context, dateTime, _) {
              return GestureDetector(
                onTap: () async {
                  DateTime now = DateTime.now();
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: now,
                    lastDate: DateTime(now.year + 5),
                  );

                  if (pickedDate != null) {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      selectedDateTime.value = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                    } else {
                      selectedDateTime.value = pickedDate;
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Text(
                    dateTime != null
                        ? "Due: ${dateTime.day.toString().padLeft(2, '0')}/"
                              "${dateTime.month.toString().padLeft(2, '0')}/"
                              "${dateTime.year} "
                              "${dateTime.hour.toString().padLeft(2, '0')}:"
                              "${dateTime.minute.toString().padLeft(2, '0')}"
                        : "Select Due Date & Time",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 18),

          GestureDetector(
            onTap: () async {
              if (addTaskController.text.isNotEmpty) {
                BlocProvider.of<TodoBlocBloc>(context).add(
                  AddTask(
                    title: addTaskController.text,
                    dueDate: selectedDateTime.value!.toIso8601String(),
                  ),
                );

                addTaskController.clear();
                selectedDateTime.value = null;
              }
            },
            child: Align(
              alignment: Alignment.topRight,
              child: const Icon(Icons.send, color: Colors.lightBlue, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
