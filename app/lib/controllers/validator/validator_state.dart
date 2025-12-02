part of 'validator_cubit.dart';

@immutable
abstract class ValidatorState {}

class ValidatorInitial extends ValidatorState {}

class ValidatorError extends ValidatorState {
  final String? taskError;
  final String? dateError;

  ValidatorError({this.taskError, this.dateError});
}

class ValidatorSuccess extends ValidatorState {}
