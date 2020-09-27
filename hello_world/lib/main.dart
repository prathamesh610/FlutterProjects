import 'package:flutter/material.dart';

import './result.dart';
import './quiz.dart';

void main() {
  runApp(MyApp());
}

/// '_' Underscore means private function/class/property add this to keep the data private and to avoid manipulation of data from other sources
/// ONE WIDGET PER FILE
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // .TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _totalScore = 0;

  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    print('Answer Chosen');
  }

  final _questions = const [
    {
      'questionText': 'What\'s your favourite Color?',
      'answerText': [
        {'text': 'Black', 'score': 10},
        {'text': 'White', 'score': 1},
        {'text': 'Red', 'score': 5},
        {'text': 'Orange', 'score': 7}
      ]
    },
    {
      'questionText': 'What\'s your favourite Animal?',
      'answerText': [
        {'text': 'Snake', 'score': 1},
        {'text': 'Lion', 'score': 10},
        {'text': 'Tiger', 'score': 8},
        {'text': 'Dog', 'score': 6},
        {'text': 'Cat', 'score': 4}
      ]
    }
  ];

  void _resetQuiz() {
    setState(() {
      _totalScore = 0;
      _questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello My First App'),
        ),
        body: _questionIndex <
                _questions
                    .length // ```Terniary if operation syntax is``` condition ? widget() : ```this is else block``` elseWidget()
            ? Quiz(
                questions: _questions,
                questionIndex: _questionIndex,
                answerQuestion: _answerQuestion)
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}
