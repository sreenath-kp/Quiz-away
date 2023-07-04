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
