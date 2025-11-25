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
      body: BlocBuilder<TodoBlocBloc, TodoBlocState>(
        builder: (context, state) {
          if (state is TodoLoaded) {
            return Column(
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
                StatusCard(
                  pending: state.tasks.where((t) => !t.isCompleted).length,
                  completed: state.tasks.where((t) => t.isCompleted).length,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: state.tasks.isEmpty
                      ? Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.chat_rounded,
                                color: Colors.white.withValues(alpha: 0.3),
                              ),
                              Text(
                                "You don’t have any tasks yet",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,

                                  fontFamily: "Poppins",
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "Start adding tasks and manage your\n time effectively",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12, // slightly smaller
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: state.tasks.length,
                          itemBuilder: (context, index) {
                            final task = state.tasks[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: TodoCard(task: task),
                            );
                          },
                        ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
