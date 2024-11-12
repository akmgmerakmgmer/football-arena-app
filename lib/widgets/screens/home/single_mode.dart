import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/questions.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SingleMode extends StatelessWidget {
  final Map singleMode;
  const SingleMode({
    super.key,
    required this.singleMode,
  });

  @override
  Widget build(BuildContext context) {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    return Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(singleMode['image']),
              )),
              width: 225,
              height: 420,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: 225,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.85),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWidget(
                      title:
                          locale == 'ar' ? singleMode['ar'] : singleMode['en'],
                      fontSize: 15,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    TextWidget(
                      title: locale == 'ar'
                          ? singleMode['descriptionAr']
                          : singleMode['descriptionEn'],
                      fontSize: 13,
                      textAlign: TextAlign.center,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: MainButton(
                          buttonText: AppLocalizations.of(context)!.playNow,
                          fontSize: 12.5,
                          uppercase: true,
                          letterSpacing: 1.1,
                          isChallengesPage: true,
                          radius: 10,
                          action: () {
                            if (Provider.of<LocaleProvider>(context,
                                    listen: false)
                                .user
                                .containsKey('username')) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Questions(
                                    questionMode: singleMode['mode'],
                                    userId: Provider.of<LocaleProvider>(context,
                                            listen: false)
                                        .user['_id'],
                                  ),
                                ),
                              );
                            } else {
                              Navigator.pushNamed(context, '/login');
                            }
                          }),
                    )
                  ],
                ),
              )),
        ),
        const SizedBox(
          width: 24,
        )
      ],
    );
  }
}
