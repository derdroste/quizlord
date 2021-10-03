import 'package:flutter/material.dart';
import 'package:quiz_lord/question_screen.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizLord',
      routes: {
        '/': (context) => HomeScreen(),
        '/question': (context) => QuestionScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}