import 'package:flutter/material.dart';
import 'package:number_trivial/features/numbertrivial/domain/entities/number_trivial.dart';

class TrivialDiplay extends StatelessWidget {
  final NumberTrivial numberTrivial;
  const TrivialDiplay({Key? key, required this.numberTrivial})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            numberTrivial.number.toString(),
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
            width: double.infinity,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Text(numberTrivial.text ?? ''),
          ))
        ],
      ),
    );
  }
}
