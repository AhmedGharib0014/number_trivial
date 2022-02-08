import 'package:number_trivial/core/error/exceptions.dart';
import 'package:number_trivial/core/network/networkInfo.dart';
import 'package:number_trivial/features/numbertrivial/data/datasources/locae_number_trivial_data_source.dart';
import 'package:number_trivial/features/numbertrivial/data/datasources/remote_data_source_data_source.dart';
import 'package:number_trivial/features/numbertrivial/domain/entities/number_trivial.dart';
import 'package:number_trivial/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivial/features/numbertrivial/domain/repositories/number_trivial_repository.dart';

class NumberTrivialRepositpryImplemantation extends NumberTrevialRepository {
  final RemoteDateSource remoteDateSource;
  final LocalDateSource localDateSource;
  final NetWorkInfo netWorkInfo;

  NumberTrivialRepositpryImplemantation(
      {required this.remoteDateSource,
      required this.localDateSource,
      required this.netWorkInfo});

  @override
  Future<Either<Failure, NumberTrivial?>>? getConcretNumerTrvial(int? number) {
    return _gettrivial(() => remoteDateSource.getConcretNumerTrvial(number));
  }

  @override
  Future<Either<Failure, NumberTrivial?>>? getRandumNumerTrvial() {
    return _gettrivial(() => remoteDateSource.getRandumNumerTrvial());
  }

  Future<Either<Failure, NumberTrivial?>>? _gettrivial(
      Future<NumberTrivial?>? Function() getTrivialFunction) async {
    if (await netWorkInfo.isConnected == true) {
      try {
        NumberTrivial? numberTrivial = await getTrivialFunction();
        localDateSource.saveNumberTrivial(numberTrivial);
        return Right(numberTrivial);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final numberTrivial = await localDateSource.getLastNumerTrvial();
        return Right(numberTrivial);
      } on CachException {
        return Left(CachFailure());
      }
    }
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
