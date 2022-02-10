import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivial/core/utils/input_converter.dart';
import 'package:number_trivial/features/numbertrivial/domain/entities/number_trivial.dart';
import 'package:number_trivial/features/numbertrivial/domain/usescases/get-random_trivial.dart';
import 'package:number_trivial/features/numbertrivial/domain/usescases/get_concrete_number_trivial.dart';

part 'numbertrivial_event.dart';
part 'numbertrivial_state.dart';

class NumbertrivialBloc extends Bloc<NumbertrivialEvent, NumbertrivialState> {
  final GetConcreteNumberTrivialUseCase getConcreteNumberTrivial;
  final GetRandomTrivialUseCase getRandomTrivialUseCase;
  final InputConverter inputConverter;

  NumbertrivialBloc(
      {required this.getConcreteNumberTrivial,
      required this.inputConverter,
      required this.getRandomTrivialUseCase})
      : super(NumbertrivialInitial()) {
    on<NumbertrivialEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
