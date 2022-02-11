import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivial/core/utils/input_converter.dart';
import 'package:number_trivial/features/numbertrivial/domain/entities/number_trivial.dart';
import 'package:number_trivial/features/numbertrivial/domain/usescases/get-random_trivial.dart';
import 'package:number_trivial/features/numbertrivial/domain/usescases/get_concrete_number_trivial.dart';

part 'numbertrivial_event.dart';
part 'numbertrivial_state.dart';

const INVALID_INPUT_FAILURE_STRING = "invalid input";

class NumbertrivialBloc extends Bloc<NumbertrivialEvent, NumbertrivialState> {
  final GetConcreteNumberTrivialUseCase getConcreteNumberTrivial;
  final GetRandomTrivialUseCase getRandomTrivialUseCase;
  final InputConverter inputConverter;

  NumbertrivialBloc(
      {required this.getConcreteNumberTrivial,
      required this.inputConverter,
      required this.getRandomTrivialUseCase})
      : super(NumbertrivialInitial()) {
    on<NumbertrivialEventGetConctete>(_getconcretNumberTrivail);
  }

  FutureOr<void> _getconcretNumberTrivail(
      NumbertrivialEventGetConctete event, Emitter<NumbertrivialState> emit) {
    try {
      final convertingResult =
          inputConverter.convertInputString(event.numberString);

      if (convertingResult != null) {
        convertingResult.fold(
            (l) =>
                emit(NumbertrivialFailure(error: INVALID_INPUT_FAILURE_STRING)),
            (r) {});
      } else {
        emit(NumbertrivialFailure(error: INVALID_INPUT_FAILURE_STRING));
      }
    } catch (e) {
      emit(NumbertrivialFailure(error: e.toString()));
    }
  }
}
