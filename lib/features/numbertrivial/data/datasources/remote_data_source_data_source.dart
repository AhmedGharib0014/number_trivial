import 'dart:convert';
import 'dart:io';

import 'package:number_trivial/core/error/exceptions.dart';
import 'package:number_trivial/features/numbertrivial/data/models/number_trivial_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDateSource {
  Future<NumberTrivialModel?>? getConcretNumerTrvial(int? number);
  Future<NumberTrivialModel?>? getRandumNumerTrvial();
}

class RemoteDateSourceImple extends RemoteDateSource {
  final http.Client client;

  RemoteDateSourceImple(this.client);

  @override
  Future<NumberTrivialModel?>? getConcretNumerTrvial(int? number) =>
      _getTrivialNumber('http://numbersapi.com/$number');

  @override
  Future<NumberTrivialModel?>? getRandumNumerTrvial() =>
      _getTrivialNumber('http://numbersapi.com/random');

  Future<NumberTrivialModel?>? _getTrivialNumber(String url) async {
    var response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return NumberTrivialModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
