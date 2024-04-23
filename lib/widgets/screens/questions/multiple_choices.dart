import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/widgets/buttons/main_button.dart';
import 'package:flutter_challenge_mobile/widgets/buttons/regular_button.dart';

class MultipleChoices extends StatelessWidget {
  final String locale;
  final List choices;
  final bool isMultipleChoices;
  final Function action;
  const MultipleChoices({
    super.key,
    required this.locale,
    required this.choices,
    required this.isMultipleChoices,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 300,
      child: isMultipleChoices
          ? Column(
              children: choices
                  .asMap()
                  .entries
                  .map<Widget>((choice) => Column(
                        children: [
                          choice.value.containsKey('wrongAnswer')
                              ? RegularButton(
                                  buttonText: locale == 'ar'
                                      ? choice.value['ar']
                                      : choice.value['en'],
                                  action: () {
                                    action(choice.value['value'], choice.key);
                                  },
                                  uppercase: true,
                                  fontSize: 15,
                                )
                              : MainButton(
                                  buttonText: locale == 'ar'
                                      ? choice.value['ar']
                                      : choice.value['en'],
                                  action: () {
                                    action(choice.value['value'], choice.key);
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
