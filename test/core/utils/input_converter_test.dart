import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivial/core/utils/input_converter.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('inputConverterT4est', () {
    test("sholud return valid int when input string is valid", () {
      // arrange
      String testString = "123";
      // act
      final result = inputConverter.convertInputString(testString);
      //
      expect(result, Right(123));
    });

    test("sholud return Converter Failure  when input string is inValid", () {
      // arrange
      String testString = "sdjkdf123";
      // act
      final result = inputConverter.convertInputString(testString);
      //
      expect(result, Left(ConvertFailure()));
    });

    test("sholud return Converter Failure  when input string is negative value",
        () {
      // arrange
      String testString = "-100";
      // act
      final result = inputConverter.convertInputString(testString);
      //
      expect(result, Left(ConvertFailure()));
    });
  });
}
