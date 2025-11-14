import 'package:flutter/material.dart';
import 'package:in_zone_app/screens/single_hint.dart';
import 'package:in_zone_app/widgets/buttons/hint_action_button.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';

class Hints extends StatelessWidget {
  final List hints;
  final int allHintsLength;
  final String locale;
  final bool isPlayerSearch;
  final Function skipAction;
  final Function addHintAction;
  const Hints(
      {super.key,
      required this.hints,
      required this.locale,
      required this.allHintsLength,
      required this.isPlayerSearch,
      required this.skipAction,
      required this.addHintAction});

  @override
  Widget build(BuildContext context) {
    return isPlayerSearch
        ? Container(
            margin: const EdgeInsets.only(top: 60, left: 10, right: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8,
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.start,
                    children: hints
                        .map((hint) => SingleHint(
                              hint: hint[locale],
                            ))
                        .toList(),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      allHintsLength >= hints.length
                          ? GestureDetector(
                              onTap: () => skipAction(),
                              child: HintActionButton(
                                  disabled: false,
                                  title: AppLocalizations.of(context)!
                                      .skipQuestion,
                                  icon: const Icon(
                                    Icons.skip_next,
                                    color: Colors.white,
                                  )),
                            )
                          : Container(),
                      GestureDetector(
                        onTap: () => addHintAction(),
                        child: HintActionButton(
                            disabled: allHintsLength <= hints.length,
                            title: AppLocalizations.of(context)!.addHint,
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        : Container();
  }
}
