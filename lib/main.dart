// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:true_false_app/questions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const True_False());
}

class True_False extends StatelessWidget {
  const True_False({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: BodyWidget(),
      ),
    );
  }
}

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  List<Widget> scoreKeeper = [];
  List<Question> questionBank = [
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true)
  ];
  int questionNumber = 0;
  int score = 0;
  correctAnswer() {
    score++;
    return scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
  }

  wrongAnswer() {
    return scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
  }

  checkAnswer(bool userChoice) {
    bool currentAns = questionBank[questionNumber].ansForQuestion;
    if (currentAns == userChoice) {
      correctAnswer();
    } else {
      wrongAnswer();
    }
    questionNumber++;
    if (scoreKeeper.length == 3) {
      _onCustomAnimationAlertPressed(context);
    }
  }

  _onCustomAnimationAlertPressed(context) {
    Alert(
      context: context,
      title: "Quiz Success",
      desc: "Already Reached the End of the Quiz.  Score $score",
    ).show();
    setState(() {
      scoreKeeper = [];
      score = 0;
      questionNumber = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  questionBank[questionNumber].question,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  if (scoreKeeper.length <= 2) {
                    checkAnswer(true);
                  } else {
                    _onCustomAnimationAlertPressed(context);
                  }
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 60),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Text(
                'True',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    backgroundColor: Colors.green),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  if (scoreKeeper.length <= 2) {
                    checkAnswer(false);
                  } else {
                    _onCustomAnimationAlertPressed(context);
                  }
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 60),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  backgroundColor: Colors.red,
                ),
              ),
            ),
          ),
          Row(children: scoreKeeper),
          const SizedBox(
            height: 40.0,
          ),
        ],
      ),
    );
  }
}
