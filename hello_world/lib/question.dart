import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String
      questionText; //we use final because we donot need to change the value of questionText internally since it is a stateless widget
  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        style: TextStyle(
          fontSize: 28,
          color: Colors.amber,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
