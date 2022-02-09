part of 'numbertrivial_bloc.dart';

abstract class NumbertrivialState extends Equatable {
  const NumbertrivialState();

  @override
  List<Object> get props => [];
}

class NumbertrivialInitial extends NumbertrivialState {}

class NumbertrivialLoading extends NumbertrivialState {}

class NumbertrivialSuccess extends NumbertrivialState {
  final NumberTrivial numberTrivial;

  NumbertrivialSuccess({required this.numberTrivial});

  @override
  List<Object> get props => [numberTrivial];
}

class NumbertrivialFailure extends NumbertrivialState {
  final String error;

  NumbertrivialFailure({required this.error});

  @override
  List<Object> get props => [error];
}
