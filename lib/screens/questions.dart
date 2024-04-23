import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/providers/locale_provider.dart';
import 'package:flutter_challenge_mobile/utilities/api_methods.dart';
import 'package:flutter_challenge_mobile/widgets/buttons/save_exit_button.dart';
import 'package:flutter_challenge_mobile/widgets/containers/fade_transition.dart';
import 'package:flutter_challenge_mobile/widgets/containers/glass_background_container.dart';
import 'package:flutter_challenge_mobile/widgets/containers/image_background_plain.dart';
import 'package:flutter_challenge_mobile/widgets/containers/page_plain_container.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/text_widget.dart';
import 'package:flutter_challenge_mobile/widgets/loadings/primary_loading.dart';
import 'package:flutter_challenge_mobile/widgets/screens/questions/game_over.dart';
import 'package:flutter_challenge_mobile/widgets/screens/questions/multiple_choices.dart';
import 'package:flutter_challenge_mobile/widgets/screens/questions/stats.dart';
import 'package:flutter_challenge_mobile/widgets/screens/questions/true_or_false.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:just_audio/just_audio.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  // States
  List questions = [];
  int currentPage = 1;
  bool pageLoading = false;
  int currentQuestion = 0;
  int points = 0;
  int lives = 10;
  int coins = 0;
  int answeredConsecutively = 0;
  List chosenPlayers = [];
  List displayChosenPlayers = [];
  List hints = [];
  int defaultCountDown = 20;
  bool stoppageTimeActivated = false;
  int countDown = 20;
  int pointValue = 1;
  int pointDefaultValue = 0;
  int multiplyPoints = 1;
  bool activateVar = false;
  int numberOfPointsToCoin = 5;
  bool countStarted = false;
  bool stopCount = false;
  bool show = true;
  bool saveLoading = false;
  bool penaltyActivated = false;
  bool allowVarActivation = true;
  bool stopCountActivated = false;
  final audioPlayer = AudioPlayer();
  String correctAudio =
      'https://res.cloudinary.com/do0qe5hin/video/upload/v1713830132/vdnaipfdraveg92re1bi.mp4';
  String buzzerAudio =
      'https://res.cloudinary.com/do0qe5hin/video/upload/v1713830128/pxay0ehplbk4p1vmcdzf.mp4';
  // Methods
  Future<void> getQuestions() async {
    if (questions.isEmpty) {
      setState(() {
        pageLoading = true;
      });
    }
    FetchApi('questions?page=$currentPage', (res) {
      setState(() {
        questions = [...questions, ...res['questions']];
        pageLoading = false;
      });
      if (res['questions'].length == 0) {
        currentPage = 0;
      }
      if (!countStarted) {
        setState(() {
          countDown = setCount();
        });
        decreaseCount();
        countStarted = true;
      }
      if (currentQuestion == 0 && hints.isEmpty && showHints()) {
        setState(() {
          hints = [questions[currentQuestion]['hints'][0]];
        });
      }
    }, errorCallback: () {
      setState(() {
        Navigator.pushNamed(context, '/');
      });
    }).fetch(context);
  }

  void decreaseCount() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!stopCount && lives != 0) {
        if (countDown > 0) {
          setState(() {
            countDown = countDown - 1;
          });
        } else {
          answeredConsecutively = 0;
          setState(() {
            currentQuestion = currentQuestion + 1;
          });
          if (lives > 0) {
            soundPlayMethod(buzzerAudio);
            setState(() {
              lives = lives - 1;
            });
          }
          if (points > 0) {
            setState(() {
              points = points - 1;
            });
          }
          if ((points / numberOfPointsToCoin).floor() != coins) {
            setState(() {
              coins = (points / numberOfPointsToCoin).floor();
            });
          }
          setState(() {
            countDown = defaultCountDown;
          });
        }
      }
    });
  }

  String getQuestionMode() {
    if (questions[currentQuestion]['questionMode'] == null) {
      return 'multipleChoices';
    } else {
      return questions[currentQuestion]['questionMode'];
    }
  }

  bool isMultipleChoices() {
    return getQuestionMode() == 'multipleChoices' ? true : false;
  }

  bool isTrueOrFalse() {
    return getQuestionMode() == 'trueOrFalse' ? true : false;
  }

  void getNextPatchOfQuestions() {
    if (questions.length - currentQuestion <= 7) {
      currentPage++;
      getQuestions();
    }
  }

  bool showHints() {
    String questionMode = getQuestionMode();
    if (questionMode == 'guessThePlayer' ||
        questionMode == 'passwordChallenge') {
      return true;
    }
    return false;
  }

  bool showImage() {
    String questionMode = getQuestionMode();
    if (questionMode == 'guessTheTeam') {
      return true;
    }
    return false;
  }

  int setCount() {
    String questionMode = getQuestionMode();
    if (showHints()) {
      defaultCountDown = 120;
    } else if (questionMode == 'guessTheTeam') {
      defaultCountDown = 180;
    } else {
      defaultCountDown = 20;
    }
    if (stoppageTimeActivated) {
      defaultCountDown = (defaultCountDown / 2) as int;
    }
    return defaultCountDown;
  }

  void getToNextQuestion() {
    if (getQuestionMode() == 'guessTheTeam') {
      setState(() {
        chosenPlayers = [];
        displayChosenPlayers = [];
      });
    }
    if (hints.isNotEmpty || showHints()) {
      setState(() {
        hints = [];
      });
    }
    setState(() {
      currentQuestion = currentQuestion + 1;
      countDown = setCount();
    });
    if (questions[currentQuestion]['hints'] != null &&
        questions[currentQuestion]['hints'].length > 0) {
      setState(() {
        hints = [questions[currentQuestion]['hints'][0]];
      });
    }
    // setState(() {
    //   show = false;
    // });
    // Timer.periodic(const Duration(milliseconds: 1), (Timer timer) {
    //   setState(() {
    //     show = true;
    //   });
    // });
  }

  void rightAnswerPoints() {
    if (answeredConsecutively != 0 &&
        (answeredConsecutively / 5).ceil() != pointValue) {
      pointValue = (answeredConsecutively / 5).floor();
    }
    if (showImage() && questions[currentQuestion]['difficulty'] == 'easy') {
      pointDefaultValue = 20;
    } else if (showImage() &&
        questions[currentQuestion]['difficulty'] == 'medium') {
      pointDefaultValue = 30;
    } else if (showImage() &&
        questions[currentQuestion]['difficulty'] == 'hard') {
      pointDefaultValue = 40;
    } else if (showHints()) {
      pointDefaultValue =
          (questions[currentQuestion]['hints'].length - hints.length + 1) * 5;
    } else if (questions[currentQuestion]['difficulty'] == 'hard') {
      pointDefaultValue = 3;
    } else if (questions[currentQuestion]['difficulty'] == 'medium') {
      pointDefaultValue = 2;
    } else {
      pointDefaultValue = 1;
    }
    setState(() {
      points = points + (pointDefaultValue * pointValue * multiplyPoints);
    });
  }

  void soundPlayMethod(audio) {
    audioPlayer.setUrl(audio);
    audioPlayer.play();
  }

  void rightAnswer() {
    soundPlayMethod(correctAudio);
    rightAnswerPoints();
    getToNextQuestion();
    answeredConsecutively += 1;
  }

  void wrongAnswer(index) {
    if (!questions[currentQuestion]['choices'][index]
        .containsKey('wrongAnswer')) {
      soundPlayMethod(buzzerAudio);
      if (lives > 1) {
        getToNextQuestion();
      } else {
        setState(() {
          pageLoading = true;
        });
        saveGame(false);
      }
      answeredConsecutively = 0;
      if (points != 0) {
        setState(() {
          points = points - 1;
        });
      }
      if (lives != 0 && !activateVar) {
        setState(() {
          lives = lives - 1;
        });
      }
      setState(() {
        questions = questions;
      });
      if (activateVar) {
        activateVar = false;
      }
    }
  }

  void choiceAction(answer, index) {
    getNextPatchOfQuestions();
    if (answer == questions[currentQuestion]['answer']) {
      rightAnswer();
    } else {
      wrongAnswer(index);
    }
    if ((points / numberOfPointsToCoin).floor() != coins) {
      setState(() {
        coins = (points / numberOfPointsToCoin).floor();
      });
    }
  }

  int showPointsValue() {
    if (showImage() && questions[currentQuestion]['difficulty'] == 'easy') {
      return 20;
    } else if (showImage() &&
        questions[currentQuestion]['difficulty'] == 'medium') {
      return 30;
    } else if (showImage() &&
        questions[currentQuestion]['difficulty'] == 'hard') {
      return 40;
    } else if (showHints()) {
      return (questions[currentQuestion]['hints'].length - hints.length + 1) *
          5;
    } else if (questions[currentQuestion]['difficulty'] == 'hard') {
      return 3;
    } else if (questions[currentQuestion]['difficulty'] == 'medium') {
      return 2;
    }
    return 1;
  }

  void saveGame(navigate) {
    Map payload = {'points': points, 'coins': coins};
    String userId =
        Provider.of<LocaleProvider>(context, listen: false).user['_id'];
    setState(() {
      saveLoading = true;
    });
    PostApi('user-save-game/$userId', payload, (res) {
      Provider.of<LocaleProvider>(context, listen: false).setUser(res['user']);
      if (navigate) {
        Navigator.pushNamed(context, '/');
      } else {
        setState(() {
          saveLoading = false;
          pageLoading = false;
        });
      }
    }).post(context);
  }

  showPlayerSearch() {
    String questionMode = getQuestionMode();
    if (questionMode == 'guessThePlayer' ||
        questionMode == 'guessTheTeam' ||
        questionMode == 'passwordChallenge') {
      return true;
    }
    return false;
  }

  void penaltyMethod() {
    if (!penaltyActivated &&
        !showPlayerSearch() &&
        questions[currentQuestion]['questionMode'] != 'trueOrFalse') {
      int numberOfChoicesRemoved = 0;

      while (numberOfChoicesRemoved != 2) {
        List indeces = [];
        int randomIndex = (Random().nextDouble() *
                questions[currentQuestion]['choices'].length)
            .floor();
        if (questions[currentQuestion]['choices'][randomIndex]['value'] !=
                questions[currentQuestion]['answer'] &&
            !indeces.contains(
                questions[currentQuestion]['choices'][randomIndex]['value']) &&
            !questions[currentQuestion]['choices'][randomIndex]
                .containsKey('wrongAnswer')) {
          questions[currentQuestion]['choices'][randomIndex]['wrongAnswer'] =
              true;
          indeces
              .add(questions[currentQuestion]['choices'][randomIndex]['value']);
          numberOfChoicesRemoved += 1;
        }
      }
      setState(() {
        questions = questions;
      });
      penaltyActivated = true;
    }
  }

  void varMethod() {
    if (allowVarActivation) {
      activateVar = true;
      allowVarActivation = false;
    }
  }

  void stoppageTimeMethod() {
    stoppageTimeActivated = true;
    multiplyPoints = 2;
    Timer.periodic(const Duration(seconds: 30), (Timer timer) {
      stoppageTimeActivated = false;
      multiplyPoints = 1;
    });
  }

  void stopTimeMethod() {
    if (!stopCountActivated) {
      stopCount = true;
      Timer.periodic(const Duration(seconds: 10), (Timer timer) {
        stopCount = false;
        stopCountActivated = true;
      });
    }
  }

  void playAgain() {
    stopCount = false;
    setState(() {
      currentQuestion = currentQuestion + 1;
      lives = 10;
      coins = 0;
      points = 0;
    });
  }

  void exitGame() {
    Navigator.pushNamed(context, '/');
  }

  @override
  void initState() {
    getQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    return PagePlainContainer(
        body: ImageBackgroundPlain(
      body: pageLoading || questions[currentQuestion] == null
          ? const PrimaryLoading()
          : lives == 0
              ? GameOver(playAgain: playAgain, exitGame: exitGame)
              : Stack(
                  children: [
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: SaveExitButton(
                        buttonText: AppLocalizations.of(context)!.saveAndClose,
                        radius: 100,
                        action: () => saveGame(true),
                        letterSpacing: 0,
                        fontSize: 15,
                        icon: Icons.save_alt,
                        loading: saveLoading,
                      ),
                    ),
                    Stats(
                      user: Provider.of<LocaleProvider>(context, listen: false)
                          .user,
                      points: points,
                      coins: coins,
                      lives: lives,
                      stopTime: stopTimeMethod,
                      penalty: penaltyMethod,
                      varMethod: varMethod,
                      stoppageTime: stoppageTimeMethod,
                    ),
                    FadeTransitionContainer(
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              title: countDown.toString(),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            GlassBackgroundContainer(
                              body: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextWidget(
                                    title: locale == 'ar'
                                        ? '${questions[currentQuestion]['question']['ar']} (${showPointsValue()} ${AppLocalizations.of(context)!.points})'
                                        : '${questions[currentQuestion]['question']['en']} (${showPointsValue()} ${AppLocalizations.of(context)!.points})',
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                            ),
                            MultipleChoices(
                              locale: locale,
                              choices: questions[currentQuestion]['choices'],
                              isMultipleChoices: isMultipleChoices(),
                              action: choiceAction,
                            ),
                            TrueOrFalse(
                              locale: locale,
                              choices: questions[currentQuestion]['choices'],
                              isTrueOrFalse: isTrueOrFalse(),
                              action: choiceAction,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    ));
  }
}
