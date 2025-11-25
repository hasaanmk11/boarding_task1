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
                      UpdateTaskStatus(
                        id: task.id,
                        isCompleted: value ?? false,
                      ),
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
                onTap: () {
                  showEditTaskSheet(context, task);
                },
                child: const Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: Color.fromARGB(110, 255, 255, 255),
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () {
                  showDeleteDialog(context, task.id);
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

void showDeleteDialog(BuildContext context, String taskId) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 46, 46, 46),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          "Delete Task?",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Poppins",
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: const Text(
          "Are you sure you want to delete this task?",
          style: TextStyle(
            color: Colors.white70,
            fontFamily: "Poppins",
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.blue, fontFamily: "Poppins"),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<TodoBlocBloc>().add(DeleteTask(id: taskId));
              Navigator.pop(context);
            },
            child: const Text(
              "Delete",
              style: TextStyle(
                color: Colors.red,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    },
  );
}

void showEditTaskSheet(BuildContext context, TaskModel task) {
  final TextEditingController titleController = TextEditingController(
    text: task.title,
  );

  final ValueNotifier<DateTime?> selectedDateNotifier =
      ValueNotifier<DateTime?>(DateTime.tryParse(task.date));

  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A1A1A),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
    builder: (context) {
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
              "Edit Task",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Title text field
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Enter task...",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white12,
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 12),

            ValueListenableBuilder<DateTime?>(
              valueListenable: selectedDateNotifier,
              builder: (context, selectedDate, _) {
                return GestureDetector(
                  onTap: () async {
                    DateTime now = DateTime.now();
                    DateTime? d = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? now,
                      firstDate: now,
                      lastDate: DateTime(now.year + 5),
                    );
                    if (d != null) {
                      TimeOfDay? t = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (t != null) {
                        selectedDateNotifier.value = DateTime(
                          d.year,
                          d.month,
                          d.day,
                          t.hour,
                          t.minute,
                        );
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
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedDate == null
                              ? "Pick due date"
                              : "${selectedDate.day}-${selectedDate.month}-${selectedDate.year} "
                                    "${selectedDate.hour}:${selectedDate.minute.toString().padLeft(2, '0')}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Icon(Icons.calendar_month, color: Colors.white),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Submit button
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  final updatedTitle = titleController.text.trim();
                  final updatedDate = selectedDateNotifier.value;

                  if (updatedTitle.isEmpty || updatedDate == null) return;

                  context.read<TodoBlocBloc>().add(
                    EditTask(
                      id: task.id,
                      newTitle: updatedTitle,
                      newDueDate: updatedDate.toString(),
                    ),
                  );

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6750A4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  "Save Changes",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
