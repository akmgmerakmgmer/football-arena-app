import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/reversed_words.dart';
import 'package:in_zone_app/utilities/online_methods.dart';
import 'package:in_zone_app/utilities/socket_methods.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/containers/fade_transition.dart';
import 'package:in_zone_app/widgets/containers/image_background_plain.dart';
import 'package:in_zone_app/widgets/containers/page_plain_container.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/waiting_for_other_players.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading.dart';
import 'package:in_zone_app/widgets/screens/questions/countdown.dart';
import 'package:in_zone_app/widgets/screens/questions/game_final_result.dart';
import 'package:in_zone_app/widgets/screens/questions/multiple_choices.dart';
import 'package:in_zone_app/widgets/screens/questions/multiple_players_positioning.dart';
import 'package:in_zone_app/widgets/screens/questions/player_search.dart';
import 'package:in_zone_app/widgets/screens/questions/true_or_false.dart';
import 'package:in_zone_app/widgets/screens/questions/two_players_stats.dart';
import 'package:in_zone_app/widgets/screens/questions/you_drew_Image.dart';
import 'package:in_zone_app/widgets/screens/questions/you_lost_image.dart';
import 'package:in_zone_app/widgets/screens/questions/you_won_image.dart';
import 'package:provider/provider.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'dart:convert'; // For utf8 encoding
import 'package:crypto/crypto.dart'; // For SHA-256

class MultiQuestions extends StatefulWidget {
  const MultiQuestions({super.key});

  @override
  State<MultiQuestions> createState() => _QuestionsState();
}

class _QuestionsState extends State<MultiQuestions>
    with WidgetsBindingObserver {
  // States
  // final Connectivity _connectivity = Connectivity();
  // bool youCheated = false;
  Timer? _timer;
  String userId = '';
  List questions = [];
  int currentPage = 1;
  int currentQuestion = 0;
  String questionMode = 'multipleChoices';
  int points = 0;
  List chosenPlayers = [];
  List displayChosenPlayers = [];
  List hints = [];
  int defaultCountDown = 90;
  int pointValue = 1;
  int pointDefaultValue = 0;
  int multiplyPoints = 1;
  bool activateVar = false;
  bool countStarted = false;
  List advertisments = [];
  bool showAd = false;
  int currentAd = -1;
  int currentAdCountDown = 6;
  bool stopAdCount = true;
  List usedPerks = [];
  bool anyTimePerkActive = false;
  bool stoppageTimeActive = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _multiGameAudio = AudioPlayer();
  List roomPlayers = [];
  int numberOfPlayers = 2;
  final SocketMethods _socketMethods = SocketMethods();
  bool questionsFinished = false;
  bool youWonState = false;
  bool youDrewState = false;
  bool allPlayersTimeDone = false;
  bool oneUserLeft = false;
  bool gameDoneLoading = false;
  bool multiGameSoundPlaying = false;
  bool matchResultCalculated = false;
  late ValueNotifier<int> _countDownNotifier;

  // Methods
  Future<void> getQuestions() async {
    if (mounted) {
      Map room = Provider.of<LocaleProvider>(context, listen: false).room;
      setState(() {
        questions = [...room['questions']];
      });
      getQuestionMode();
      initializeHints();
    }
  }

  initializeNotifiers() {
    _countDownNotifier = ValueNotifier(90);
  }

  void initializeHints() {
    if (currentQuestion == 0 && hints.isEmpty && showHints() && mounted) {
      setState(() {
        hints = [questions[currentQuestion]['hints'][0]];
      });
    }
  }

  void getQuestionMode() {
    if (mounted) {
      if (questions[currentQuestion]['questionMode'] == null) {
        setState(() {
          questionMode = 'multipleChoices';
        });
      } else {
        setState(() {
          questionMode = questions[currentQuestion]['questionMode'];
        });
      }
    }
  }

  bool showHints() {
    if (questionMode == 'guessThePlayer' ||
        questionMode == 'passwordChallenge') {
      return true;
    }
    return false;
  }

  void getToNextQuestion() {
    if (mounted) {
      if (currentQuestion == questions.length - 1) {
        setState(() {
          questionsFinished = true;
        });
      } else {
        if (questionMode == 'guessTheTeam') {
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
        });
        getQuestionMode();
        if (questions[currentQuestion]['hints'] != null &&
            questions[currentQuestion]['hints'].length > 0) {
          setState(() {
            hints = [questions[currentQuestion]['hints'][0]];
          });
        }
      }
    }
  }

  void rightAnswerPoints() {
    if (mounted) {
      if (questionMode == 'reversedWords') {
        pointDefaultValue = 5;
      } else if (showHints()) {
        int hintsSubtract =
            questions[currentQuestion]['hints'].length - hints.length + 1;
        pointDefaultValue = hintsSubtract > 3 ? 10 : 5;
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
  }

  void playCountDownSound() async {
    _audioPlayer.stop();
    _audioPlayer.play(AssetSource('audio/countdown.mp3'));
  }

  void playCorrectSound() async {
    _audioPlayer.stop();
    _audioPlayer.play(AssetSource('audio/correct.mp3'));
  }

  void playWrongSound() async {
    _audioPlayer.stop();
    _audioPlayer.play(AssetSource('audio/buzzer.mp3'));
  }

  void calculateMultiPoints() {
    Map room = Provider.of<LocaleProvider>(context, listen: false).room;
    Map emittedData = {
      'userId': userId,
      'roomId': room['_id'],
      'points': points
    };
    _socketMethods.sendPoints(emittedData);
  }

  void rightAnswer() {
    playCorrectSound();
    rightAnswerPoints();
    calculateMultiPoints();
    getToNextQuestion();
  }

  void wrongAnswer(index) {
    if (questionMode == 'reversedWords') {
      return wrongAnswerActions();
    }
    if (questionMode == 'passwordChallenge' ||
        questionMode == 'guessThePlayer') {
      return wrongAnswerActions();
    }
    if (questionMode == 'trueOrFalse') {
      return wrongAnswerActions();
    }
    if (!questions[currentQuestion]['choices'][index]
            .containsKey('wrongAnswer') &&
        questionMode == 'multipleChoices') {
      return wrongAnswerActions();
    }
  }

  void wrongAnswerActions() {
    if (mounted) {
      playWrongSound();
      if (points != 0 && !activateVar) {
        setState(() {
          points = points - 1;
        });
      }
      calculateMultiPoints();
      if (activateVar) {
        activateVar = false;
      }
      if (questionMode != 'reversedWords' &&
          questionMode != 'passwordChallenge' &&
          questionMode != 'guessThePlayer') {
        getToNextQuestion();
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
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    if (questionMode == 'reversedWords' &&
        generateSHA256Hash(answer) ==
            questions[currentQuestion]['answer'][locale].toLowerCase()) {
      return rightAnswer();
    }
    if (generateSHA256Hash(answer) == questions[currentQuestion]['answer']) {
      return rightAnswer();
    }
    wrongAnswer(index);
  }

  int showPointsValue() {
    if (questionMode == 'reversedWords') {
      return 5;
    } else if (showHints()) {
      int hintsSubtract =
          questions[currentQuestion]['hints'].length - hints.length + 1;
      return hintsSubtract > 3 ? 10 : 5;
    } else if (questions[currentQuestion]['difficulty'] == 'hard') {
      return 3;
    } else if (questions[currentQuestion]['difficulty'] == 'medium') {
      return 2;
    }
    return 1;
  }

  showPlayerSearch() {
    if (questionMode == 'guessThePlayer' ||
        questionMode == 'guessTheTeam' ||
        questionMode == 'passwordChallenge') {
      return true;
    }
    return false;
  }

  void penaltyMethod(id) {
    if (mounted) {
      if (!showPlayerSearch() &&
          questions[currentQuestion]['questionMode'] != 'reversedWords' &&
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
              !indeces.contains(questions[currentQuestion]['choices']
                  [randomIndex]['value']) &&
              !questions[currentQuestion]['choices'][randomIndex]
                  .containsKey('wrongAnswer')) {
            questions[currentQuestion]['choices'][randomIndex]['wrongAnswer'] =
                true;
            indeces.add(
                questions[currentQuestion]['choices'][randomIndex]['value']);
            numberOfChoicesRemoved += 1;
          }
        }
        setState(() {
          questions = questions;
        });
      }
    }
  }

  void skipQuestionMethod(id) {
    if (mounted) {
      setState(() {
        usedPerks.add(id);
      });
      getToNextQuestion();
    }
  }

  void multiplyPointsMethod(id, multiplicationNumber, int time) {
    if (mounted) {
      setState(() {
        usedPerks.add(id);
      });
      multiplyPoints = multiplicationNumber;
      Timer.periodic(Duration(seconds: time), (Timer timer) {
        multiplyPoints = 1;
      });
    }
  }

  void varMethod(id) {
    if (mounted) {
      setState(() {
        usedPerks.add(id);
      });
      activateVar = true;
    }
  }

  void leaveRoomListenerMethod(players, room) {
    _multiGameAudio.stop();
    _audioPlayer.stop();
    if (mounted) {
      roomPlayers = players;
      if (roomPlayers.length == 1 && numberOfPlayers == 2) {
        setState(() {
          oneUserLeft = true;
        });
        matchEndCalculation(room);
      }
    }
  }

  changeCountDown(value) {
    _countDownNotifier.value = value;
    if (value == 0) {
      setState(() {
        gameDoneLoading = true;
        allPlayersTimeDone = true;
      });
      Map room = Provider.of<LocaleProvider>(context, listen: false).room;
      Future.delayed(const Duration(seconds: 1), () {
        matchEndCalculation(room);
      });
    }
    if (value < 6 && value > -1) {
      playCountDownSound();
    }
  }

  void initialFetch() async {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    userId = localeProvider.user['_id'].toString();
    roomPlayers =
        Provider.of<LocaleProvider>(context, listen: false).room['players'];
    numberOfPlayers = Provider.of<LocaleProvider>(context, listen: false)
        .room['numberOfPlayers'];

    _socketMethods.leaveRoomListener(localeProvider, leaveRoomListenerMethod);
    _socketMethods.countDownListener(changeCountDown);
    getQuestions();
  }

  void matchEndCalculation(room) async {
    if (mounted) {
      _multiGameAudio.stop();
      _audioPlayer.stop();
      setState(() {
        gameDoneLoading = true;
      });
      matchResultCalculated = true;
      _socketMethods.gameDone({'roomId': room['_id']});
      if (roomPlayers.length == 1 &&
          roomPlayers[0]['userId']['_id'].toString() == userId &&
          numberOfPlayers == 2) {
        await OnlineMethods().winnerUpdate(userId, usedPerks, context);
        setState(() {
          youWonState = true;
          gameDoneLoading = false;
        });
        return;
      }
      if (roomPlayers.length > 1 || numberOfPlayers > 2) {
        int maxPoints = 0;
        for (var player in room['players']) {
          if (player['points'] > maxPoints &&
              player['userId']['_id'].toString() != userId.toString()) {
            maxPoints = player['points'];
          }
        }
        if (points > maxPoints) {
          await OnlineMethods().winnerUpdate(userId, usedPerks, context);
          setState(() {
            youWonState = true;
            gameDoneLoading = false;
          });
          return;
        }
        if (points == maxPoints) {
          setState(() {
            youDrewState = true;
            gameDoneLoading = false;
          });
          await OnlineMethods().drawUpdate(usedPerks, context);
          return;
        }
        await OnlineMethods().loserUpdate(userId, usedPerks, context);
        setState(() {
          gameDoneLoading = false;
        });
      }
    }
  }

  void playMultiGameSound() async {
    setState(() {
      multiGameSoundPlaying = true;
    });
    _multiGameAudio.setVolume(0.8);
    await _multiGameAudio.setReleaseMode(ReleaseMode.loop);
    _multiGameAudio.play(AssetSource('audio/multi_game.mp3'));
  }

  // checkConnection() {
  //   _connectivity.onConnectivityChanged
  //       .listen((List<ConnectivityResult> results) {
  //     if (results.isNotEmpty &&
  //         !results.contains(ConnectivityResult.none) == false) {
  //       youCheated = true;
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      initializeNotifiers();
      initialFetch();
      leaveRoomWhenStateChanges();
      playMultiGameSound();
      WidgetsBinding.instance.addObserver(this);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void leaveRoomWhenStateChanges() {
    SystemChannels.lifecycle.setMessageHandler((message) async {
      if (message == AppLifecycleState.inactive.toString()) {
      } else if (message == AppLifecycleState.paused.toString() &&
          numberOfPlayers == 2) {
        leaveRoom();
      } else if (message == AppLifecycleState.detached.toString() &&
          numberOfPlayers == 2) {
        leaveRoom();
      }
      return null;
    });
  }

  void addHintAction() {
    if (mounted) {
      List questionHints = questions[currentQuestion]['hints'];
      if (hints.length < questionHints.length) {
        List updatedHints = [...hints, questionHints[hints.length]];
        setState(() {
          hints = updatedHints;
        });
      }
    }
  }

  void skipAction() {
    wrongAnswer(0);
    getToNextQuestion();
  }

  void deleteWord() {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    for (var element in questions[currentQuestion]['reversedAnswer'][locale]) {
      element['isChosen'] = false;
    }
  }

  void leaveRoom() {
    _multiGameAudio.stop();
    _audioPlayer.stop();
    if (!youWonState && !youDrewState && numberOfPlayers == 2) {
      Navigator.pushReplacementNamed(context, '/main-online-screen');
      Map room = Provider.of<LocaleProvider>(context, listen: false).room;
      for (var player in room['players']) {
        if (player['userId']['_id'] == userId) {
          player['isLeft'] = true;
        }
      }
      roomPlayers = room['players'];
      roomPlayers = roomPlayers
          .where((player) => player['userId']['_id'] != userId)
          .toList();
      _socketMethods.leaveRoom({
        'roomPlayers': roomPlayers,
        'roomId': room['_id'],
        'fullRoom': room
      });
      OnlineMethods().loserUpdate(userId, usedPerks, context);
    } else {
      Navigator.pushReplacementNamed(context, '/main-online-screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: true);
    String locale = localeProvider.locale;
    Map user = localeProvider.user;
    String code = localeProvider.room['code'];
    bool isCasual = localeProvider.room['isCasual'];
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        leaveRoom();
      },
      child: PagePlainContainer(
          body: ImageBackgroundPlain(
        image: user['selectedTheme'],
        body: gameDoneLoading
            ? const PrimaryLoading()
            : allPlayersTimeDone && numberOfPlayers > 2
                ? GameFinalResult(players: roomPlayers)
                : allPlayersTimeDone || oneUserLeft
                    ? youDrewState
                        ? YouDrewImage(
                            locale: locale,
                            isCasual: isCasual,
                            code: code,
                          )
                        : youWonState
                            ? YouWonImage(
                                locale: locale,
                                isCasual: isCasual,
                                code: code,
                              )
                            : YouLostImage(
                                locale: locale,
                                isCasual: isCasual,
                                code: code,
                              )
                    : questionsFinished
                        ? WaitingForOtherPlayers(
                            title: AppLocalizations.of(context)!
                                .waiting_for_player_to_finish,
                          )
                        : Stack(
                            children: [
                              numberOfPlayers > 2
                                  ? Container()
                                  : TwoPlayersStats(
                                      usedPerks: usedPerks,
                                      user: user,
                                      points: points,
                                      stopTime: () {},
                                      penalty: penaltyMethod,
                                      varMethod: varMethod,
                                      stoppageTime: () {},
                                      pointsMultiplicationMethod:
                                          multiplyPointsMethod,
                                      skipQuestion: skipQuestionMethod,
                                      locale: locale,
                                      localeProvider: localeProvider,
                                    ),
                              FadeTransitionContainer(
                                body: Container(
                                  padding: const EdgeInsets.all(0),
                                  margin: EdgeInsets.only(
                                      top: hints.length > 3 ? 32 : 0),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CountDown(
                                          countDownNotifier: _countDownNotifier,
                                          defaultCountDown: defaultCountDown,
                                          defaultSize: 60,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        BlurBackgroundContainer(
                                          padding: 12,
                                          margin: 10,
                                          body: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextWidget(
                                                title: locale == 'ar'
                                                    ? '${questions[currentQuestion]['question']['ar']} (${showPointsValue()} ${AppLocalizations.of(context)!.points})'
                                                    : '${questions[currentQuestion]['question']['en']} (${showPointsValue()} ${AppLocalizations.of(context)!.points})',
                                                fontSize: 16.5,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        PlayerSearch(
                                          locale: locale,
                                          isPlayerSearch: questionMode ==
                                                  'guessThePlayer' ||
                                              questionMode ==
                                                  'passwordChallenge',
                                          questionHintsLength:
                                              questions[currentQuestion]
                                                      ['hints']
                                                  .length,
                                          hints: hints,
                                          addHintAction: addHintAction,
                                          skipAction: skipAction,
                                          playerAction: choiceAction,
                                        ),
                                        MultipleChoices(
                                          locale: locale,
                                          choices: questions[currentQuestion]
                                              ['choices'],
                                          isMultipleChoices:
                                              questionMode == 'multipleChoices',
                                          action: choiceAction,
                                          enableFeedback: false,
                                        ),
                                        TrueOrFalse(
                                          locale: locale,
                                          choices: questions[currentQuestion]
                                              ['choices'],
                                          isTrueOrFalse:
                                              questionMode == 'trueOrFalse',
                                          action: choiceAction,
                                          enableFeedback: false,
                                        ),
                                        ReversedWords(
                                            isReversedWords:
                                                questionMode == 'reversedWords',
                                            initiateAnswer: (answer) =>
                                                choiceAction(answer, 0),
                                            skipAction: skipAction,
                                            reversedWord: questions[
                                                            currentQuestion]
                                                        ['reversedAnswer'] !=
                                                    null
                                                ? questions[currentQuestion]
                                                    ['reversedAnswer'][locale]
                                                : [],
                                            deleteWord: deleteWord)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              numberOfPlayers > 2
                                  ? MultiplPlayersPositioning(
                                      players: roomPlayers,
                                      user: user,
                                      localeProvider: localeProvider,
                                    )
                                  : Container(),
                            ],
                          ),
      )),
    );
  }
}
