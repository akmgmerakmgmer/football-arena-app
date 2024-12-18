import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/reversed_words.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/utilities/external_url.dart';
import 'package:in_zone_app/utilities/socket_methods.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/containers/fade_transition.dart';
import 'package:in_zone_app/widgets/containers/image_background_plain.dart';
import 'package:in_zone_app/widgets/containers/page_plain_container.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/waiting_for_other_players.dart';
import 'package:in_zone_app/widgets/screens/questions/advertisment.dart';
import 'package:in_zone_app/widgets/screens/questions/multiple_choices.dart';
import 'package:in_zone_app/widgets/screens/questions/player_search.dart';
import 'package:in_zone_app/widgets/screens/questions/true_or_false.dart';
import 'package:in_zone_app/widgets/screens/questions/two_players_stats.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  Timer? _timer;
  String userId = '';
  List questions = [];
  int currentPage = 1;
  int currentQuestion = 0;
  int points = 0;
  List chosenPlayers = [];
  List displayChosenPlayers = [];
  List hints = [];
  int defaultCountDown = 300;
  int countDown = 300;
  int pointValue = 1;
  int pointDefaultValue = 0;
  int multiplyPoints = 1;
  bool activateVar = false;
  bool countStarted = false;
  bool stopCount = false;
  List advertisments = [];
  bool showAd = false;
  int currentAd = -1;
  int currentAdCountDown = 6;
  bool stopAdCount = true;
  List usedPerks = [];
  bool anyTimePerkActive = false;
  bool stoppageTimeActive = false;
  bool playerTimeDoneCalled = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  List roomPlayers = [];
  final SocketMethods _socketMethods = SocketMethods();
  // Methods
  Future<void> getQuestions() async {
    Map room = Provider.of<LocaleProvider>(context, listen: false).room;
    setState(() {
      questions = [...room['questions']];
    });
    initializeCount();
    initializeHints();
  }

  void initializeCount() {
    if (!countStarted) {
      setState(() {
        countDown = setCount();
      });
      decreaseCount();
      decreaseAdCount();
      countStarted = true;
    }
  }

  void initializeHints() {
    if (currentQuestion == 0 && hints.isEmpty && showHints()) {
      setState(() {
        hints = [questions[currentQuestion]['hints'][0]];
      });
    }
  }

  void decreaseCount() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!stopCount) {
        if (countDown > 0) {
          setState(() {
            countDown = countDown - 1;
          });
        } else {
          playerTimeDone();
        }
      }
    });
  }

  void decreaseAdCount() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!stopAdCount) {
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
    return getQuestionMode() == 'multipleChoices';
  }

  bool isTrueOrFalse() {
    return getQuestionMode() == 'trueOrFalse';
  }

  bool isPlayerSearch() {
    return getQuestionMode() == 'passwordChallenge' ||
        getQuestionMode() == 'guessThePlayer';
  }

  bool isReversedWords() {
    return getQuestionMode() == 'reversedWords';
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
    defaultCountDown = 300;
    return defaultCountDown;
  }

  void getToNextQuestion() {
    if ((currentQuestion - 1) % 15 == 0 &&
        currentQuestion != 0 &&
        currentQuestion != 1 &&
        advertisments.isNotEmpty) {
      currentAdMethod();
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
    });
    if (questions[currentQuestion]['hints'] != null &&
        questions[currentQuestion]['hints'].length > 0) {
      setState(() {
        hints = [questions[currentQuestion]['hints'][0]];
      });
    }
  }

  void rightAnswerPoints() {
    if (isReversedWords()) {
      pointDefaultValue = 5;
    } else if (showHints()) {
      int hintsSubtract =
          questions[currentQuestion]['hints'].length - hints.length + 1;
      pointDefaultValue = hintsSubtract > 3 ? 15 : hintsSubtract * 5;
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

  void calculateMultiPoints() {
    Map room = Provider.of<LocaleProvider>(context, listen: false).room;
    Map emittedData = {
      'userId': userId,
      'roomId': room['_id'],
      'points': points
    };
    _socketMethods.sendPoints(context, emittedData);
  }

  void rightAnswer() {
    playCorrectSound();
    rightAnswerPoints();
    getToNextQuestion();
    calculateMultiPoints();
  }

  void wrongAnswer(index) {
    if (isReversedWords()) {
      return wrongAnswerActions();
    }
    if (isPlayerSearch()) {
      return wrongAnswerActions();
    }
    if (isTrueOrFalse()) {
      return wrongAnswerActions();
    }
    if (!questions[currentQuestion]['choices'][index]
            .containsKey('wrongAnswer') &&
        isMultipleChoices()) {
      return wrongAnswerActions();
    }
  }

  void wrongAnswerActions() {
    playWrongSound();
    if (!isPlayerSearch() && !isReversedWords()) {
      getToNextQuestion();
    }
    if (points != 0 && !activateVar) {
      setState(() {
        points = points - 1;
      });
    }
    setState(() {
      questions = questions;
    });
    if (activateVar) {
      activateVar = false;
    }
    calculateMultiPoints();
  }

  String generateSHA256Hash(String input) {
    // Convert the input string to a list of UTF-8 encoded bytes
    List<int> bytes = utf8.encode(input);

    // Generate the SHA-256 hash
    Digest sha256Result = sha256.convert(bytes);

    // Return the hash as a hexadecimal string
    return input;
    return sha256Result.toString();
  }

  void choiceAction(answer, index) {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    if (isReversedWords() &&
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
    if (isReversedWords()) {
      return 5;
    } else if (showHints()) {
      int hintsSubtract =
          questions[currentQuestion]['hints'].length - hints.length + 1;
      return hintsSubtract > 3 ? 15 : hintsSubtract * 5;
    } else if (questions[currentQuestion]['difficulty'] == 'hard') {
      return 3;
    } else if (questions[currentQuestion]['difficulty'] == 'medium') {
      return 2;
    }
    return 1;
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
    Timer.periodic(Duration(seconds: time), (Timer timer) {
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
    PutApi('ad-clicked/$id', {}, (res) {}).put(context);
    ExternalUrl().launchNewUrl(link);
  }

  void leaveRoomListenerMethod(players) {
    roomPlayers = players;
    youWon();
  }

  void initialFetch() async {
    userId = Provider.of<LocaleProvider>(context, listen: false)
        .user['_id']
        .toString();
    roomPlayers =
        Provider.of<LocaleProvider>(context, listen: false).room['players'];
    _socketMethods.timeDoneListener(context);
    _socketMethods.leaveRoomListener(context, leaveRoomListenerMethod);
    await getAdvertisments();
    getQuestions();
  }

  void playerTimeDone() {
    if (countDown == 0 && !playerTimeDoneCalled) {
      setState(() {
        playerTimeDoneCalled = true;
      });
      Map room = Provider.of<LocaleProvider>(context, listen: false).room;
      Map emittedData = {'userId': userId, 'roomId': room['_id']};
      _socketMethods.playerTimeDone(context, emittedData);
    }
  }

  bool youWon() {
    if (roomPlayers.length == 1 &&
        roomPlayers[0]['userId']['_id'].toString() == userId) {
      return true;
    }
    Map room = Provider.of<LocaleProvider>(context, listen: false).room;
    int maxPoints = 0;
    for (var player in room['players']) {
      if (player['points'] > maxPoints && player['userId']['_id'] != userId) {
        maxPoints = player['points'];
      }
    }
    if (points > maxPoints) return true;
    return false;
  }

  bool allPlayersTimeDone() {
    bool allTimeDone = true;
    Map room = Provider.of<LocaleProvider>(context, listen: false).room;
    for (var player in room['players']) {
      if (!player['timeDone'] && roomPlayers.length > 1) allTimeDone = false;
    }
    return allTimeDone;
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
    if (state == AppLifecycleState.inactive) {
    } else if (state == AppLifecycleState.paused) {
    } else if (state == AppLifecycleState.detached) {
      leaveRoom();
    }
  }

  void addHintAction() {
    List questionHints = questions[currentQuestion]['hints'];
    if (hints.length < questionHints.length) {
      List updatedHints = [...hints, questionHints[hints.length]];
      setState(() {
        hints = updatedHints;
      });
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

  bool isPlayerDone() {
    Map room = Provider.of<LocaleProvider>(context, listen: false).room;
    if (currentQuestion == room['questions'].length) {
      return true;
    }
    return false;
  }

  void leaveRoom() {
    Navigator.pushReplacementNamed(context, '/');
    Map room = Provider.of<LocaleProvider>(context, listen: false).room;
    roomPlayers = room['players'];
    roomPlayers = roomPlayers
        .where((player) => player['userId']['_id'] != userId)
        .toList();
    _socketMethods.leaveRoom(
        context, {'roomPlayers': roomPlayers, 'roomId': room['_id']});
  }

  @override
  Widget build(BuildContext context) {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        leaveRoom();
      },
      child: PagePlainContainer(
          body: ImageBackgroundPlain(
        image: user['selectedTheme'],
        body: allPlayersTimeDone()
            ? youWon()
                ? Center(
                    child: TextWidget(
                    title: 'YOU WON',
                    fontSize: 50,
                  ))
                : Center(
                    child: TextWidget(
                    title: 'YOU Lost',
                    fontSize: 50,
                  ))
            : playerTimeDoneCalled || isPlayerDone()
                ? const WaitingForOtherPlayers()
                : Stack(
                    children: [
                      const TwoPlayersStats(),
                      FadeTransitionContainer(
                        body: Container(
                          margin:
                              EdgeInsets.only(top: hints.length > 3 ? 32 : 0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                  title: countDown.toString(),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                const SizedBox(
                                  height: 4,
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
                                  isPlayerSearch: isPlayerSearch(),
                                  questionHintsLength:
                                      questions[currentQuestion]['hints']
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
                                  isMultipleChoices: isMultipleChoices(),
                                  action: choiceAction,
                                ),
                                TrueOrFalse(
                                  locale: locale,
                                  choices: questions[currentQuestion]
                                      ['choices'],
                                  isTrueOrFalse: isTrueOrFalse(),
                                  action: choiceAction,
                                ),
                                ReversedWords(
                                    isReversedWords: isReversedWords(),
                                    initiateAnswer: (answer) =>
                                        choiceAction(answer, 0),
                                    skipAction: skipAction,
                                    reversedWord: questions[currentQuestion]
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
