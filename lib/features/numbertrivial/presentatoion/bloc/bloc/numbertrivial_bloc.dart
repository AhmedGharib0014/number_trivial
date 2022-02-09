import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivial/features/numbertrivial/domain/entities/number_trivial.dart';

part 'numbertrivial_event.dart';
part 'numbertrivial_state.dart';

class NumbertrivialBloc extends Bloc<NumbertrivialEvent, NumbertrivialState> {
  NumbertrivialBloc() : super(NumbertrivialInitial()) {
    on<NumbertrivialEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
