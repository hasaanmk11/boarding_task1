import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:app/controllers/bloc/todo_bloc_bloc.dart';

part 'validator_state.dart';

class ValidatorCubit extends Cubit<ValidatorState> {
  ValidatorCubit() : super(ValidatorInitial());

  void validateAndSubmit({
    required BuildContext context,
    required TextEditingController controller,
    required DateTime? selectedDate,
  }) {
    String? taskError;
    String? dateError;

    if (controller.text.isEmpty) taskError = "Task name is required";
    if (selectedDate == null) dateError = "Please select a due date";

    if (taskError != null || dateError != null) {
      emit(ValidatorError(taskError: taskError, dateError: dateError));
      return;
    }

    BlocProvider.of<TodoBlocBloc>(context).add(
      AddTask(title: controller.text, dueDate: selectedDate!.toIso8601String()),
    );

    emit(ValidatorSuccess());
  }

  void resetErrors() {
    emit(ValidatorInitial());
  }
}
