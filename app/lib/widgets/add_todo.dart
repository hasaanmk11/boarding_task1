import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController addTaskController = TextEditingController();
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
          const SizedBox(height: 18),
          GestureDetector(
            onTap: () async {
              if (addTaskController.text.isNotEmpty) {
                await FirebaseFirestore.instance.collection("todo").add({
                  "title": addTaskController.text,
                });
                addTaskController.clear(); // Clear after sending
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
