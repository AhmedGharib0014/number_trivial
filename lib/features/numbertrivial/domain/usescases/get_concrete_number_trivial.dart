import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:number_trivial/core/error/failure.dart';
import 'package:number_trivial/core/usecases/usecases_interface.dart';
import 'package:number_trivial/features/numbertrivial/domain/entities/number_trivial.dart';
import 'package:number_trivial/features/numbertrivial/domain/repositories/number_trivial_repository.dart';

class GetConcreteNumberTrivial extends UseCase<NumberTrivial, Params> {
  final NumberTrevialRepository repository;
  GetConcreteNumberTrivial(this.repository);

  @override
  Future<Either<Failure, NumberTrivial>>? call(Params params) {
    return repository.getConcretNumerTrvial(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params(this.number);

  @override
  List<Object?> get props => [number];
}
