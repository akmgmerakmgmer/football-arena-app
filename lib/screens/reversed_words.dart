import 'package:flutter/material.dart';
import 'package:in_zone_app/screens/single_letter.dart';
import 'package:in_zone_app/widgets/buttons/hint_action_button.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReversedWords extends StatefulWidget {
  final List reversedWord;
  final bool isReversedWords;
  final Function skipAction;
  final Function deleteWord;
  final Function initiateAnswer;
  const ReversedWords(
      {super.key,
      required this.reversedWord,
      required this.isReversedWords,
      required this.skipAction,
      required this.deleteWord,
      required this.initiateAnswer});

  @override
  State<ReversedWords> createState() => _ReversedWordsState();
}

class _ReversedWordsState extends State<ReversedWords> {
  List words = [];

  clickAction(letter) {
    if (!letter['isChosen']) {
      words.add(letter['letter']);
      letter['isChosen'] = true;
      setState(() {
        words = words;
      });
      if (words.length == widget.reversedWord.length) {
        widget.initiateAnswer(words.join(''));
      }
    }
  }

  deleteWord() {
    if (words.isNotEmpty) {
      setState(() {
        words = [];
      });
      widget.deleteWord();
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reversedWord != widget.reversedWord) {
      setState(() {
        words = [];
      });
      // Handle the change in someProp here
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.isReversedWords
        ? Column(
            children: [
              Wrap(
                spacing: 8,
                children: widget.reversedWord
                    .map((letter) => SingleLetter(
                          letter: letter,
                          action: clickAction,
                          isChosen: letter['isChosen'],
                        ))
                    .toList(),
              ),
              const SizedBox(
                height: 16,
              ),
              TextWidget(
                title: words.join(''),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => widget.skipAction(),
                      child: HintActionButton(
                          disabled: false,
                          title: AppLocalizations.of(context)!.skipQuestion,
                          icon: const Icon(
                            Icons.skip_next,
                            color: Colors.white,
                          )),
                    ),
                    GestureDetector(
                      onTap: () => deleteWord(),
                      child: HintActionButton(
                          disabled: false,
                          title: AppLocalizations.of(context)!.deleteWord,
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 20,
                          )),
                    )
                  ],
                ),
              )
            ],
          )
        : Container();
  }
}
