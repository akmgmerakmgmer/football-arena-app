import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/widgets/buttons/main_button.dart';

class MultipleChoices extends StatelessWidget {
  final String locale;
  final List choices;
  final bool isMultipleChoices;
  final Function action;
  const MultipleChoices(
      {super.key,
      required this.locale,
      required this.choices,
      required this.isMultipleChoices,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 300,
      child: isMultipleChoices
          ? Column(
              children: choices
                  .map<Widget>((choice) => Column(
                        children: [
                          MainButton(
                            buttonText:
                                locale == 'ar' ? choice['ar'] : choice['en'],
                            action: () {
                              action(choice['value']);
                            },
                            uppercase: true,
                            fontSize: 15,
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ))
                  .toList(),
            )
          : Container(),
    );
  }
}
