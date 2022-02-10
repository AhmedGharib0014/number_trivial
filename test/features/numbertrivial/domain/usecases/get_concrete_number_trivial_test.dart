import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivial/features/numbertrivial/domain/entities/number_trivial.dart';
import 'package:number_trivial/features/numbertrivial/domain/repositories/number_trivial_repository.dart';
import 'package:number_trivial/features/numbertrivial/domain/usescases/get_concrete_number_trivial.dart';

class MocNumberTrivialRepository extends Mock
    implements NumberTrevialRepository {}

void main() {
  late GetConcreteNumberTrivialUseCase usecases;
  late MocNumberTrivialRepository mocNumberTrivialRepository;

  setUp(() {
    mocNumberTrivialRepository = MocNumberTrivialRepository();
    usecases = GetConcreteNumberTrivialUseCase(mocNumberTrivialRepository);
  });
  final TNumber = 1;
  final TNumberTrivial = NumberTrivial(text: "test", number: 1);

  test("should get trivial for the number from repo", () async {
    // arrange
    when(mocNumberTrivialRepository.getConcretNumerTrvial(any))
        .thenAnswer((_) async => Right(TNumberTrivial));
    //act
    final result = await usecases(Params(TNumber));
    //assert
    expect(result, Right(TNumberTrivial));
    verify(mocNumberTrivialRepository.getConcretNumerTrvial(TNumber));
    verifyNoMoreInteractions(mocNumberTrivialRepository);
  });
}
