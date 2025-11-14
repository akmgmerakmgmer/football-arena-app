import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/containers/black_modal_container.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/questions/single_perk_illustration.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';

class PerksIllustrations extends StatelessWidget {
  final Function action;
  final Map user;
  const PerksIllustrations(
      {super.key, required this.action, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlackModalContainer(
      body: Container(
        width: MediaQuery.of(context).size.width > 360
            ? MediaQuery.of(context).size.width * 0.9
            : MediaQuery.of(context).size.width,
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
                children: user['perks']
                    .where((perk) => perk['selected'] == true)
                    .toList()
                    .map<Widget>(((perk) => Column(
                          children: [
                            SinglePerkIllustration(
                              perk: perk,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        )))
                    .toList()),
            const SizedBox(
              height: 3,
            ),
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
