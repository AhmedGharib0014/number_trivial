import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivial/core/error/exceptions.dart';
import 'package:number_trivial/features/numbertrivial/data/datasources/locae_number_trivial_data_source.dart';
import 'package:number_trivial/features/numbertrivial/data/models/number_trivial_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixure_reader.dart';
import 'local_data_source_test.mocks.dart';

@GenerateMocks([
  SharedPreferences
], customMocks: [
  MockSpec<SharedPreferences>(as: #MockSharedPreferencesForTest1),
])
void main() {
  late MockSharedPreferencesForTest1 mockSharedPrefrenences;
  late LocalNumberTrivialDataSourceImple localNumberTrivialDataSourceImple;

  setUp(() async {
    mockSharedPrefrenences = MockSharedPreferencesForTest1();
    localNumberTrivialDataSourceImple =
        LocalNumberTrivialDataSourceImple(mockSharedPrefrenences);
  });

  group('getLastNumerTrvial', () {
    test('should return Number trivial if there is noe  ', () async {
      // arrange
      when(mockSharedPrefrenences.getString(LOCAL_NUMBER_TRIVIAL_KEY))
          .thenReturn(readFixture('trivial.json'));

      // act
      final result =
          await localNumberTrivialDataSourceImple.getLastNumerTrvial();
      //verify
      verify(mockSharedPrefrenences.getString(LOCAL_NUMBER_TRIVIAL_KEY));
      expect(result, NumberTrivialModel(text: 'text test', number: 1));
    });

    test('should through cachException when there is no trivial stored', () {
      when(mockSharedPrefrenences.getString(LOCAL_NUMBER_TRIVIAL_KEY))
          .thenReturn(null);

      final call = localNumberTrivialDataSourceImple.getLastNumerTrvial;

      expect(() => call(), throwsA(TypeMatcher<CachException>()));
    });
  });

  group('saveNumberTrivial', () {
    NumberTrivialModel TNumberTrivial =
        NumberTrivialModel(number: 1, text: 'test');

    test('should save number trivial', () {
      final modelString = TNumberTrivial.toJson();
      when(mockSharedPrefrenences.setString(
              LOCAL_NUMBER_TRIVIAL_KEY, jsonEncode(modelString)))
          .thenAnswer((_) async => true);
      localNumberTrivialDataSourceImple.saveNumberTrivial(TNumberTrivial);
      verify(mockSharedPrefrenences.setString(
          LOCAL_NUMBER_TRIVIAL_KEY, jsonEncode(modelString)));
    });
  });
}
