import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class SinglePerkIllustration extends StatelessWidget {
  final Map perk;
  const SinglePerkIllustration({super.key, required this.perk});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Row(
            children: [
              Image.asset(
                perk['image'],
                fit: BoxFit.cover,
                width: 50,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                      textAlign: TextAlign.start,
                      fontSize: 17,
                      title: Provider.of<LocaleProvider>(context, listen: false)
                                  .locale ==
                              'ar'
                          ? perk['title']['ar']
                          : perk['title']['en']),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextWidget(
                      fontSize: 14,
                      title: Provider.of<LocaleProvider>(context, listen: false)
                                  .locale ==
                              'ar'
                          ? perk['text']['ar']
                          : perk['text']['en'],
                      color: Colors.grey.shade400,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}
