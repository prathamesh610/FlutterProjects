import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(Scaffold(
      appBar: AppBar(
        title: Text("Hello!"),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: Center(
        child: Text("Hello World!"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text("ClickMe"),
        backgroundColor: Colors.red[600],
      ),
    ));
