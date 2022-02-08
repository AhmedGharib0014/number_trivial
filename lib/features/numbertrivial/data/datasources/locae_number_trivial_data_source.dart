import 'dart:convert';

import 'package:number_trivial/core/error/exceptions.dart';
import 'package:number_trivial/features/numbertrivial/data/models/number_trivial_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDateSource {
  Future<NumberTrivialModel>? getLastNumerTrvial();
  Future<void>? saveNumberTrivial(NumberTrivialModel? numberTrivial);
}

const LOCAL_NUMBER_TRIVIAL_KEY = 'number key';

class LocalNumberTrivialDataSourceImple extends LocalDateSource {
  final SharedPreferences sharedPreferences;

  LocalNumberTrivialDataSourceImple(this.sharedPreferences);

  @override
  Future<NumberTrivialModel>? getLastNumerTrvial() {
    final string = sharedPreferences.getString(LOCAL_NUMBER_TRIVIAL_KEY);
    if (string != null) {
      return Future.value(NumberTrivialModel.fromJson(jsonDecode(string)));
    } else {
      throw CachException();
    }
  }

  @override
  Future<void>? saveNumberTrivial(NumberTrivialModel? numberTrivial) async {
    final result = await sharedPreferences.setString(
        LOCAL_NUMBER_TRIVIAL_KEY, jsonEncode(numberTrivial?.toJson()));
    print(result);
    return;
  }
}
