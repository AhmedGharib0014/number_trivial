part of 'numbertrivial_bloc.dart';

abstract class NumbertrivialEvent extends Equatable {
  const NumbertrivialEvent();

  @override
  List<Object> get props => [];
}

class NumbertrivialEventGetConctete extends NumbertrivialEvent {
  final String numberString;

  NumbertrivialEventGetConctete({required this.numberString});

  @override
  List<Object> get props => [numberString];
}

class NumbertrivialEventGetRandom extends NumbertrivialEvent {}
