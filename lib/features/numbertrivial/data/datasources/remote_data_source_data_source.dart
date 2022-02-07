import 'package:number_trivial/features/numbertrivial/domain/entities/number_trivial.dart';

abstract class RemoteDateSource {
  Future<NumberTrivial?>? getConcretNumerTrvial(int? number);
  Future<NumberTrivial?>? getRandumNumerTrvial();
}
