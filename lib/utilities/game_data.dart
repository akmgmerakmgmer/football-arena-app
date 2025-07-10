class GameData {
  static const List modes = [
    {
      "en": "All in One",
      "ar": "الكل في واحد",
      "image": "assets/images/all_in_one.jpg",
      "descriptionEn":
          "A mix of all game modes—multiple choice, true or false, guess the player, password challenge, and reversed words.",
      "descriptionAr":
          "مزيج من جميع الاسئلة: الاختيارات المتعددة صح أو غلط خمن اللاعب، كلمة السر والكلمات المعكوسة.",
      "value": ""
    },
    {
      "en": "Multiple Choices",
      "ar": "الاختيارات المتعددة",
      "image": "assets/images/multiple_choices.jpg",
      "descriptionEn":
          "Football questions by choosing one of four options, earning points for correct answers.",
      "descriptionAr":
          "يختار اللاعب إجابة واحدة من بين أربع خيارات ويحصل على نقاط للإجابات الصحيحة.",
      "value": "multipleChoices"
    },
    {
      "en": "True or False",
      "ar": "صح أو غلط",
      "image": "assets/images/true_or_false.jpg",
      "descriptionEn":
          "Decide if each football statement is true or false to score points.",
      "descriptionAr":
          "يقرر اللاعب إذا كانت كل جملة عن كرة القدم صواب أو خطأ لكسب النقاط.",
      "value": "trueOrFalse"
    },
    {
      "en": "Guess the Player",
      "ar": "خمن اللاعب",
      "image": "assets/images/guess_the_player.jpg",
      "descriptionEn":
          "Identify the player based on hints or partial information.",
      "descriptionAr": "يحدد اسم اللاعب بناءً على تلميحات أو معلومات جزئية.",
      "value": "guessThePlayer"
    },
    {
      "en": "Password Challenge",
      "ar": "كلمة السر",
      "image": "assets/images/password_challenge.jpg",
      "descriptionEn": "Identify the player based on one word hints.",
      "descriptionAr": "يحدد اسم اللاعب بناءً على تلميحات من كلمة واحدة.",
      "value": "passwordChallenge"
    },
    {
      "en": "Reversed Words",
      "ar": "الكلمات المعكوسة",
      "image": "assets/images/reversed_words.jpg",
      "descriptionEn":
          "Guess the football manager or player name with the letters reversed.",
      "descriptionAr":
          "يخمن اسم اللاعب او المدرب من الحروف الموجودة لكسب النقاط.",
      "value": "reversedWords"
    }
  ];
  static const numberOfPlayersAvailable = [2, 3, 4, 5, 6, 7, 8];
  static const List gameDuration = [
    {"en": "1.5 minutes", "ar": "دقيقة ونصف", "value": 90},
    {"en": "2 minutes", "ar": "دقيقتان", "value": 120},
    {"en": "2.5 minutes", "ar": "دقيقتان ونصف", "value": 150},
    {"en": "3 minutes", "ar": "3 دقائق", "value": 180},
    {"en": "3.5 minutes", "ar": "3 دقائق ونصف", "value": 210},
    {"en": "4 minutes", "ar": "4 دقائق", "value": 240},
    {"en": "4.5 minutes", "ar": "4 دقائق ونصف", "value": 270},
    {"en": "5 minutes", "ar": "5 دقائق", "value": 300},
  ];
}
