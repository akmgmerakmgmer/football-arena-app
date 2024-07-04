import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/questions.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Challenge extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  const Challenge({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                image,
                fit: BoxFit.cover,
                width: 225,
                height: 420,
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: const BorderRadius.all(Radius.circular(10)),
              //     color: Colors.black.withOpacity(0.3),
              //   ),
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.width > 1024 ? 600 : 500,
              // ),
              Positioned(
                  bottom: 0,
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
                              buttonText: AppLocalizations.of(context)!.playNow,
                              fontSize: 13.5,
                              uppercase: true,
                              letterSpacing: 1.1,
                              action: () {
                                if (Provider.of<LocaleProvider>(context,
                                        listen: false)
                                    .user
                                    .containsKey('username')) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Questions(
                                        mode: title,
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.pushReplacementNamed(context, '/login');
                                }
                              }),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
        const SizedBox(
          width: 24,
        )
      ],
    );
  }
}
