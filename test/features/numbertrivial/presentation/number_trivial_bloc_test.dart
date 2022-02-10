import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivial/core/utils/input_converter.dart';
import 'package:number_trivial/features/numbertrivial/domain/entities/number_trivial.dart';
import 'package:number_trivial/features/numbertrivial/domain/usescases/get-random_trivial.dart';
import 'package:number_trivial/features/numbertrivial/domain/usescases/get_concrete_number_trivial.dart';
import 'package:number_trivial/features/numbertrivial/presentatoion/bloc/bloc/numbertrivial_bloc.dart';

class MocGetConcreteNumberUseCase extends Mock
    implements GetConcreteNumberTrivialUseCase {}

class MocGetRandomNumberUseCase extends Mock
    implements GetRandomTrivialUseCase {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late MocGetConcreteNumberUseCase concreteNumberUseCase;
  late MocGetRandomNumberUseCase randomNumberUseCase;
  late MockInputConverter inputConverter;
  late NumbertrivialBloc numbertrivialBloc;

  setUp(() {
    concreteNumberUseCase = MocGetConcreteNumberUseCase();
    randomNumberUseCase = MocGetRandomNumberUseCase();
    inputConverter = MockInputConverter();
    numbertrivialBloc = NumbertrivialBloc(
      getRandomTrivialUseCase: randomNumberUseCase,
      getConcreteNumberTrivial: concreteNumberUseCase,
      inputConverter: inputConverter,
    );
  });

  group("GetNumberTrivialBloc", () {
    test("should emit init state in the beginning", () {
      expect(numbertrivialBloc.state, equals(NumbertrivialInitial()));
    });

    group("getTrivialForConcretNumber", () {
      final TnumberString = "1";
      final TnumberInt = 1;
      final TnumberTrivial = NumberTrivial(number: 1, text: "test text");

      test("should call input converter to convert string", () async {
        // arrange
        when(inputConverter.convertInputString(TnumberString))
            .thenReturn(Right(TnumberInt));

        // act
        numbertrivialBloc
            .add(NumbertrivialEventGetConctete(numberString: TnumberString));

        await untilCalled(inputConverter.convertInputString(TnumberString));
        // verify
        verify(inputConverter.convertInputString(TnumberString));
      });
    });
  });
}
