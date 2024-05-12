import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/providers/locale_provider.dart';
import 'package:flutter_challenge_mobile/utilities/api_methods.dart';
import 'package:flutter_challenge_mobile/widgets/buttons/main_button.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SingleChallenge extends StatefulWidget {
  final String image;
  final String title;
  final String challengeValue;
  const SingleChallenge({
    super.key,
    required this.image,
    required this.title,
    required this.challengeValue,
  });

  @override
  State<SingleChallenge> createState() => _SingleChallengeState();
}

class _SingleChallengeState extends State<SingleChallenge> {
  bool loading = false;

  Future<void> notifyMe() async {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    if (!user.containsKey('username')) {
      Navigator.pushNamed(context, '/login');
    } else {
      int index = user['notifyAbout']
          .indexWhere((element) => element == widget.challengeValue);
      if (index == -1) {
        setState(() {
          loading = true;
        });
        PutApi('notify-about/${user['_id']}', {'mode': widget.challengeValue},
            (user) {
          Provider.of<LocaleProvider>(context, listen: false).setUser(user);
          setState(() {
            loading = false;
          });
        }).put(context);
      }
    }
  }

  String buttonName() {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    if (!user.containsKey('username') || !user.containsKey('notifyAbout')) {
      return AppLocalizations.of(context)!.notifyMe;
    }
    int index = user['notifyAbout']
        .indexWhere((element) => element == widget.challengeValue);
    if (index != -1) {
      return AppLocalizations.of(context)!.willBeNotified;
    } else {
      return AppLocalizations.of(context)!.notifyMe;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isUserExists = Provider.of<LocaleProvider>(context, listen: true)
        .user
        .containsKey('username');
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            widget.image,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width > 1024 ? 600 : 500,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.black.withOpacity(0.3),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width > 1024 ? 600 : 500,
          ),
          Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 32.0, horizontal: 16.0),
                width: MediaQuery.of(context).size.width - 32,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Column(
                  children: [
                    TextWidget(
                      title: widget.title,
                      fontSize: 15,
                      textAlign: TextAlign.center,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextWidget(
                      title:
                          '${widget.title} ${AppLocalizations.of(context)!.comingSoon}',
                      fontSize: 16,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: MainButton(
                          buttonText: !isUserExists
                              ? AppLocalizations.of(context)!.notifyMe
                              : buttonName(),
                          fontSize: 13.5,
                          loading: loading,
                          uppercase: true,
                          action: notifyMe),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
