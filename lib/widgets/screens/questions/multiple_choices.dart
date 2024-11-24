import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/buttons/regular_button.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';

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
    return isMultipleChoices
        ? Container(
            alignment: Alignment.center,
            width: 300,
            child: Column(
              children: choices
                  .asMap()
                  .entries
                  .map<Widget>((choice) => Column(
                        children: [
                          choice.value.containsKey('wrongAnswer')
                              ? BlurBackgroundContainer(
                                  body: RegularButton(
                                    buttonText: locale == 'ar'
                                        ? choice.value['ar']
                                        : choice.value['en'],
                                    action: () {
                                      action(choice.value['value'], choice.key);
                                    },
                                    uppercase: true,
                                    fontSize: 13.5,
                                  ),
                                )
                              : MainButton(
                                  buttonText: locale == 'ar'
                                      ? choice.value['ar']
                                      : choice.value['en'],
                                  action: () {
                                    action(choice.value['value'], choice.key);
                                  },
                                  uppercase: true,
                                  fontSize: 13.5,
                                ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ))
                  .toList(),
            ))
        : Container();
  }
}
