import 'package:app/widgets/add_todo.dart';
import 'package:flutter/material.dart';

class TodoSearchBar extends StatelessWidget {
  const TodoSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -30,
      left: 20,
      right: 20,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "🚀 Search...",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: const Color.fromARGB(255, 46, 46, 46),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton.icon(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: const Color(0xFF2E2E2E),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                ),
                builder: (context) => const AddTodo(),
              );
            },
            icon: const Icon(Icons.add, size: 16),
            label: const Text("Add"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E6F9F),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
