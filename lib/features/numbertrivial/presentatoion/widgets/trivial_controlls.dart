import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivial/features/numbertrivial/presentatoion/bloc/bloc/numbertrivial_bloc.dart';

class TrivialControlles extends StatefulWidget {
  const TrivialControlles({Key? key}) : super(key: key);

  @override
  _TrivialControllesState createState() => _TrivialControllesState();
}

class _TrivialControllesState extends State<TrivialControlles> {
  late String searchString;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            onChanged: (value) {
              searchString = value;
            },
            decoration: InputDecoration(
                hintText: "enter your number", border: OutlineInputBorder()),
            validator: (value) {
              if (value?.isNotEmpty == true)
                return null;
              else
                return "please enter a valid String";
            },
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          primary: Colors.green.shade800),
                      onPressed: _getConcreteTrivial,
                      child: Text("get trivia"))),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          primary: Colors.green.shade600),
                      onPressed: _getRandomNumber,
                      child: Text("get Random trivia")))
            ],
          )
        ],
      ),
    );
  }

  void _getConcreteTrivial() {
    if (formState.currentState?.validate() == true) {
      BlocProvider.of<NumbertrivialBloc>(context)
          .add(NumbertrivialEventGetConctete(numberString: searchString));
      controller.clear();
    }
  }

  void _getRandomNumber() {
    BlocProvider.of<NumbertrivialBloc>(context)
        .add(NumbertrivialEventGetRandom());
  }
}
