import 'dart:convert';
import 'package:http/http.dart';
import 'package:html_unescape/html_unescape.dart';

class Question {
  final String question;
  final List<String> answers;
  const Question(this.question, this.answers);
  List<String> shuffledAnswers() {
    final shuffledAnswers = List.of(answers);
    shuffledAnswers.shuffle();
    return shuffledAnswers;
  }
}

class Questions {
  final String category;
  Questions({required this.category});
  Future<List<Question>?> fetchQuestion() async {
    List<Question> fetchedQuestions = [];
    try {
      Response response = await get(Uri(
          scheme: 'https',
          host: 'opentdb.com',
          path: 'api.php',
          queryParameters: {
            'amount': '10',
            'category': category,
            'type': 'multiple',
          }));
      Map data = jsonDecode(response.body);
      var unescape = HtmlUnescape();
      final results = data['results'];
      for (var result in results) {
        final q = Question(unescape.convert(result['question']),
            [...result['incorrect_answers'], result['correct_answer']]);

        q.answers.map((e) => unescape.convert(e)).toList();
        fetchedQuestions.add(q);
      }
      return fetchedQuestions;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
