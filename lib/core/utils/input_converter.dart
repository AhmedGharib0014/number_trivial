import 'package:dartz/dartz.dart';
import 'package:number_trivial/core/error/failure.dart';

class InputConverter {
  Either<Failure, int>? convertInputString(String input) {
    try {
      final integer = int.parse(input);
      if (integer < 0) throw FormatException();
      return Right(integer);
    } catch (e) {
      return Left(ConvertFailure());
    }
  }
}

class ConvertFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
