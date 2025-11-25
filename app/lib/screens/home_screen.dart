import 'package:app/controllers/bloc/todo_bloc_bloc.dart';
import 'package:app/widgets/search_bar.dart';
import 'package:app/widgets/status_card.dart';
import 'package:app/widgets/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TodoBlocBloc>().add(LoadTasks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 230,
                color: Colors.black,
              ),
              const TodoSearchBar(),
            ],
          ),
          const SizedBox(height: 60),

          // status card always visible
          BlocBuilder<TodoBlocBloc, TodoBlocState>(
            builder: (context, state) {
              int pending = 0;
              int completed = 0;

              if (state is TodoLoaded) {
                pending = state.tasks.where((t) => !t.isCompleted).length;
                completed = state.tasks.where((t) => t.isCompleted).length;
              }

              return StatusCard(pending: pending, completed: completed);
            },
          ),

          const SizedBox(height: 10),

          // Only the task list area shows loading / empty / list
          Expanded(
            child: BlocBuilder<TodoBlocBloc, TodoBlocState>(
              builder: (context, state) {
                if (state is TodoLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                      strokeWidth: 2.5,
                    ),
                  );
                }

                if (state is! TodoLoaded) {
                  return const SizedBox(); // UI remains clean
                }

                final tasks = state.tasks;

                if (tasks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_rounded,
                          size: 38,
                          color: Colors.white24,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "You don’t have any tasks yet",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                            fontFamily: "Poppins",
                          ),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          "Start adding tasks and manage your\ntime effectively",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  );
                }

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
              },
            ),
          ),
        ],
      ),
    );
  }
}
