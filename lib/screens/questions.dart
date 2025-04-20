import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/event_details.dart';
import 'package:in_zone_app/screens/reversed_words.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/utilities/external_url.dart';
import 'package:in_zone_app/widgets/buttons/save_exit_button.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/containers/fade_transition.dart';
import 'package:in_zone_app/widgets/containers/image_background_plain.dart';
import 'package:in_zone_app/widgets/containers/modal_container.dart';
import 'package:in_zone_app/widgets/containers/page_plain_container.dart';
import 'package:in_zone_app/widgets/general_widgets/pause_and_play.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading.dart';
import 'package:in_zone_app/widgets/screens/questions/advertisment.dart';
import 'package:in_zone_app/widgets/screens/questions/countdown.dart';
import 'package:in_zone_app/widgets/screens/questions/game_over.dart';
import 'package:in_zone_app/widgets/screens/questions/multiple_choices.dart';
import 'package:in_zone_app/widgets/screens/questions/perks_illustrations.dart';
import 'package:in_zone_app/widgets/screens/questions/player_search.dart';
import 'package:in_zone_app/widgets/screens/questions/stats.dart';
import 'package:in_zone_app/widgets/screens/questions/theme_preview.dart';
import 'package:in_zone_app/widgets/screens/questions/true_or_false.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert'; // For utf8 encoding
import 'package:crypto/crypto.dart'; // For SHA-256

class Questions extends StatefulWidget {
  final String mode;
  final String questionMode;
  final String userId;
  final String name;
  final String eventId;
  final int price;
  final String themePreview;
  const Questions({
    super.key,
    this.mode = '',
    this.questionMode = '',
    this.userId = '',
    this.name = '',
    this.eventId = '',
    this.price = 0,
    this.themePreview = '',
  });

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
  int defaultCountDown = 20;
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
  bool playerTimeDoneCalled = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _mainGame = AudioPlayer();
  bool mainGameSoundPlaying = false;
  late ValueNotifier<int> _countDownNotifier;
  late ValueNotifier<int> _livesNotifier;
  late ValueNotifier<int> _pointsNotifier;
  late ValueNotifier<int> _coinsNotifier;
  late ValueNotifier<List> _hintsNotifier;

  // Methods
  Future<void> getQuestions() async {
    if (questions.isEmpty) {
      setState(() {
        pageLoading = true;
      });
    }
    await FetchApi(
        'questions?page=$currentPage&search=${widget.mode}&userId=${widget.userId}&name=${widget.name}&questionMode=${widget.questionMode}&price=${widget.price}',
        (res) {
      if (res['user'] != null) {
        Provider.of<LocaleProvider>(context, listen: false)
            .setUser(res['user']);
      }
      setState(() {
        questions = [...questions, ...res['questions']];
        pageLoading = false;
        nextPatchisLoaded = true;
      });
      if (res['questions'].length == 0) {
        currentPage = 1;
      }
      initializeCount();
      initializeHints();
    }, errorCallback: () {
      Navigator.pushReplacementNamed(context, '/');
    }).fetch(context);
  }

  void initializeCount() {
    if (!countStarted) {
      _countDownNotifier.value = setCount();
      decreaseCount();
      decreaseAdCount();
      countStarted = true;
    }
  }

  void initializeHints() {
    if (currentQuestion == 0 && _hintsNotifier.value.isEmpty && showHints()) {
      _hintsNotifier.value = [questions[currentQuestion]['hints'][0]];
    }
  }

  void decreaseCount() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!stopCount && _livesNotifier.value != 0) {
        if (_countDownNotifier.value > 0) {
          _countDownNotifier.value = _countDownNotifier.value - 1;
        } else {
          getToNextQuestion();
          if (_livesNotifier.value > 0) {
            playWrongSound();
            _livesNotifier.value = _livesNotifier.value - 1;
          }
          if (_pointsNotifier.value > 0) {
            _pointsNotifier.value = _pointsNotifier.value - 1;
          }
          if ((_pointsNotifier.value / numberOfPointsToCoin).floor() !=
              _coinsNotifier.value) {
            _coinsNotifier.value =
                (_pointsNotifier.value / numberOfPointsToCoin).floor();
          }
          _countDownNotifier.value = defaultCountDown;
        }
        if (_countDownNotifier.value < 6 && _countDownNotifier.value > -1) {
          playCountDownSound();
        }
      }
    });
  }

  void decreaseAdCount() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!stopAdCount && _livesNotifier.value != 0) {
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
    if (showHints()) {
      defaultCountDown = 45;
    } else if (stoppageTimeActive) {
      defaultCountDown = 10;
    } else if (isReversedWords()) {
      defaultCountDown = 30;
    } else {
      defaultCountDown = 20;
    }
    return defaultCountDown;
  }

  void getToNextQuestion() {
    if ((currentQuestion - 1) % 15 == 0 &&
        currentQuestion != 0 &&
        currentQuestion != 1 &&
        _livesNotifier.value != 1 &&
        _livesNotifier.value != 0 &&
        advertisments.isNotEmpty) {
      currentAdMethod();
    }
    if (currentQuestion == questions.length - 1) {
      currentQuestion = 0;
    }
    if (_hintsNotifier.value.isNotEmpty || showHints()) {
      _hintsNotifier.value = [];
    }
    setState(() {
      currentQuestion = currentQuestion + 1;
      _countDownNotifier.value = setCount();
    });
    if (questions[currentQuestion]['hints'] != null &&
        questions[currentQuestion]['hints'].length > 0) {
      _hintsNotifier.value = [questions[currentQuestion]['hints'][0]];
    }
  }

  void rightAnswerPoints() {
    if (isReversedWords()) {
      pointDefaultValue = 5;
    } else if (showHints()) {
      int hintsSubtract = questions[currentQuestion]['hints'].length -
          _hintsNotifier.value.length +
          1;
      pointDefaultValue = hintsSubtract > 3 ? 10 : 5;
    } else if (questions[currentQuestion]['difficulty'] == 'hard') {
      pointDefaultValue = 3;
    } else if (questions[currentQuestion]['difficulty'] == 'medium') {
      pointDefaultValue = 2;
    } else {
      pointDefaultValue = 1;
    }
    int newPoints = pointDefaultValue * pointValue * multiplyPoints;
    int newCoins = newPoints ~/ 5;
    _pointsNotifier.value += newPoints;
    _coinsNotifier.value += newCoins;
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

  void playMainGameSound() async {
    setState(() {
      mainGameSoundPlaying = true;
    });
    _mainGame.setVolume(0.45);
    _mainGame.play(AssetSource('audio/main_game.mp3'));
  }

  void rightAnswer() {
    playCorrectSound();
    rightAnswerPoints();
    getToNextQuestion();
    getNextPatchOfQuestions();
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
    if (_livesNotifier.value > 1 && !isPlayerSearch() && !isReversedWords()) {
      getToNextQuestion();
    }
    if (_pointsNotifier.value != 0 && !activateVar) {
      _pointsNotifier.value = _pointsNotifier.value - 1;
    }
    if (_livesNotifier.value != 0 && !activateVar) {
      _livesNotifier.value = _livesNotifier.value - 1;
      ;
    }
    if (_livesNotifier.value == 0) {
      setState(() {
        pageLoading = true;
      });
      return saveGame(false);
    }
    if (activateVar) {
      activateVar = false;
    }
  }

  void calculateCoins() {
    if ((_pointsNotifier.value / numberOfPointsToCoin).floor() !=
        _coinsNotifier.value) {
      _coinsNotifier.value =
          (_pointsNotifier.value / numberOfPointsToCoin).floor();
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
    if (isReversedWords() &&
        generateSHA256Hash(answer) ==
            questions[currentQuestion]['answer'][locale].toLowerCase()) {
      rightAnswer();
      return calculateCoins();
    }
    if (generateSHA256Hash(answer) == questions[currentQuestion]['answer']) {
      rightAnswer();
      return calculateCoins();
    }
    wrongAnswer(index);
    calculateCoins();
  }

  int showPointsValue() {
    if (isReversedWords()) {
      return 5;
    } else if (showHints()) {
      int hintsSubtract = questions[currentQuestion]['hints'].length -
          _hintsNotifier.value.length +
          1;
      return hintsSubtract > 3 ? 10 : 5;
    } else if (questions[currentQuestion]['difficulty'] == 'hard') {
      return 3;
    } else if (questions[currentQuestion]['difficulty'] == 'medium') {
      return 2;
    }
    return 1;
  }

  void navigationDestination() {
    if (widget.eventId != '') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/events'),
          builder: (context) => EventDetails(
            eventId: widget.eventId,
          ),
        ),
      );
    } else {
      Navigator.pushReplacementNamed(context, '/rankings');
    }
  }

  void saveGame(navigate) {
    stopCount = true;
    _audioPlayer.stop();
    if (_pointsNotifier.value == 0 && navigate) {
      _mainGame.stop();
      Navigator.pushReplacementNamed(context, '/rankings');
    } else {
      Map payload = {
        'points': _pointsNotifier.value,
        'coins': _coinsNotifier.value,
        'usedPerks': usedPerks,
        'eventId': widget.eventId
      };
      String userId =
          Provider.of<LocaleProvider>(context, listen: false).user['_id'];
      setState(() {
        saveLoading = true;
      });
      PostApi('user-save-game/$userId', payload, (res) {
        _mainGame.stop();
        gameSaved = true;
        Provider.of<LocaleProvider>(context, listen: false)
            .setUser(res['user']);
        if (navigate) {
          navigationDestination();
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
      Timer.periodic(const Duration(seconds: 15), (Timer timer) {
        stopCount = false;
        anyTimePerkActive = false;
      });
    }
  }

  void playAgain() {
    if (widget.questionMode != '') {
      LocaleProvider localeProvider =
          Provider.of<LocaleProvider>(context, listen: false);
      // ignore: void_checks
      return ModalContainer.choosePlayOptionModal(
          context, localeProvider, widget.questionMode);
    }
    stopCount = false;
    currentAd = 0;
    stoppageTimeActive = false;
    playMainGameSound();
    initializeHints();
    _livesNotifier.value = 10;
    _coinsNotifier.value = 0;
    _pointsNotifier.value = 0;
    setState(() {
      currentQuestion = currentQuestion + 1;
      usedPerks = [];
    });
  }

  void livesAction() {
    _livesNotifier.value += 1;
    stopCount = false;
    Future.delayed(const Duration(seconds: 5), () {
      stopCount = false;
    });
  }

  void exitGame() {
    Navigator.pushReplacementNamed(context, '/rankings');
  }

  void finishTutorialAction() {
    playMainGameSound();
    stopCount = false;
    setState(() {
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
    PutApi('ad-clicked/$id', {}, (res) {}).put(context);
    ExternalUrl().launchNewUrl(link);
  }

  void initialFetch() async {
    if (widget.themePreview == '') {
      await getAdvertisments();
      await getQuestions();
    } else {
      gameSaved = true;
    }
  }

  skipAdMethod() {
    if (currentAdCountDown == 0) {
      stopCount = false;
      setState(() {
        stopAdCount = true;
        showAd = false;
      });
    }
  }

  initializeNotifiers() {
    _countDownNotifier = ValueNotifier(defaultCountDown);
    _livesNotifier = ValueNotifier(10);
    _pointsNotifier = ValueNotifier(0);
    _coinsNotifier = ValueNotifier(0);
    _hintsNotifier = ValueNotifier([]);
  }

  @override
  void initState() {
    super.initState();
    initializeNotifiers();
    initialFetch();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _audioPlayer.dispose();
    _countDownNotifier.dispose();
    _livesNotifier.dispose();
    _pointsNotifier.dispose();
    _coinsNotifier.dispose();
    _hintsNotifier.dispose();
    _audioPlayer.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void stopGame() {
    stopCount = true;
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

  void addHintAction() {
    List questionHints = questions[currentQuestion]['hints'];
    if (_hintsNotifier.value.length < questionHints.length) {
      List updatedHints = [
        ..._hintsNotifier.value,
        questionHints[_hintsNotifier.value.length]
      ];
      _hintsNotifier.value = updatedHints;
    }
  }

  void skipAction() {
    wrongAnswer(0);
    getToNextQuestion();
    getNextPatchOfQuestions();
  }

  void deleteWord() {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    for (var element in questions[currentQuestion]['reversedAnswer'][locale]) {
      element['isChosen'] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (!gameSaved && !saveLoading) {
          saveGame(true);
        } else {
          navigationDestination();
        }
      },
      child: PagePlainContainer(
          body: ImageBackgroundPlain(
        image: widget.themePreview == ''
            ? user['selectedTheme']
            : widget.themePreview,
        body: widget.themePreview != ''
            ? const ThemePreview()
            : pageLoading ||
                    (questions.isNotEmpty && questions[currentQuestion] == null)
                ? const PrimaryLoading()
                : _livesNotifier.value == 0
                    ? GameOver(playAgain: playAgain, exitGame: exitGame)
                    : Stack(
                        children: [
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: SaveExitButton(
                              buttonText:
                                  AppLocalizations.of(context)!.saveAndClose,
                              radius: 100,
                              action: () => saveGame(true),
                              letterSpacing: 0,
                              fontSize: 13,
                              icon: Icons.save_alt,
                              loading: saveLoading,
                            ),
                          ),
                          Positioned(
                              bottom: 10,
                              left: 10,
                              child: PauseAndPlay(
                                  isPlaying: mainGameSoundPlaying,
                                  isSound: true,
                                  action: () {
                                    if (mainGameSoundPlaying) {
                                      _mainGame.pause();
                                      setState(() {
                                        mainGameSoundPlaying = false;
                                      });
                                    } else {
                                      playMainGameSound();
                                    }
                                  })),
                          Stats(
                            usedPerks: usedPerks,
                            user: user,
                            pointsNotifier: _pointsNotifier,
                            coinsNotifier: _coinsNotifier,
                            livesNotifier: _livesNotifier,
                            stopTime: stopTimeMethod,
                            penalty: penaltyMethod,
                            varMethod: varMethod,
                            stoppageTime: stoppageTimeMethod,
                            pointsMultiplicationMethod: multiplyPointsMethod,
                            skipQuestion: skipQuestionMethod,
                            locale: locale,
                          ),
                          FadeTransitionContainer(
                            body: Container(
                              margin: EdgeInsets.only(
                                  top:
                                      _hintsNotifier.value.length > 3 ? 32 : 0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CountDown(
                                        countDownNotifier: _countDownNotifier,
                                        defaultCountDown: defaultCountDown),
                                    const SizedBox(
                                      height: 8,
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
                                    ValueListenableBuilder<List>(
                                      valueListenable: _hintsNotifier,
                                      builder: (context, hints, _) {
                                        return PlayerSearch(
                                          locale: locale,
                                          isPlayerSearch: isPlayerSearch(),
                                          questionHintsLength:
                                              questions[currentQuestion]
                                                      ['hints']
                                                  .length,
                                          hints: hints,
                                          addHintAction: addHintAction,
                                          skipAction: skipAction,
                                          playerAction: choiceAction,
                                        );
                                      },
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
                                      advertisments[currentAd]
                                          ['directionLink']),
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
