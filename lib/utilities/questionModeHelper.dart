// ignore: file_names
class QuestionModeHelper {
  final List questions;
  late String _currentQuestionMode;

  QuestionModeHelper(this.questions, currentQuestionMode) {
    _currentQuestionMode = _determineQuestionMode(currentQuestionMode);
  }

  String _determineQuestionMode(currentQuestion) {
    return questions.isNotEmpty
        ? (questions[currentQuestion]['questionMode'] ?? 'multipleChoices')
        : 'multipleChoices';
  }

  bool get isMultipleChoices => _currentQuestionMode == 'multipleChoices';
  bool get isTrueOrFalse => _currentQuestionMode == 'trueOrFalse';
  bool get isPlayerSearch =>
      _currentQuestionMode == 'passwordChallenge' ||
      _currentQuestionMode == 'guessThePlayer';
  bool get isReversedWords => _currentQuestionMode == 'reversedWords';
  bool get showHints =>
      _currentQuestionMode == 'guessThePlayer' ||
      _currentQuestionMode == 'passwordChallenge';
}
