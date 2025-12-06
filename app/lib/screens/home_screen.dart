import 'package:app/const/colors.dart';
import 'package:app/controllers/bloc/todo_bloc_bloc.dart';

import 'package:app/widgets/divider_widgets.dart';
import 'package:app/widgets/search_bar.dart';
import 'package:app/widgets/status_card.dart';

import 'package:app/widgets/todo_card_generator.dart';
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
<<<<<<< HEAD
=======
      resizeToAvoidBottomInset: true,
>>>>>>> fix-ui
      backgroundColor: AppColors.appBgColor,
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
              TodoSearchBar(),
            ],
          ),
          const SizedBox(height: 60),

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
                  return const SizedBox();
                }

                final tasks = state.tasks;

                if (tasks.isEmpty) {
<<<<<<< HEAD
                  return Column(
                    children: [
                      DividerWidget(),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.assignment_outlined,
                              size: 38,
                              color: Colors.white12,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "You don’t have any tasks yet",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white30,
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
                                color: Colors.white30,
                                fontSize: 11,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
=======
                  return SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        DividerWidget(),
                        const SizedBox(height: 50),
                        SizedBox(
                          width: 53,
                          height: 53,
                          child: Opacity(
                            opacity: 0.4,
                            child: Image.asset("assets/empty_icon.png"),
                          ),
                        ),

                        const SizedBox(height: 8),
                        const Text(
                          "You don’t have any tasks yet.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white38,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Poppins",
                          ),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          "Start adding tasks and manage your\ntime effectively",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white30,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,

                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
>>>>>>> fix-ui
                  );
                }

                return TodoCradGenerator(tasks: tasks);
              },
            ),
          ),
        ],
      ),
    );
  }
}
