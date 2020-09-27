import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;
  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    //getter method and object combined
    String resultText;
    if (resultScore >= 18) {
      resultText = 'You are Awesome!!!';
    } else if (resultScore >= 15) {
      resultText = 'Pretty Likable';
    } else if (resultScore >= 10) {
      resultText = 'You are so bad';
    } else {
      resultText = 'Meh... pure evil';
    }

    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(
          resultPhrase,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        RaisedButton(onPressed: resetHandler, child: Text('Restart Quiz'))
      ],
    ));
  }
}
