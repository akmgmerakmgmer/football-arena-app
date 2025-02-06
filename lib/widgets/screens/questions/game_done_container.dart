import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/buttons/save_exit_button.dart';
import 'package:in_zone_app/widgets/containers/modal_container.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class GameDoneContainer extends StatelessWidget {
  final String image;
  const GameDoneContainer({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedImage(image: image, width: 200),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SaveExitButton(
                buttonText: AppLocalizations.of(context)!.playAgain,
                action: () => ModalContainer.choosePlayOptionModal(
                    context, localeProvider, '',
                    isOnline: true),
                icon: Icons.restart_alt,
                radius: 10,
              ),
              const SizedBox(
                width: 15,
              ),
              SaveExitButton(
                buttonText: AppLocalizations.of(context)!.exitGame,
                action: () =>
                    Navigator.pushReplacementNamed(context, '/main-online'),
                icon: Icons.exit_to_app,
                radius: 10,
              ),
            ],
          )
        ],
      ),
    );
  }
}
