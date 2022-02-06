import 'package:dartz/dartz.dart';
import 'package:number_trivial/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>>? call(Params params);
}
