import 'package:app/controllers/validator/validator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController addTaskController = TextEditingController();
  final ValueNotifier<DateTime?> selectedDateTime = ValueNotifier(null);
  final ValueNotifier<bool> canSubmit = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    addTaskController.addListener(updateSubmitState);
    selectedDateTime.addListener(updateSubmitState);
  }

  @override
  void dispose() {
    addTaskController.dispose();
    selectedDateTime.dispose();
    canSubmit.dispose();
    super.dispose();
  }

  void updateSubmitState() {
    canSubmit.value =
        addTaskController.text.isNotEmpty && selectedDateTime.value != null;
  }

  @override
  Widget build(BuildContext context) {
    final validatorCubit = context.read<ValidatorCubit>();

    return BlocListener<ValidatorCubit, ValidatorState>(
      listener: (context, state) {
        if (state is ValidatorSuccess) {
          addTaskController.clear();
          selectedDateTime.value = null;
          canSubmit.value = false;
          Navigator.of(context).pop();
        }
      },
      child: Padding(
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
                fillColor: Colors.transparent,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 12),

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
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                );
              },
            ),

            BlocBuilder<ValidatorCubit, ValidatorState>(
              builder: (_, state) {
                String? taskError = state is ValidatorError
                    ? state.taskError
                    : null;

                return TextField(
                  controller: addTaskController,
                  onChanged: (_) {
                    validatorCubit.resetErrors();
                    updateSubmitState();
                  },
                  decoration: InputDecoration(
                    hintText: "Enter task...",
                    hintStyle: const TextStyle(color: Colors.white54),
                    errorText: taskError,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.white54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Colors.lightBlue,
                        width: 2,
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                );
              },
            ),

            const SizedBox(height: 14),

            BlocBuilder<ValidatorCubit, ValidatorState>(
              builder: (_, state) {
                String? dateError = state is ValidatorError
                    ? state.dateError
                    : null;

                return ValueListenableBuilder<DateTime?>(
                  valueListenable: selectedDateTime,
                  builder: (_, dateTime, __) {
                    return GestureDetector(
                      onTap: () async {
                        DateTime now = DateTime.now();
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: now,
                          firstDate: now,
                          lastDate: DateTime(now.year + 5),
                        );

                        if (pickedDate != null) {
                          final pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          selectedDateTime.value = pickedTime != null
                              ? DateTime(
                                  pickedDate.year,
                                  pickedDate.month,
                                  pickedDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                )
                              : pickedDate;

                          validatorCubit.resetErrors();
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: dateError != null
                                    ? Colors.red
                                    : Colors.white24,
                              ),
                            ),
                            child: Text(
                              dateTime != null
                                  ? "Due: ${DateFormat('dd MMM yyyy • hh:mm a').format(dateTime)}"
                                  : "Select Due Date & Time",
                              style: TextStyle(
                                color: dateError != null
                                    ? Colors.red
                                    : Colors.white,
                              ),
                            ),
                          ),
                          if (dateError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                dateError,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerRight,
              child: ValueListenableBuilder<bool>(
                valueListenable: canSubmit,
                builder: (_, isEnabled, __) {
                  return GestureDetector(
                    onTap: () {
                      validatorCubit.validateAndSubmit(
                        context: context,
                        controller: addTaskController,
                        selectedDate: selectedDateTime.value,
                      );
                    },
                    child: SizedBox(child: Image.asset("assets/send.png")),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
