import 'package:number_trivial/features/numbertrivial/domain/entities/number_trivial.dart';

abstract class LocalDateSource {
  Future<NumberTrivial>? getLastNumerTrvial();
  Future<void>? saveNumberTrivial(NumberTrivial? numberTrivial);
}
