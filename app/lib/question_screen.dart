import 'package:flutter/material.dart';

import 'components/answer_button.dart';
import 'model/question.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    final question = ModalRoute.of(context)!.settings.arguments as Question;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Colors.red,// set border color
                  width: 3.0),   // set border width
              borderRadius: const BorderRadius.all(
                  Radius.circular(10.0)), // set rounded corner radius
            ),
            child: Text(question.question),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnswerButton(answer: question.answers[0]),
              AnswerButton(answer: question.answers[1]),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnswerButton(answer: question.answers[2]),
              AnswerButton(answer: question.answers[3]),
            ],
          ),
        ],
      ),
    );
  }
}
