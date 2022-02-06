import 'package:number_trivial/features/numbertrivial/domain/entities/number_trivial.dart';

class NumberTrivialModel extends NumberTrivial {
  NumberTrivialModel({String? text, int? number})
      : super(text: text, number: number);

  factory NumberTrivialModel.fromJson(Map<String, dynamic> map) {
    return NumberTrivialModel(
        text: map['text'], number: (map['number'] as num).toInt());
  }

  Map<String, dynamic> toJson() {
    return {
      "text": this.text,
      "number": this.number,
    };
  }
}
