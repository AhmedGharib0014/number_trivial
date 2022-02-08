import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivial/core/error/exceptions.dart';
import 'package:number_trivial/features/numbertrivial/data/datasources/remote_data_source_data_source.dart';
import 'package:number_trivial/features/numbertrivial/data/models/number_trivial_model.dart';

import '../../../../fixtures/fixure_reader.dart';
import 'remote_data_source-test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockHttpClient;
  late RemoteDateSourceImple remoteDateSourceImpl;
  setUp(() {
    mockHttpClient = MockClient();
    remoteDateSourceImpl = RemoteDateSourceImple(mockHttpClient);
  });

  group('getConcretNumerTrvial', () {
    final tNumber = 1;
    final TnumberTrivialModel =
        NumberTrivialModel(text: 'text test', number: 1);

    test('should call api with numbersapi with the application/json', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('http://numbersapi.com/$tNumber'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer(
              (_) async => http.Response(readFixture('trivial.json'), 200));
      // act
      remoteDateSourceImpl.getConcretNumerTrvial(tNumber);
      // verify
      verify(mockHttpClient.get(Uri.parse('http://numbersapi.com/$tNumber'),
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return correct numberTravial model in case of success calling',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('http://numbersapi.com/$tNumber'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer(
              (_) async => http.Response(readFixture('trivial.json'), 200));
      // act
      final result = await remoteDateSourceImpl.getConcretNumerTrvial(tNumber);
      // verify
      expect(result, TnumberTrivialModel);
    });

    test('should Through Server exception when any error happended', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('http://numbersapi.com/$tNumber'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response("error message", 400));
      // act
      final call = remoteDateSourceImpl.getConcretNumerTrvial;
      // verify
      expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getRandumNumerTrvial', () {
    final TnumberTrivialModel =
        NumberTrivialModel(text: 'text test', number: 1);

    test('should call api with numbersapi with the application/json', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('http://numbersapi.com/random'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer(
              (_) async => http.Response(readFixture('trivial.json'), 200));
      // act
      remoteDateSourceImpl.getRandumNumerTrvial();
      // verify
      verify(mockHttpClient.get(Uri.parse('http://numbersapi.com/random'),
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return correct numberTravial model in case of success calling',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('http://numbersapi.com/random'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer(
              (_) async => http.Response(readFixture('trivial.json'), 200));
      // act
      final result = await remoteDateSourceImpl.getRandumNumerTrvial();
      // verify
      expect(result, TnumberTrivialModel);
    });

    test('should Through Server exception when any error happended', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('http://numbersapi.com/random'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response("error message", 400));
      // act
      final call = remoteDateSourceImpl.getRandumNumerTrvial;
      // verify
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
