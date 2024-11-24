import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/widgets/screens/home/single_mode.dart';

class QuestionMods extends StatelessWidget {
  const QuestionMods({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List modes = [
      {
        "en": "All in One",
        "ar": "الكل في واحد",
        "image": "assets/images/all_in_one.jpg",
        "descriptionEn":
            "A mix of all game modes—multiple choice, true or false, guess the player, password challenge, and reversed words.",
        "descriptionAr":
            "مزيج من جميع الاسئلة: الاختيارات المتعددة صح أو غلط خمن اللاعب، كلمة السر والكلمات المعكوسة.",
        "mode": ""
      },
      {
        "en": "Multiple Choices",
        "ar": "الاختيارات المتعددة",
        "image": "assets/images/multiple_choices.jpg",
        "descriptionEn":
            "Football questions by choosing one of four options, earning points for correct answers.",
        "descriptionAr":
            "يختار اللاعب إجابة واحدة من بين أربع خيارات ويحصل على نقاط للإجابات الصحيحة.",
        "mode": "multipleChoices"
      },
      {
        "en": "True or False",
        "ar": "صح أو غلط",
        "image": "assets/images/true_or_false.jpg",
        "descriptionEn":
            "Decide if each football statement is true or false to score points.",
        "descriptionAr":
            "يقرر اللاعب إذا كانت كل جملة عن كرة القدم صواب أو خطأ لكسب النقاط.",
        "mode": "trueOrFalse"
      },
      {
        "en": "Guess the Player",
        "ar": "خمن اللاعب",
        "image": "assets/images/guess_the_player.jpg",
        "descriptionEn":
            "Identify the player based on hints or partial information.",
        "descriptionAr": "يحدد اسم اللاعب بناءً على تلميحات أو معلومات جزئية.",
        "mode": "guessThePlayer"
      },
      {
        "en": "Password Challenge",
        "ar": "كلمة السر",
        "image": "assets/images/password_challenge.jpg",
        "descriptionEn": "Identify the player based on one word hints.",
        "descriptionAr": "يحدد اسم اللاعب بناءً على تلميحات من كلمة واحدة.",
        "mode": "passwordChallenge"
      },
      {
        "en": "Reversed Words",
        "ar": "الكلمات المعكوسة",
        "image": "assets/images/reversed_words.jpg",
        "descriptionEn":
            "Guess the football manager or player name with the letters reversed.",
        "descriptionAr":
            "يخمن اسم اللاعب او المدرب من الحروف الموجودة لكسب النقاط.",
        "mode": "reversedWords"
      }
    ];

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 4,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  modes.map((mode) => SingleMode(singleMode: mode)).toList(),
            ),
          )
        ],
      ),
    );
  }
}
