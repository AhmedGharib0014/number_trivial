import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivial/core/error/failure.dart';
import 'package:number_trivial/dependency_container.dart';
import 'package:number_trivial/features/numbertrivial/presentatoion/bloc/bloc/numbertrivial_bloc.dart';
import 'package:number_trivial/features/numbertrivial/presentatoion/widgets/index.dart';

class NumberTrivialPage extends StatelessWidget {
  const NumberTrivialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Number Trivia"),
        backgroundColor: Colors.green.shade800,
      ),
      body: BlocProvider(
        create: (context) => getIt<NumbertrivialBloc>(),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              BlocBuilder<NumbertrivialBloc, NumbertrivialState>(
                builder: (context, state) {
                  if (state is NumbertrivialInitial)
                    return CenteredMessage(
                      message: 'start searching',
                    );
                  else if (state is NumbertrivialLoading)
                    return Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  else if (state is NumbertrivialFailure)
                    return CenteredMessage(
                      message: state.error,
                    );
                  else if (state is NumbertrivialSuccess)
                    return TrivialDiplay(
                      numberTrivial: state.numberTrivial,
                    );
                  else
                    return Container();
                },
              ),
              TrivialControlles(),
            ],
          ),
        ),
      ),
    );
  }
}
