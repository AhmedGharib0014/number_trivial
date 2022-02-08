import 'package:number_trivial/features/numbertrivial/data/models/number_trivial_model.dart';
import 'package:number_trivial/features/numbertrivial/domain/entities/number_trivial.dart';

abstract class RemoteDateSource {
  Future<NumberTrivialModel?>? getConcretNumerTrvial(int? number);
  Future<NumberTrivialModel?>? getRandumNumerTrvial();
}
