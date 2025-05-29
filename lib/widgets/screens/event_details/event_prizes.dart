import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/modal_container.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/screens/event_details/prizes_content.dart';
import 'package:in_zone_app/widgets/screens/home/shiny_icon.dart';

class EventPrizes extends StatelessWidget {
  final List prizes;
  final bool isSinglePlayer;
  const EventPrizes(
      {super.key, required this.prizes, this.isSinglePlayer = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextWidget(
          title: AppLocalizations.of(context)!.prizes,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(
          width: 4,
        ),
        isSinglePlayer
            ? Container()
            : GestureDetector(
                onTap: () {
                  ModalContainer.modal(context, PrizesContent(prizes: prizes),
                      AppLocalizations.of(context)!.prizes);
                },
                child: const ShinyIcon(
                    size: 14, icon: Icons.question_mark_rounded)),
        const SizedBox(
          width: 4,
        ),
        TextWidget(
          title: isSinglePlayer
              ? '(${AppLocalizations.of(context)!.winningPlayers})'
              : '(${AppLocalizations.of(context)!.winningTeam})',
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: Colors.white70,
        ),
      ],
    );
  }
}
