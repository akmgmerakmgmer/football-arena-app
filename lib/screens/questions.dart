import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/utilities/external_url.dart';
import 'package:in_zone_app/widgets/buttons/save_exit_button.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/containers/fade_transition.dart';
import 'package:in_zone_app/widgets/containers/image_background_plain.dart';
import 'package:in_zone_app/widgets/containers/page_plain_container.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading.dart';
import 'package:in_zone_app/widgets/screens/questions/advertisment.dart';
import 'package:in_zone_app/widgets/screens/questions/game_over.dart';
import 'package:in_zone_app/widgets/screens/questions/multiple_choices.dart';
import 'package:in_zone_app/widgets/screens/questions/perks_illustrations.dart';
import 'package:in_zone_app/widgets/screens/questions/stats.dart';
import 'package:in_zone_app/widgets/screens/questions/true_or_false.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert'; // For utf8 encoding
import 'package:crypto/crypto.dart'; // For SHA-256

class Questions extends StatefulWidget {
  final String mode;
  final String userId;
  final String name;
  final bool practice;
  const Questions(
      {super.key,
      this.mode = '',
      this.userId = '',
      this.name = '',
      this.practice = false});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> with WidgetsBindingObserver {
  // States
  Timer? _timer;
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
  int countDown = 20;
  int pointValue = 1;
  int pointDefaultValue = 0;
  int multiplyPoints = 1;
  bool activateVar = false;
  int numberOfPointsToCoin = 5;
  bool countStarted = false;
  bool stopCount = true;
  bool show = true;
  bool saveLoading = false;
  bool showTut = true;
  List advertisments = [];
  bool showAd = false;
  int currentAd = -1;
  int currentAdCountDown = 6;
  bool stopAdCount = true;
  bool gameSaved = false;
  List usedPerks = [];
  bool nextPatchisLoaded = true;
  bool anyTimePerkActive = false;
  bool stoppageTimeActive = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  // Methods
  Future<void> getQuestions() async {
    if (questions.isEmpty) {
      setState(() {
        pageLoading = true;
      });
    }
    FetchApi(
        'questions?page=$currentPage&search=${widget.mode}&userId=${widget.userId}&name=${widget.name}',
        (res) {
      setState(() {
        questions = [...questions, ...res['questions']];
        pageLoading = false;
        nextPatchisLoaded = true;
      });
      if (res['questions'].length == 0) {
        currentPage = 1;
      }
      if (!countStarted) {
        setState(() {
          countDown = setCount();
        });
        decreaseCount();
        decreaseAdCount();
        countStarted = true;
      }
      if (currentQuestion == 0 && hints.isEmpty && showHints()) {
        setState(() {
          hints = [questions[currentQuestion]['hints'][0]];
        });
      }
    }, errorCallback: () {
      setState(() {
        Navigator.pushReplacementNamed(context, '/');
      });
    }).fetch(context);
  }

  void decreaseCount() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
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
            playWrongSound();
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

  void decreaseAdCount() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!stopAdCount && lives != 0) {
        if (currentAdCountDown > 0) {
          setState(() {
            currentAdCountDown -= 1;
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
    if (questions.length - currentQuestion <= 7 && nextPatchisLoaded) {
      nextPatchisLoaded = false;
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
    } else if (stoppageTimeActive) {
      defaultCountDown = 10;
    } else {
      defaultCountDown = 20;
    }
    return defaultCountDown;
  }

  void getToNextQuestion() {
    if ((currentQuestion - 1) % 15 == 0 &&
        currentQuestion != 0 &&
        currentQuestion != 1 &&
        lives != 1 &&
        lives != 0 &&
        advertisments.isNotEmpty) {
      currentAdMethod();
    }
    if (currentQuestion == questions.length - 1) {
      currentQuestion = 0;
    }
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

  void playCorrectSound() async {
    _audioPlayer.stop();
    _audioPlayer.play(AssetSource('audio/correct.mp3'));
  }

  void playWrongSound() async {
    _audioPlayer.stop();
    _audioPlayer.play(AssetSource('audio/buzzer.mp3'));
  }

  void rightAnswer() {
    playCorrectSound();
    rightAnswerPoints();
    getToNextQuestion();
    answeredConsecutively += 1;
  }

  void wrongAnswer(index) {
    if (!questions[currentQuestion]['choices'][index]
        .containsKey('wrongAnswer')) {
      playWrongSound();
      if (lives > 1) {
        getToNextQuestion();
      } else {
        setState(() {
          pageLoading = true;
        });
        saveGame(false);
      }
      answeredConsecutively = 0;
      if (points != 0 && !activateVar) {
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

  String generateSHA256Hash(String input) {
    // Convert the input string to a list of UTF-8 encoded bytes
    List<int> bytes = utf8.encode(input);

    // Generate the SHA-256 hash
    Digest sha256Result = sha256.convert(bytes);

    // Return the hash as a hexadecimal string
    return sha256Result.toString();
  }

  void choiceAction(answer, index) {
    getNextPatchOfQuestions();
    if (generateSHA256Hash(answer) == questions[currentQuestion]['answer']) {
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
    stopCount = true;
    if (points == 0 && navigate) {
      Navigator.pushReplacementNamed(context, '/rankings');
    } else {
      Map payload = {'points': points, 'coins': coins, 'usedPerks': usedPerks};
      String userId =
          Provider.of<LocaleProvider>(context, listen: false).user['_id'];
      setState(() {
        saveLoading = true;
      });
      PostApi('user-save-game/$userId', payload, (res) {
        Provider.of<LocaleProvider>(context, listen: false)
            .setUser(res['user']);
        if (navigate) {
          Navigator.pushReplacementNamed(context, '/rankings');
        } else {
          setState(() {
            saveLoading = false;
            pageLoading = false;
          });
        }
      }).post(context);
    }
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

  void penaltyMethod(id) {
    if (!showPlayerSearch() &&
        questions[currentQuestion]['questionMode'] != 'trueOrFalse') {
      int numberOfChoicesRemoved = 0;
      setState(() {
        usedPerks.add(id);
      });
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
    }
  }

  void skipQuestionMethod(id) {
    setState(() {
      usedPerks.add(id);
    });
    getToNextQuestion();
  }

  void multiplyPointsMethod(id, multiplicationNumber, int time) {
    setState(() {
      usedPerks.add(id);
    });
    multiplyPoints = multiplicationNumber;
    Timer.periodic(Duration(milliseconds: time), (Timer timer) {
      multiplyPoints = 1;
    });
  }

  void varMethod(id) {
    setState(() {
      usedPerks.add(id);
    });
    activateVar = true;
  }

  void stoppageTimeMethod(id) {
    setState(() {
      usedPerks.add(id);
    });
    anyTimePerkActive = true;
    stoppageTimeActive = true;
    multiplyPoints = 2;
    Timer.periodic(const Duration(seconds: 30), (Timer timer) {
      multiplyPoints = 1;
      defaultCountDown = 20;
      anyTimePerkActive = false;
      stoppageTimeActive = false;
    });
  }

  void stopTimeMethod(id) {
    if (!anyTimePerkActive) {
      setState(() {
        usedPerks.add(id);
      });
      stopCount = true;
      anyTimePerkActive = true;
      Timer.periodic(const Duration(seconds: 30), (Timer timer) {
        stopCount = false;
        anyTimePerkActive = false;
      });
    }
  }

  void playAgain() {
    stopCount = false;
    currentAd = 0;
    stoppageTimeActive = false;
    setState(() {
      currentQuestion = currentQuestion + 1;
      lives = 10;
      coins = 0;
      points = 0;
      usedPerks = [];
    });
  }

  void exitGame() {
    Navigator.pushReplacementNamed(context, '/rankings');
  }

  void finishTutorialAction() {
    setState(() {
      stopCount = false;
      showTut = false;
    });
  }

  getAdvertisments() {
    FetchApi('advertisments?page=1', (res) {
      setState(() {
        advertisments = res['advertisments'];
      });
    }).fetch(context);
  }

  currentAdMethod() {
    currentAd = currentAd + 1;
    if (currentAd > advertisments.length - 1) {
      currentAd = 0;
    }
    setState(() {
      currentAdCountDown = 6;
      showAd = true;
      stopCount = true;
      stopAdCount = false;
    });
  }

  void adClicked(id, link) {
    ExternalUrl().launchNewUrl(link);
    PutApi('ad-clicked/$id', {}, (res) {}).put(context);
  }

  void initialFetch() async {
    gameSaved = true;
    await getAdvertisments();
    getQuestions();
  }

  skipAdMethod() {
    if (currentAdCountDown == 0) {
      setState(() {
        stopAdCount = true;
        showAd = false;
        stopCount = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initialFetch();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  void stopGame() {
    setState(() {
      stopCount = true;
    });
    Future.delayed(const Duration(seconds: 5), () {
      getToNextQuestion();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive && gameSaved == false) {
      saveGame(true);
      gameSaved = true;
    } else if (state == AppLifecycleState.paused) {
      saveGame(true);
      gameSaved = true;
    } else if (state == AppLifecycleState.detached) {
      saveGame(true);
      gameSaved = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    if (widget.practice) {
      setState(() {
        lives = 10000000000;
      });
    }
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (!widget.practice) {
          saveGame(true);
        } else {
          Navigator.pushReplacementNamed(context, '/rankings');
        }
      },
      child: PagePlainContainer(
          body: ImageBackgroundPlain(
        body: pageLoading ||
                (questions.isNotEmpty && questions[currentQuestion] == null)
            ? const PrimaryLoading()
            : lives == 0
                ? GameOver(playAgain: playAgain, exitGame: exitGame)
                : Stack(
                    children: [
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: SaveExitButton(
                          buttonText: (widget.practice)
                              ? AppLocalizations.of(context)!.exitGame
                              : AppLocalizations.of(context)!.saveAndClose,
                          radius: 100,
                          action: (widget.practice)
                              ? () =>
                                  {Navigator.pushReplacementNamed(context, '/')}
                              : () => saveGame(true),
                          letterSpacing: 0,
                          fontSize: 15,
                          icon: Icons.save_alt,
                          loading: saveLoading,
                        ),
                      ),
                      Stats(
                        usedPerks: usedPerks,
                        user: user,
                        points: points,
                        coins: coins,
                        lives: lives,
                        stopTime: stopTimeMethod,
                        penalty: penaltyMethod,
                        varMethod: varMethod,
                        stoppageTime: stoppageTimeMethod,
                        pointsMultiplicationMethod: multiplyPointsMethod,
                        skipQuestion: skipQuestionMethod,
                        locale: locale,
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
                              const SizedBox(
                                height: 12,
                              ),
                              BlurBackgroundContainer(
                                padding: 12,
                                margin: 10,
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
                              const SizedBox(
                                height: 16,
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
                      showTut
                          ? PerksIllustrations(
                              action: finishTutorialAction,
                              user: Provider.of<LocaleProvider>(context,
                                      listen: false)
                                  .user,
                            )
                          : Container(),
                      showAd && advertisments.isNotEmpty
                          ? Advertisment(
                              adClicked: () => adClicked(
                                  advertisments[currentAd]['_id'],
                                  advertisments[currentAd]['directionLink']),
                              seconds: currentAdCountDown,
                              skipAdMethod: skipAdMethod,
                              image: advertisments[currentAd]['image'])
                          : Container()
                    ],
                  ),
      )),
    );
  }
}
