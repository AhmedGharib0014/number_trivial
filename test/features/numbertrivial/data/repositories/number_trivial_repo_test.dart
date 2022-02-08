import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivial/core/error/exceptions.dart';
import 'package:number_trivial/core/error/failure.dart';
import 'package:number_trivial/core/network/networkInfo.dart';
import 'package:number_trivial/features/numbertrivial/data/datasources/locae_number_trivial_data_source.dart';
import 'package:number_trivial/features/numbertrivial/data/datasources/remote_data_source_data_source.dart';
import 'package:number_trivial/features/numbertrivial/data/models/number_trivial_model.dart';
import 'package:number_trivial/features/numbertrivial/data/repositories/number_trevial_repo_impl.dart';
import 'package:number_trivial/features/numbertrivial/domain/entities/number_trivial.dart';

class MockRemoteNumberDataSource extends Mock implements RemoteDateSource {}

class MockLocalNumberDataSource extends Mock implements LocalDateSource {}

class MockNetworkInfo extends Mock implements NetWorkInfo {}

void main() {
  late MockRemoteNumberDataSource remoteNumberDataSource;
  late MockLocalNumberDataSource localNumberDataSource;
  late MockNetworkInfo networkInfo;
  late NumberTrivialRepositpryImplemantation
      numberTrivialRepositpryImplemantation;

  setUp(() {
    remoteNumberDataSource = MockRemoteNumberDataSource();
    localNumberDataSource = MockLocalNumberDataSource();
    networkInfo = MockNetworkInfo();
    numberTrivialRepositpryImplemantation =
        NumberTrivialRepositpryImplemantation(
      remoteDateSource: remoteNumberDataSource,
      localDateSource: localNumberDataSource,
      netWorkInfo: networkInfo,
    );
  });

  void runTestOffline(Function body) {
    group("test offline case", () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  void runTestOnline(Function body) {
    group("test online case", () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  group("getConcretNumbertrivial", () {
    final tnumber = 1;
    final tNumberTrivialModel =
        NumberTrivialModel(number: tnumber, text: "test text");
    NumberTrivial numberTrivial = tNumberTrivialModel;
    test("test connectivity", () async {
      //arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      //act
      numberTrivialRepositpryImplemantation.getConcretNumerTrvial(tnumber);
      //assert
      verify(networkInfo.isConnected);
    });

    runTestOnline(() {
      test('should return remote data when calling remote data is successfull',
          () async {
        // arrange
        when(remoteNumberDataSource.getConcretNumerTrvial(tnumber))
            .thenAnswer((_) async => tNumberTrivialModel);
        //act
        final result = await numberTrivialRepositpryImplemantation
            .getConcretNumerTrvial(tnumber);
        // assert
        verify(remoteNumberDataSource.getConcretNumerTrvial(tnumber));
        expect(result, equals(Right(numberTrivial)));
      });

      test('should cach data when getting remote data is successfull',
          () async {
        // arrange
        when(remoteNumberDataSource.getConcretNumerTrvial(tnumber))
            .thenAnswer((_) async => tNumberTrivialModel);
        //act
        await numberTrivialRepositpryImplemantation
            .getConcretNumerTrvial(tnumber);
        // assert
        verify(localNumberDataSource.saveNumberTrivial(tNumberTrivialModel));
        // verify(remoteNumberDataSource.getConcretNumerTrvial(tnumber));
      });

      test(
          'should through server exception when getting remote data is successfull',
          () async {
        when(remoteNumberDataSource.getConcretNumerTrvial(tnumber))
            .thenThrow(ServerException());
        //act
        final result = await numberTrivialRepositpryImplemantation
            .getConcretNumerTrvial(tnumber);
        // assert
        verify(remoteNumberDataSource.getConcretNumerTrvial(tnumber));
        verifyZeroInteractions(localNumberDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test('fetch number trivial from local data', () async {
        // arrange
        when(localNumberDataSource.getLastNumerTrvial())
            .thenAnswer((_) async => tNumberTrivialModel);
        // act
        final result = await numberTrivialRepositpryImplemantation
            .getConcretNumerTrvial(tnumber);
        //verify
        verifyZeroInteractions(remoteNumberDataSource);
        expect(result, equals(Right(tNumberTrivialModel)));
      });
      test('through CachException if failed to get local data source',
          () async {
        // arrange
        when(localNumberDataSource.getLastNumerTrvial())
            .thenThrow(CachException());
        // act
        final result = await numberTrivialRepositpryImplemantation
            .getConcretNumerTrvial(tnumber);
        //verify
        verifyZeroInteractions(remoteNumberDataSource);
        expect(result, equals(Left(CachFailure())));
      });
    });
  });

  group("getRandomNumbertrivial", () {
    final tNumberTrivialModel =
        NumberTrivialModel(number: 1, text: "test text");
    NumberTrivial numberTrivial = tNumberTrivialModel;
    test("test connectivity", () async {
      //arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      //act
      numberTrivialRepositpryImplemantation.getRandumNumerTrvial();
      //assert
      verify(networkInfo.isConnected);
    });

    runTestOnline(() {
      test('should return remote data when calling remote data is successfull',
          () async {
        // arrange
        when(remoteNumberDataSource.getRandumNumerTrvial())
            .thenAnswer((_) async => tNumberTrivialModel);
        //act
        final result =
            await numberTrivialRepositpryImplemantation.getRandumNumerTrvial();
        // assert
        verify(remoteNumberDataSource.getRandumNumerTrvial());
        expect(result, equals(Right(numberTrivial)));
      });

      test('should cach data when getting remote data is successfull',
          () async {
        // arrange
        when(remoteNumberDataSource.getRandumNumerTrvial())
            .thenAnswer((_) async => tNumberTrivialModel);
        //act
        await numberTrivialRepositpryImplemantation.getRandumNumerTrvial();
        // assert
        verify(localNumberDataSource.saveNumberTrivial(tNumberTrivialModel));
        // verify(remoteNumberDataSource.getConcretNumerTrvial(tnumber));
      });

      test(
          'should through server exception when getting remote data is successfull',
          () async {
        when(remoteNumberDataSource.getRandumNumerTrvial())
            .thenThrow(ServerException());
        //act
        final result =
            await numberTrivialRepositpryImplemantation.getRandumNumerTrvial();
        // assert
        verify(remoteNumberDataSource.getRandumNumerTrvial());
        verifyZeroInteractions(localNumberDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test('fetch number trivial from local data', () async {
        // arrange
        when(localNumberDataSource.getLastNumerTrvial())
            .thenAnswer((_) async => tNumberTrivialModel);
        // act
        final result =
            await numberTrivialRepositpryImplemantation.getRandumNumerTrvial();
        //verify
        verifyZeroInteractions(remoteNumberDataSource);
        expect(result, equals(Right(tNumberTrivialModel)));
      });
      test('through CachException if failed to get local data source',
          () async {
        // arrange
        when(localNumberDataSource.getLastNumerTrvial())
            .thenThrow(CachException());
        // act
        final result =
            await numberTrivialRepositpryImplemantation.getRandumNumerTrvial();
        //verify
        verifyZeroInteractions(remoteNumberDataSource);
        expect(result, equals(Left(CachFailure())));
      });
    });
  });
}
