import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {
  final String message;
  const CenteredMessage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: Text(message),
      ),
    );
  }
}
