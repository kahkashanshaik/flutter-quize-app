import 'package:flutter/material.dart';
import 'package:quizapp/data/questions.dart';
import 'package:quizapp/questions_screen.dart';
import 'package:quizapp/start_screen.dart';
import 'package:quizapp/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start_screen';

  void reStartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'start_screen';
    });
  }

  void switchScreen() {
    setState(() {
      activeScreen = 'questions_screen';
    });
  }

  void chooseAsnwer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results_screen';
        // selectedAnswers = [];
      });
    }
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen);
    if (activeScreen == 'questions_screen') {
      screenWidget = QuestionsScreen(
        onSelectAnswer: chooseAsnwer,
      );
    }
    if (activeScreen == 'results_screen') {
      screenWidget = ResultsScreen(
          choosenAnswers: selectedAnswers, onRestart: reStartQuiz);
    }
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 57, 29, 107),
              Color.fromARGB(255, 44, 20, 86),
            ], begin: Alignment.topLeft, end: Alignment.bottomLeft),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
