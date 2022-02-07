import 'package:number_trivial/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivial/core/usecases/usecases_interface.dart';
import 'package:number_trivial/features/numbertrivial/domain/entities/number_trivial.dart';
import 'package:number_trivial/features/numbertrivial/domain/repositories/number_trivial_repository.dart';

class GetRandomTrivialUseCase extends UseCase<NumberTrivial, NoParams> {
  final NumberTrevialRepository numberTrevialRepository;

  GetRandomTrivialUseCase(this.numberTrevialRepository);

  @override
  Future<Either<Failure, NumberTrivial?>>? call(NoParams params) {
    return numberTrevialRepository.getRandumNumerTrvial();
  }
}
