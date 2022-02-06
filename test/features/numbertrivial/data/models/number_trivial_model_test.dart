import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivial/features/numbertrivial/data/models/number_trivial_model.dart';
import 'package:number_trivial/features/numbertrivial/domain/entities/number_trivial.dart';

import '../../../../fixtures/fixure_reader.dart';

void main() {
  final TNumberTrivialModel = NumberTrivialModel(number: 1, text: "text test");

  test("should be a subclass of NumberTrivial entity", () {
    expect(TNumberTrivialModel, isA<NumberTrivial>());
  });

  group('from json', () {
    test("should produce  a number trivial model from int data", () async {
      final result =
          NumberTrivialModel.fromJson(jsonDecode(readFixture("trivial.json")));
      expect(result, TNumberTrivialModel);
    });

    test("should produce  a number trivial model from double data", () async {
      final result = NumberTrivialModel.fromJson(
          jsonDecode(readFixture("trivial_double.json")));
      expect(result, TNumberTrivialModel);
    });
  });

  group('to json', () {
    test("should produce  map", () async {
      final result = TNumberTrivialModel.toJson();
      final mapResult = {"text": "text test", "number": 1};
      expect(result, mapResult);
    });
  });
}
