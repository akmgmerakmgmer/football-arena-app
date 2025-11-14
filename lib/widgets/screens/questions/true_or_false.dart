import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TrueOrFalse extends StatelessWidget {
  final String locale;
  final List choices;
  final bool isTrueOrFalse;
  final Function action;
  final bool enableFeedback;
  const TrueOrFalse(
      {super.key,
      required this.locale,
      required this.choices,
      required this.isTrueOrFalse,
      required this.action,
      this.enableFeedback = true});

  @override
  Widget build(BuildContext context) {
    return isTrueOrFalse
        ? Container(
            alignment: Alignment.center,
            width: 300,
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              children: choices
                  .asMap()
                  .entries
                  .map<Widget>(
                    (choice) => MainButton(
                      buttonText: locale == 'ar'
                          ? choice.value['ar']
                          : choice.value['en'],
                      action: () {
                        action(choice.value['value'], choice.key);
                      },
                      uppercase: true,
                      fontSize: 13,
                      enableFeedback: enableFeedback,
                    ),
                  )
                  .toList(),
            ))
        : Container();
  }
}
