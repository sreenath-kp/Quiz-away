import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/screens/questions_screen.dart';
import 'package:quiz_app/screens/onboarding_screen.dart';
import 'package:quiz_app/screens/result_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  String activeScreen = 'onboarding';
  List<String> selectedAnswers = [];
  void switchScreen() {
    setState(() {
      activeScreen = 'questions';
    });
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'onboarding';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'result';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          if (activeScreen == 'onboarding') {
            return OnboardingScreen(switchScreen);
          } else if (activeScreen == 'questions') {
            return QuestionsScreen(chooseAnswer);
          } else if (activeScreen == 'result') {
            return ResultScreen(
              onRestart: restartQuiz,
              selectedAnswers: selectedAnswers,
            );
          }
          return Container();
        },
      ),
    );
  }
}
