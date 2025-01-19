import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/questions.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/utilities/socket_methods.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/containers/modal_container.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SingleMode extends StatefulWidget {
  final Map singleMode;
  final bool isOnline;
  const SingleMode({
    super.key,
    required this.singleMode,
    this.isOnline = false,
  });

  @override
  State<SingleMode> createState() => _SingleModeState();
}

class _SingleModeState extends State<SingleMode> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);
    _socketMethods.joinRoomSuccesListener(context, localeProvider);
    super.initState();
  }

  bool isPlayedToday(context) {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    List currentMode = user['questionModes']
        .where((userMode) => userMode['modeName'] == widget.singleMode['mode'])
        .toList();
    if (currentMode.isNotEmpty &&
        currentMode[0]['modeName'] == widget.singleMode['mode'] &&
        currentMode[0]['lastPlayedDate'] == formattedDate) {
      return true;
    }
    return false;
  }

  playMode(BuildContext context) {
    final SocketMethods socketMethods = SocketMethods();
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);
    if (!GeneralMethods().isUserExists(context)) {
      return Navigator.pushNamed(context, '/login');
    }

    if (isPlayedToday(context)) {
      return ModalContainer.choosePlayOptionModal(
          context, localeProvider, widget.singleMode['mode']);
    }
    if (widget.isOnline && context.mounted) {
      socketMethods.joinRoom(context, localeProvider,
          questionMode: widget.singleMode['mode']);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/questions'),
          builder: (context) => Questions(
            questionMode: widget.singleMode['mode'],
            userId:
                Provider.of<LocaleProvider>(context, listen: false).user['_id'],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    return Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(widget.singleMode['image']),
              )),
              width: 225,
              height: 420,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: 225,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.85),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWidget(
                      title: locale == 'ar'
                          ? widget.singleMode['ar']
                          : widget.singleMode['en'],
                      fontSize: 15,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    TextWidget(
                      title: locale == 'ar'
                          ? widget.singleMode['descriptionAr']
                          : widget.singleMode['descriptionEn'],
                      fontSize: 13,
                      textAlign: TextAlign.center,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: MainButton(
                          buttonText: AppLocalizations.of(context)!.playNow,
                          fontSize: 12.5,
                          uppercase: true,
                          letterSpacing: 1.1,
                          isChallengesPage: true,
                          radius: 10,
                          action: () => playMode(context)),
                    )
                  ],
                ),
              )),
        ),
        const SizedBox(
          width: 24,
        )
      ],
    );
  }
}
