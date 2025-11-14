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
import 'package:in_zone_app/widgets/general_widgets/buzzer_button.dart';
import 'package:in_zone_app/widgets/general_widgets/pause_and_play.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading.dart';
import 'package:in_zone_app/widgets/screens/questions/advertisment.dart';
import 'package:in_zone_app/widgets/screens/questions/bank_and_current_score.dart';
import 'package:in_zone_app/widgets/screens/questions/countdown.dart';
import 'package:in_zone_app/widgets/screens/questions/event_score.dart';
import 'package:in_zone_app/widgets/screens/questions/game_over.dart';
import 'package:in_zone_app/widgets/screens/questions/multiple_choices.dart';
import 'package:in_zone_app/widgets/screens/questions/perks_illustrations.dart';
import 'package:in_zone_app/widgets/screens/questions/player_search.dart';
import 'package:in_zone_app/widgets/screens/questions/stats.dart';
import 'package:in_zone_app/widgets/screens/questions/theme_preview.dart';
import 'package:in_zone_app/widgets/screens/questions/true_or_false.dart';
import 'package:in_zone_app/widgets/screens/questions/answer_flash_animation.dart';
import 'package:in_zone_app/widgets/screens/questions/session_stats_screen.dart';
import 'package:in_zone_app/widgets/general_widgets/streak_counter.dart';
import 'package:in_zone_app/widgets/general_widgets/speed_bonus_indicator.dart';
import 'package:provider/provider.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'dart:convert'; // For utf8 encoding
import 'package:crypto/crypto.dart'; // For SHA-256

class Questions extends StatefulWidget {
  final String mode;
  final String questionMode;
  final String userId;
  final String name;
  final String eventId;
  final String eventName;
  final int price;
  final String themePreview;
  final String eventTheme;
  final bool isSinglePlayerEvent;
  const Questions(
      {super.key,
      this.mode = '',
      this.questionMode = '',
      this.userId = '',
      this.name = '',
      this.eventId = '',
      this.price = 0,
      this.themePreview = '',
      this.eventName = '',
      this.eventTheme = '',
      this.isSinglePlayerEvent = false});

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
  late bool isOneShot;
  late bool isRush;
  late bool isBank;
  late bool isLightningRound;
  bool showBankBuzzer = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _mainGame = AudioPlayer();
  bool mainGameSoundPlaying = false;
  late ValueNotifier<int> _countDownNotifier;
  late ValueNotifier<int> _livesNotifier;
  late ValueNotifier<int> _pointsNotifier;
  late ValueNotifier<int> _bankScoreNotifier;
  late ValueNotifier<int> _coinsNotifier;
  late ValueNotifier<List> _hintsNotifier;
  
  // Engagement tracking variables
  int currentStreak = 0;
  int bestStreak = 0;
  int totalCorrectAnswers = 0;
  int totalWrongAnswers = 0;
  int totalSpeedBonuses = 0;
  List<double> answerSpeeds = [];
  DateTime? questionStartTime;
  bool showAnswerFlash = false;
  bool isCorrectFlash = false;
  bool showSessionStats = false;
  OverlayEntry? speedBonusOverlay;
  late ValueNotifier<int> _streakNotifier;

  // Methods
  Future<void> getQuestions() async {
    if (questions.isEmpty) {
      setState(() {
        pageLoading = true;
      });
    }
    await FetchApi(
        'questions?page=$currentPage&search=${widget.mode}&userId=${widget.userId}&name=${widget.name}&questionMode=${widget.questionMode}&price=${widget.price}&isSinglePlayerEvent=${widget.isSinglePlayerEvent}',
        (res) {
      if (res['user'] != null) {
        Provider.of<LocaleProvider>(context, listen: false)
            .setUser(res['user']);
      }
      if (mounted) {
        setState(() {
          questions = [...questions, ...res['questions']];
          pageLoading = false;
          nextPatchisLoaded = true;
        });
      }
      if (res['questions'].isEmpty) {
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
          if (isRush || isLightningRound) {
            saveGame(true);
          } else {
            getToNextQuestion();
            if (_livesNotifier.value > 0) {
              playWrongSound();
              _livesNotifier.value = _livesNotifier.value - 1;
              // Show session stats when lives reach 0
              if (_livesNotifier.value == 0) {
                setState(() {
                  showSessionStats = true;
                });
              }
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
        }
        if (_countDownNotifier.value < 6 &&
            _countDownNotifier.value > -1 &&
            !stopCount) {
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
    if (questions.length - currentQuestion <= 7 &&
        nextPatchisLoaded &&
        !isBank) {
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
    if (isLightningRound) {
      defaultCountDown = 30;
    } else if (isRush) {
      defaultCountDown = 60;
    } else if (showHints()) {
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
      if (isBank) {
        return saveGame(true);
      } else {
        currentQuestion = 0;
      }
    }
    if (_hintsNotifier.value.isNotEmpty || showHints()) {
      _hintsNotifier.value = [];
    }
    setState(() {
      currentQuestion = currentQuestion + 1;
      if (!widget.isSinglePlayerEvent) {
        _countDownNotifier.value = setCount();
      }
      // Start timing for speed bonus tracking
      questionStartTime = DateTime.now();
    });
    if (questions[currentQuestion]['hints'] != null &&
        questions[currentQuestion]['hints'].length > 0) {
      _hintsNotifier.value = [questions[currentQuestion]['hints'][0]];
    }
  }

  void pointValue() {}

  void rightAnswerPoints() {
    if (isOneShot || isBank) {
      pointDefaultValue = 1;
    } else if (isReversedWords()) {
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
    if (!widget.isSinglePlayerEvent) {
      int newPoints = pointDefaultValue * multiplyPoints;
      int newCoins = newPoints ~/ 5;
      _coinsNotifier.value += newCoins;
      _pointsNotifier.value += newPoints;
    } else {
      if (!isBank) {
        int newPoints = pointDefaultValue * multiplyPoints;
        _pointsNotifier.value += newPoints;
      } else {
        if (_bankScoreNotifier.value == 0) {
          _bankScoreNotifier.value = 1;
        } else {
          _bankScoreNotifier.value = _bankScoreNotifier.value * 2;
        }
      }
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

  void showSpeedBonus(double bonusMultiplier) {
    speedBonusOverlay?.remove();
    speedBonusOverlay = OverlayEntry(
      builder: (context) => SpeedBonusIndicator(
        bonusMultiplier: bonusMultiplier,
        onComplete: () {
          speedBonusOverlay?.remove();
          speedBonusOverlay = null;
        },
      ),
    );
    Overlay.of(context).insert(speedBonusOverlay!);
  }

  String chooseAudio() {
    if (isRush) {
      return 'audio/rush_audio.mp3';
    } else if (isOneShot) {
      return 'audio/one_shot_audio.mp3';
    } else if (isBank) {
      return 'audio/bank_audio.mp3';
    } else if (isLightningRound) {
      return 'audio/lightning_round_audio.mp3';
    } else {
      return 'audio/main_game.mp3';
    }
  }

  void playMainGameSound() async {
    setState(() {
      mainGameSoundPlaying = true;
    });
    _mainGame.setVolume(0.45);
    await _mainGame.setReleaseMode(ReleaseMode.loop);
    _mainGame.play(AssetSource(chooseAudio()));
  }

  void bankBuzzerAction() {
    if (_bankScoreNotifier.value > 0) {
      _pointsNotifier.value += _bankScoreNotifier.value;
      _bankScoreNotifier.value = 0;
    }
    setState(() {
      showBankBuzzer = false;
    });
  }

  void rightAnswer() {
    playCorrectSound();
    bankTrigger();
    lightningRoundTrigger(true);
    
    // Track engagement metrics
    totalCorrectAnswers++;
    currentStreak++;
    if (currentStreak > bestStreak) {
      bestStreak = currentStreak;
    }
    _streakNotifier.value = currentStreak;
    
    // Track answer speed (speed bonus indicator disabled)
    if (questionStartTime != null) {
      final answerTime = DateTime.now().difference(questionStartTime!).inMilliseconds / 1000.0;
      answerSpeeds.add(answerTime);
      
      if (answerTime < 5.0) {
        totalSpeedBonuses++;
        // Speed bonus indicator removed per user request
        // final bonusMultiplier = answerTime < 3.0 ? 1.5 : 1.25;
        // showSpeedBonus(bonusMultiplier);
      }
    }
    
    // Show answer flash animation
    setState(() {
      showAnswerFlash = true;
      isCorrectFlash = true;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          showAnswerFlash = false;
        });
      }
    });
    
    rightAnswerPoints();
    if (isBank) {
      Future.delayed(const Duration(milliseconds: 500), () {
        getToNextQuestion();
      });
    } else {
      getToNextQuestion();
    }
    getNextPatchOfQuestions();
  }

  void bankTrigger() {
    if (isBank) {
      setState(() {
        showBankBuzzer = true;
      });
    }
  }

  void lightningRoundTrigger(rightAnswer) {
    if (isLightningRound) {
      if (rightAnswer) {
        _countDownNotifier.value += 5;
      }
      if (!rightAnswer && _countDownNotifier.value > 6) {
        _countDownNotifier.value -= 5;
      }
    }
  }

  void bankWrongAnswer() {
    playWrongSound();
    if (_bankScoreNotifier.value > 0) {
      _bankScoreNotifier.value = 0;
    }
  }

  void wrongAnswer(index) {
    lightningRoundTrigger(false);
    
    // Track engagement metrics
    totalWrongAnswers++;
    currentStreak = 0;
    _streakNotifier.value = 0;
    
    // Track answer time
    if (questionStartTime != null) {
      final answerTime = DateTime.now().difference(questionStartTime!).inMilliseconds / 1000.0;
      answerSpeeds.add(answerTime);
    }
    
    // Show answer flash animation
    setState(() {
      showAnswerFlash = true;
      isCorrectFlash = false;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          showAnswerFlash = false;
        });
      }
    });
    
    if (isBank) {
      bankWrongAnswer();
      getToNextQuestion();
      return;
    }
    if (!isBank) {
      getNextPatchOfQuestions();
    }
    if (isOneShot) {
      return saveGame(true);
    }
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
    if (_livesNotifier.value != 0 &&
        !activateVar &&
        !isRush &&
        !isBank &&
        !isLightningRound) {
      _livesNotifier.value = _livesNotifier.value - 1;
    }
    if (_livesNotifier.value == 0) {
      setState(() {
        showSessionStats = true;
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
    if (widget.isSinglePlayerEvent) {
      setState(() {
        pageLoading = true;
      });
    }
    if (isBank) {
      _pointsNotifier.value += _bankScoreNotifier.value;
    }
    stopCount = true;
    _audioPlayer.stop();
    if (_pointsNotifier.value == 0 && navigate) {
      _mainGame.stop();
      navigationDestination();
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
      if (mounted) {
        setState(() {
          advertisments = res['advertisments'];
        });
      }
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
    _bankScoreNotifier = ValueNotifier(0);
    _coinsNotifier = ValueNotifier(0);
    _hintsNotifier = ValueNotifier([]);
    _streakNotifier = ValueNotifier(0);
  }

  void initializeEventValues() {
    isOneShot = widget.eventName.toLowerCase() == 'one shot';
    isRush = widget.eventName.toLowerCase() == 'rush';
    isBank = widget.eventName.toLowerCase() == 'bank';
    isLightningRound = widget.eventName.toLowerCase() == 'lightning round';
  }

  void isSinglePlayerEvent() {
    if (widget.isSinglePlayerEvent) {
      playMainGameSound();
      if (isRush || isLightningRound) {
        stopCount = false;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initializeEventValues();
    initializeNotifiers();
    initialFetch();
    isSinglePlayerEvent();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    _countDownNotifier.dispose();
    _livesNotifier.dispose();
    _pointsNotifier.dispose();
    _coinsNotifier.dispose();
    _hintsNotifier.dispose();
    _streakNotifier.dispose();
    speedBonusOverlay?.remove();
    _mainGame.dispose();
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
    if (state == AppLifecycleState.inactive) {
    } else if (state == AppLifecycleState.paused && gameSaved == false) {
      saveGame(true);
      gameSaved = true;
    } else if (state == AppLifecycleState.detached && gameSaved == false) {
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
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final locale = localeProvider.locale;
    final user = localeProvider.user;
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (!gameSaved &&
            !saveLoading &&
            _pointsNotifier.value > 0 &&
            !isRush &&
            !isOneShot) {
          saveGame(true);
        } else {
          navigationDestination();
        }
      },
      child: PagePlainContainer(
          body: ImageBackgroundPlain(
        image: widget.eventTheme != ''
            ? widget.eventTheme
            : widget.themePreview == ''
                ? user['selectedTheme']
                : widget.themePreview,
        body: widget.themePreview != ''
            ? const ThemePreview()
            : pageLoading ||
                    (questions.isNotEmpty && questions[currentQuestion] == null)
                ? const PrimaryLoading()
                : _livesNotifier.value == 0
                    ? (showSessionStats 
                        ? SessionStatsScreen(
                            stats: SessionStats(
                              totalQuestions: totalCorrectAnswers + totalWrongAnswers,
                              correctAnswers: totalCorrectAnswers,
                              wrongAnswers: totalWrongAnswers,
                              bestStreak: bestStreak,
                              averageSpeed: answerSpeeds.isEmpty 
                                  ? 0.0 
                                  : answerSpeeds.reduce((a, b) => a + b) / answerSpeeds.length,
                              totalPoints: _pointsNotifier.value,
                              speedBonuses: totalSpeedBonuses,
                            ),
                            onContinue: () {
                              setState(() {
                                showSessionStats = false;
                              });
                            },
                            gameMode: widget.eventName.isEmpty ? 'Practice Mode' : widget.eventName,
                          )
                        : GameOver(playAgain: playAgain, exitGame: exitGame))
                    : Stack(
                        children: [
                          isRush && isOneShot
                              ? Container()
                              : Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: SaveExitButton(
                                    buttonText: AppLocalizations.of(context)!
                                        .saveAndClose,
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
                          widget.isSinglePlayerEvent
                              ? isBank
                                  ? BankAndCurrentScore(
                                      bankScoreNotifier: _bankScoreNotifier,
                                      currentScoreNotifier: _pointsNotifier,
                                      eventName: widget.eventName,
                                    )
                                  : EventScore(
                                      scoreNotifier: _pointsNotifier,
                                      eventName: widget.eventName,
                                    )
                              : Stats(
                                  usedPerks: usedPerks,
                                  user: user,
                                  pointsNotifier: _pointsNotifier,
                                  coinsNotifier: _coinsNotifier,
                                  livesNotifier: _livesNotifier,
                                  stopTime: stopTimeMethod,
                                  penalty: penaltyMethod,
                                  varMethod: varMethod,
                                  stoppageTime: stoppageTimeMethod,
                                  pointsMultiplicationMethod:
                                      multiplyPointsMethod,
                                  skipQuestion: skipQuestionMethod,
                                  locale: locale,
                                ),
                          // Streak counter
                          Positioned(
                            top: widget.isSinglePlayerEvent ? 80 : 180,
                            right: 20,
                            child: ValueListenableBuilder<int>(
                              valueListenable: _streakNotifier,
                              builder: (context, streak, child) {
                                return StreakCounter(streak: streak);
                              },
                            ),
                          ),
                          // Answer flash animation
                          if (showAnswerFlash)
                            AnswerFlashAnimation(
                              isCorrect: isCorrectFlash,
                              onComplete: () {
                                setState(() {
                                  showAnswerFlash = false;
                                });
                              },
                            ),
                          FadeTransitionContainer(
                            isVisible: !showBankBuzzer,
                            body: Container(
                              margin: EdgeInsets.only(
                                  top:
                                      _hintsNotifier.value.length > 3 ? 32 : 0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    widget.isSinglePlayerEvent &&
                                            !isRush &&
                                            !isLightningRound
                                        ? Container()
                                        : CountDown(
                                            countDownNotifier:
                                                _countDownNotifier,
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
                                                ? '${questions[currentQuestion]['question']['ar']} ${!isOneShot && !isBank ? '(${showPointsValue()} ${AppLocalizations.of(context)!.points})' : ''}'
                                                : '${questions[currentQuestion]['question']['en']} ${!isOneShot && !isBank ? '(${showPointsValue()} ${AppLocalizations.of(context)!.points})' : ''}',
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
                                      enableFeedback: false,
                                    ),
                                    TrueOrFalse(
                                      locale: locale,
                                      choices: questions[currentQuestion]
                                          ['choices'],
                                      isTrueOrFalse: isTrueOrFalse(),
                                      action: choiceAction,
                                      enableFeedback: false,
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
                                        deleteWord: deleteWord),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          showTut && !widget.isSinglePlayerEvent
                              ? PerksIllustrations(
                                  action: finishTutorialAction,
                                  user: localeProvider.user,
                                )
                              : const SizedBox.shrink(),
                          showBankBuzzer
                              ? Center(
                                  child: BuzzerButton(
                                      hideBuzzer: () {
                                        setState(() {
                                          showBankBuzzer = false;
                                        });
                                      },
                                      onPressed: bankBuzzerAction))
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
                              : const SizedBox.shrink(),
                        ],
                      ),
      )),
    );
  }
}
