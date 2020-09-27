import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function someHandler;
  final String answerText;
  Answer(this.someHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        textColor: Colors.white,
        child: Text(answerText),
        onPressed: someHandler,
        color: Colors.lightBlue,
      ),
    );
  }
}
