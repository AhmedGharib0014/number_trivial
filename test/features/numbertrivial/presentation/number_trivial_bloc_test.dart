import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivial/core/error/failure.dart';
import 'package:number_trivial/core/usecases/usecases_interface.dart';
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

      blocTest('should emit failure state when converting failed',
          build: () => numbertrivialBloc,
          act: (NumbertrivialBloc bloc) {
            when(inputConverter.convertInputString(TnumberString))
                .thenReturn(Left(ConvertFailure()));

            bloc.add(
              NumbertrivialEventGetConctete(numberString: TnumberString),
            );
          },
          expect: () =>
              [NumbertrivialFailure(error: INVALID_INPUT_FAILURE_STRING)]);

      blocTest(
        'should call concrete number trivial use case when converting successeeded',
        build: () => numbertrivialBloc,
        act: (NumbertrivialBloc bloc) {
          when(inputConverter.convertInputString(TnumberString))
              .thenReturn(Right(TnumberInt));
          when(concreteNumberUseCase.call(Params(TnumberInt)))
              .thenAnswer((realInvocation) async => Right(TnumberTrivial));

          bloc.add(
            NumbertrivialEventGetConctete(numberString: TnumberString),
          );
        },
        verify: (bloc) {
          verify(concreteNumberUseCase.call(Params(TnumberInt)));
        },
      );

      blocTest(
        'should emit success state when getting trivial succeded',
        build: () => numbertrivialBloc,
        act: (NumbertrivialBloc bloc) {
          when(inputConverter.convertInputString(TnumberString))
              .thenReturn(Right(TnumberInt));
          when(concreteNumberUseCase.call(Params(TnumberInt)))
              .thenAnswer((realInvocation) async => Right(TnumberTrivial));

          bloc.add(
            NumbertrivialEventGetConctete(numberString: TnumberString),
          );
        },
        expect: () => [
          NumbertrivialLoading(),
          NumbertrivialSuccess(numberTrivial: TnumberTrivial)
        ],
      );

      blocTest(
        'should emit Failure state when there is a failure with getting remote data',
        build: () => numbertrivialBloc,
        act: (NumbertrivialBloc bloc) {
          when(inputConverter.convertInputString(TnumberString))
              .thenReturn(Right(TnumberInt));
          when(concreteNumberUseCase.call(Params(TnumberInt)))
              .thenAnswer((realInvocation) async => Left(ServerFailure()));

          bloc.add(
            NumbertrivialEventGetConctete(numberString: TnumberString),
          );
        },
        expect: () => [
          NumbertrivialLoading(),
          NumbertrivialFailure(error: SERVER_EXCEPTION_MESSAGE)
        ],
      );

      blocTest(
        'should emit Failure state when there is a failure with getting cached data',
        build: () => numbertrivialBloc,
        act: (NumbertrivialBloc bloc) {
          when(inputConverter.convertInputString(TnumberString))
              .thenReturn(Right(TnumberInt));
          when(concreteNumberUseCase.call(Params(TnumberInt)))
              .thenAnswer((realInvocation) async => Left(CachFailure()));

          bloc.add(
            NumbertrivialEventGetConctete(numberString: TnumberString),
          );
        },
        expect: () => [
          NumbertrivialLoading(),
          NumbertrivialFailure(error: CACHE_EXCEPTION_MESSAGE)
        ],
      );
    });

    group("getTrivialForRandomNumber", () {
      final TnumberTrivial = NumberTrivial(number: 1, text: "test text");

      blocTest(
        'should call random number trivial use case',
        build: () => numbertrivialBloc,
        act: (NumbertrivialBloc bloc) {
          when(randomNumberUseCase.call(NoParams()))
              .thenAnswer((realInvocation) async => Right(TnumberTrivial));

          bloc.add(
            NumbertrivialEventGetRandom(),
          );
        },
        verify: (bloc) {
          verify(randomNumberUseCase.call(NoParams()));
        },
      );

      blocTest(
        'should emit success state when getting trivial succeded',
        build: () => numbertrivialBloc,
        act: (NumbertrivialBloc bloc) {
          when(randomNumberUseCase.call(NoParams()))
              .thenAnswer((realInvocation) async => Right(TnumberTrivial));

          bloc.add(
            NumbertrivialEventGetRandom(),
          );
        },
        expect: () => [
          NumbertrivialLoading(),
          NumbertrivialSuccess(numberTrivial: TnumberTrivial)
        ],
      );

      blocTest(
        'should emit Failure state when there is a failure with getting remote data',
        build: () => numbertrivialBloc,
        act: (NumbertrivialBloc bloc) {
          when(randomNumberUseCase.call(NoParams()))
              .thenAnswer((realInvocation) async => Left(ServerFailure()));

          bloc.add(
            NumbertrivialEventGetRandom(),
          );
        },
        expect: () => [
          NumbertrivialLoading(),
          NumbertrivialFailure(error: SERVER_EXCEPTION_MESSAGE)
        ],
      );

      blocTest(
        'should emit Failure state when there is a failure with getting cached data',
        build: () => numbertrivialBloc,
        act: (NumbertrivialBloc bloc) {
          when(randomNumberUseCase.call(NoParams()))
              .thenAnswer((realInvocation) async => Left(CachFailure()));

          bloc.add(
            NumbertrivialEventGetRandom(),
          );
        },
        expect: () => [
          NumbertrivialLoading(),
          NumbertrivialFailure(error: CACHE_EXCEPTION_MESSAGE)
        ],
      );
    });
  });
}
