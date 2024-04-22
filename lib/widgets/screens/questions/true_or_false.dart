import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/widgets/buttons/main_button.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TrueOrFalse extends StatelessWidget {
  final String locale;
  final List choices;
  final bool isTrueOrFalse;
  final Function action;
  const TrueOrFalse(
      {super.key,
      required this.locale,
      required this.choices,
      required this.isTrueOrFalse,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 300,
      child: isTrueOrFalse
          ? StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              children: choices
                  .map<Widget>(
                    (choice) => MainButton(
                      buttonText: locale == 'ar' ? choice['ar'] : choice['en'],
                      action: () {
                        action(choice['value']);
                      },
                      uppercase: true,
                      fontSize: 15,
                    ),
                  )
                  .toList(),
            )
          : Container(),
    );
  }
}
