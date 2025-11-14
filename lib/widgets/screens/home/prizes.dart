import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/containers/grid_container.dart';
import 'package:in_zone_app/widgets/containers/home_section_containers.dart';
import 'package:in_zone_app/widgets/general_widgets/descriptions.dart';
import 'package:in_zone_app/widgets/general_widgets/titles.dart';
import 'package:in_zone_app/widgets/screens/home/single_prize.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Prizes extends StatelessWidget {
  Prizes({super.key});
  List<Map> prizes = [
    {
      'title': 'Weekly Prize',
      'titleAr': "الجائزة الأسبوعية",
      'description':
          "Every week, seize the chance to win 2000 EGP – no strings attached. Use the extra cash for a spontaneous treat or boost your savings. Stay tuned for our weekly updates to see if luck favors you.",
      'descriptionAr':
          "كل أسبوع ، استغل الفرصة للفوز ب 2000 جنيه مصري حسب عدد نقاطك في اللعبة. ترقبوا تحديثاتنا الأسبوعية لمعرفة ما إذا كان الحظ في صالحك."
    },
    // {
    //   'title': 'Monthly Prize',
    //   'titleAr': "الجائزة الشهرية",
    //   'description':
    //       "Secure your shot at 5000 EGP every month – no strings attached. Whether you're eyeing a spontaneous treat or aiming to bolster your savings, it's up to you. Stay tuned for our monthly updates, and find out if fortune favors you. Don't miss the chance to claim the 5000 EGP prize – enter now and let the monthly excitement unfold!",
    //   'descriptionAr':
    //       "نافس على فرصتك ب 5000 جنيه مصري كل شهر - بدون قيود. سواء كنت تتطلع إلى علاج عفوي أو تهدف إلى تعزيز مدخراتك ، فالأمر متروك لك. ترقبوا تحديثاتنا الشهرية ، واكتشف ما إذا كانت الثروة تفضلك. لا تفوت فرصة الحصول على جائزة 5000 جنيه مصري - ادخل الآن ودع الإثارة الشهرية تتكشف!"
    // },
    // {
    //   'title': 'Half-Year Jackpot',
    //   'titleAr': "الجائزة الكبرى نصف السنوية",
    //   'description':
    //       "Lock in your chance at a 10,000 EGP Half-Year Jackpot – no strings attached. Whether you fancy a spontaneous treat or aim to beef up your savings, the choice is yours. Stay tuned for our biannual updates, and discover if luck is on your side. Don't miss out on the opportunity to snag the 10,000 EGP prize – enter now and get ready for the thrill of the Half-Year Jackpot!",
    //   'descriptionAr':
    //       "نافس على فرصتك في الفوز بالجائزة الكبرى نصف السنوية بقيمة 10,000 جنيه مصري - بدون قيود. سواء كنت ترغب في علاج عفوي أو تهدف إلى زيادة مدخراتك ، فالخيار لك. ترقبوا تحديثاتنا نصف السنوية ، واكتشف ما إذا كان الحظ في صفك. لا تفوت فرصة الحصول على جائزة 10,000 جنيه مصري - ادخل الآن واستعد لإثارة الجائزة الكبرى نصف السنوية!"
    // },
    // {
    //   'title': 'Yearly Grand Prize',
    //   'titleAr': "الجائزة السنوية الكبرى",
    //   'description':
    //       "Seize the opportunity for a 15,000 EGP Yearly Grand Prize – no strings attached. Whether you're up for a spontaneous treat or keen on boosting your savings, it's entirely your call. Stay tuned for our yearly updates, and find out if fortune favors you. Don't miss your shot at claiming the 15,000 EGP prize – enter now and gear up for the excitement of the Yearly Grand Prize!",
    //   'descriptionAr':
    //       "اغتنم الفرصة للحصول على جائزة كبرى سنوية بقيمة 15,000 جنيه مصري - بدون قيود. سواء كنت ترغب في الحصول على علاج عفوي أو حريص على زيادة مدخراتك ، فهذه هي دعوتك بالكامل. ترقبوا تحديثاتنا السنوية ، واكتشف ما إذا كان الحظ يفضلك أم لا. لا تفوت فرصتك في الحصول على جائزة 15,000 جنيه مصري - ادخل الآن واستعد لإثارة الجائزة السنوية الكبرى!"
    // },
    {
      'title': 'Special Prizes',
      'titleAr': "الجوائز الاستثنائية",
      'description':
          "Dive into a year of excitement with our special and surprising prizes, sprinkled throughout the seasons. Brace yourself for unexpected rewards that will keep you delighted and engaged. From exclusive bonuses to unique treats, these surprises are our way of making every moment a celebration. Stay connected and be ready for the joy that awaits you throughout the year!",
      'descriptionAr':
          "انغمس في عام من الإثارة مع جوائزنا الخاصة والمدهشة ، المنتشرة طوال المواسم. استعد لمكافآت غير متوقعة ستبقيك سعيدا ومشاركا. من المكافآت الحصرية إلى المكافآت الفريدة ، هذه المفاجآت هي طريقتنا لجعل كل لحظة احتفالا. ابق على اتصال وكن مستعدا للفرح الذي ينتظرك طوال العام!"
    },
    {
      'title': 'Special Perks Coins',
      'titleAr': "عملات الامتيازات الخاصة",
      'description':
          "Unlock exclusive advantages with our Special Perks Coins! Acquire these coins to enjoy unique in-game benefits – no complications. Whether you're seeking a gameplay advantage or aiming to level up faster, the choice is yours. Collect Special Perks Coins as you play and enhance your gaming experience. Stay tuned for updates on new perks and maximize your enjoyment in the game. Dive in now and elevate your gaming with the power of Special Perks Coins!",
      'descriptionAr':
          "افتح المزايا الحصرية مع عملات الامتيازات الخاصة بنا! احصل على هذه العملات المعدنية للاستمتاع بمزايا فريدة داخل اللعبة - بدون تعقيدات. سواء كنت تبحث عن ميزة اللعب أو تهدف إلى رفع المستوى بشكل أسرع ، فإن الخيار لك. اجمع عملات الامتيازات الخاصة أثناء اللعب وعزز تجربة اللعب الخاصة بك. ترقبوا التحديثات حول الامتيازات الجديدة وحقق أقصى قدر من المتعة في اللعبة. انغمس الآن وارفع مستوى ألعابك بقوة عملات الامتيازات الخاصة!"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return HomeSectionContainers(children: [
      Titles(title: AppLocalizations.of(context)!.prizes),
      const SizedBox(
        height: 16,
      ),
      Descriptions(desc: AppLocalizations.of(context)!.prizesDesc),
      const SizedBox(
        height: 16,
      ),
      const SizedBox(
        height: 16,
      ),
      GridContainer(
          widget: prizes
              .map((prize) => SinglePrize(
                    title: Provider.of<LocaleProvider>(context, listen: false)
                                .locale ==
                            'ar'
                        ? prize['titleAr']
                        : prize['title'],
                    desc: Provider.of<LocaleProvider>(context, listen: false)
                                .locale ==
                            'ar'
                        ? prize['descriptionAr']
                        : prize['description'],
                  ))
              .toList())
    ]);
  }
}
