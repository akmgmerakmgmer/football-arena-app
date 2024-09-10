import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/questions.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Challenge extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String mode;
  const Challenge({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.mode,
  });

  bool isPlayedToday(context) {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    if (user.isNotEmpty && user.containsKey('username')) {
      List currentChallenge = user['challenges']
          .where((challenge) => challenge['id'] == mode)
          .toList();
      if (currentChallenge.isNotEmpty &&
          currentChallenge[0]['id'] == mode &&
          currentChallenge[0]['lastPlayedDate'] == formattedDate) {
        return true;
      }
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.cover)),
              width: 225,
              height: 420,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: 225,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
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
                      title: title.toUpperCase(),
                      fontSize: 15,
                      textAlign: TextAlign.center,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    TextWidget(
                      title: description,
                      fontSize: 16,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: MainButton(
                          disabled: isPlayedToday(context),
                          buttonText: isPlayedToday(context)
                              ? AppLocalizations.of(context)!.alreadyPlayedOnce
                              : AppLocalizations.of(context)!.playNow,
                          fontSize: 12.5,
                          uppercase: true,
                          letterSpacing: 1.1,
                          isChallengesPage: true,
                          radius: 10,
                          action: () {
                            if (isPlayedToday(context)) {
                              return;
                            }
                            if (Provider.of<LocaleProvider>(context,
                                    listen: false)
                                .user
                                .containsKey('username')) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Questions(
                                    mode: mode,
                                    name: title,
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
