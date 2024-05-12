import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/widgets/buttons/main_button.dart';
import 'package:flutter_challenge_mobile/widgets/containers/black_modal_container.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/text_widget.dart';
import 'package:flutter_challenge_mobile/widgets/screens/questions/single_perk_illustration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PerksIllustrations extends StatelessWidget {
  final Function action;
  PerksIllustrations({super.key, required this.action});

  final List<Map> helpingPerks = [
    {
      'image': 'assets/images/image90.png',
      'index': 0,
      'text': {
        'en':
            "ُEvery question has it's time cut in half but your correct answer points are doubled",
        'ar': "نقاط اجاباتك الصحيحة تتضاعف لكن كل سؤال وقته يقل للنصف"
      },
      'title': {'en': "+90", 'ar': "+90"}
    },
    {
      'image': 'assets/images/halfTime.png',
      'index': 1,
      'text': {
        'en': "ُYou can remove two answers in multiple choices questions",
        'ar': "تستطيع حذف اجابتين في اسئلة الاختيارات المتعددة"
      },
      'title': {'en': "Penalty", 'ar': "ضربة جزاء"}
    },
    {
      'image': 'assets/images/VAR.png',
      'index': 2,
      'text': {
        'en': "ُYour next incorrect answer will not affect your lives",
        'ar': "إجابتك الخاطئة التالية لن تؤثر على نقاط حياتك"
      },
      'title': {'en': "VAR", 'ar': "تقنية الفيديو"}
    },
    {
      'image': 'assets/images/stopTime.png',
      'index': 3,
      'text': {
        'en': "ُTime stops for 30 Seconds",
        'ar': "يتوقف الوقت 30 ثانية"
      },
      'title': {'en': "Extra Time", 'ar': "وقت اضافي"}
    },
  ];
  @override
  Widget build(BuildContext context) {
    return BlackModalContainer(
      body: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Theme.of(context).splashColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            TextWidget(
              title: AppLocalizations.of(context)!.helpingPerks.toUpperCase(),
              fontSize: 24,
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              children: helpingPerks
                  .map((perk) => SinglePerkIllustration(perk: perk))
                  .toList(),
            ),
            const SizedBox(height: 3,),
            MainButton(
                radius: 10,
                letterSpacing: 0.8,
                buttonText: AppLocalizations.of(context)!.finishTut,
                action: action)
          ],
        ),
      ),
    );
  }
}
