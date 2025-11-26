import 'package:app/controllers/bloc/todo_bloc_bloc.dart';
import 'package:app/widgets/add_todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoSearchBar extends StatelessWidget {
  TodoSearchBar({super.key});

  final ValueNotifier<String> searchText = ValueNotifier("");

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -30,
      left: 20,
      right: 20,
      child: Row(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: searchText,
              builder: (context, value, _) {
                return TextField(
                  onChanged: (text) {
                    searchText.value = text;

                    context.read<TodoBlocBloc>().add(SearchTasks(text));
                  },
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
                );
              },
            ),
          ),

          const SizedBox(width: 10),

          ElevatedButton(
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
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E6F9F),
              foregroundColor: Colors.white,
              minimumSize: const Size(85, 40),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              elevation: 2,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "Add",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 6),
                Icon(Icons.add_circle_outline_rounded, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
