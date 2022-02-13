import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivial/core/error/failure.dart';
import 'package:number_trivial/core/usecases/usecases_interface.dart';
import 'package:number_trivial/core/utils/input_converter.dart';
import 'package:number_trivial/features/numbertrivial/domain/entities/number_trivial.dart';
import 'package:number_trivial/features/numbertrivial/domain/usescases/get-random_trivial.dart';
import 'package:number_trivial/features/numbertrivial/domain/usescases/get_concrete_number_trivial.dart';

part 'numbertrivial_event.dart';
part 'numbertrivial_state.dart';

const INVALID_INPUT_FAILURE_STRING = "invalid input";
const SERVER_EXCEPTION_MESSAGE = "server error";
const CACHE_EXCEPTION_MESSAGE = "cashe exception";

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
    on<NumbertrivialEventGetRandom>(_getRandomNumberTrivail);
  }

  FutureOr<void> _getconcretNumberTrivail(NumbertrivialEventGetConctete event,
      Emitter<NumbertrivialState> emit) async {
    try {
      final convertingResult =
          inputConverter.convertInputString(event.numberString);

      if (convertingResult != null) {
        await convertingResult.fold<FutureOr>(
            (left) =>
                emit(NumbertrivialFailure(error: INVALID_INPUT_FAILURE_STRING)),
            (right) async {
          emit(NumbertrivialLoading());
          final TrivialOrFailure =
              await getConcreteNumberTrivial.call(Params(right));
          TrivialOrFailure?.fold<Future<bool>>((l) {
            emit(NumbertrivialFailure(error: _mapErrorToMessage(l)));
            return Future.value(true);
          }, (right) async {
            emit(NumbertrivialSuccess(numberTrivial: right!));
            return Future.value(true);
          });
        });
      } else {
        emit(NumbertrivialFailure(error: INVALID_INPUT_FAILURE_STRING));
      }
    } catch (e) {
      emit(NumbertrivialFailure(error: e.toString()));
    }
  }

  _mapErrorToMessage(Failure l) {
    switch (l.runtimeType) {
      case ServerFailure:
        return SERVER_EXCEPTION_MESSAGE;
      case CachFailure:
        return CACHE_EXCEPTION_MESSAGE;
      default:
        return "not implelemented";
    }
  }

  FutureOr<void> _getRandomNumberTrivail(NumbertrivialEventGetRandom event,
      Emitter<NumbertrivialState> emit) async {
    try {
      emit(NumbertrivialLoading());
      final TrivialOrFailure = await getRandomTrivialUseCase.call(NoParams());
      TrivialOrFailure?.fold((l) {
        emit(NumbertrivialFailure(error: _mapErrorToMessage(l)));
      }, (right) => emit(NumbertrivialSuccess(numberTrivial: right!)));
    } catch (e) {
      emit(NumbertrivialFailure(error: e.toString()));
    }
  }
}
