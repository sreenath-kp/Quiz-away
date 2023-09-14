import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
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
  late String category;
  bool loading = false;
  List<Question> questions = [];
  void switchScreen(String selectedCategory) async {
    setState(() {
      category = selectedCategory;
      loading = true;
    });
    final quest = Questions(category: category);
    final response = await quest.fetchQuestion();
    if (response != null) {
      questions = response;
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load questions')));
      setState(() {
        activeScreen = 'onboarding';
      });
    }
    setState(() {
      loading = false;
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
          if (loading == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (activeScreen == 'onboarding') {
            return OnboardingScreen(switchScreen);
          } else if (activeScreen == 'questions') {
            return QuestionsScreen(questions, chooseAnswer);
          } else if (activeScreen == 'result') {
            return ResultScreen(
              onRestart: restartQuiz,
              questions: questions,
              selectedAnswers: selectedAnswers,
            );
          }
          return Container();
        },
      ),
    );
  }
}
