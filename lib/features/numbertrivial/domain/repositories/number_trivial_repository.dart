import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivial/core/error/failure.dart';
import 'package:number_trivial/features/numbertrivial/domain/entities/number_trivial.dart';

abstract class NumberTrevialRepository extends Equatable {
  Future<Either<Failure, NumberTrivial?>>? getConcretNumerTrvial(int? number);
  Future<Either<Failure, NumberTrivial?>>? getRandumNumerTrvial();
}
