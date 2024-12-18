import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/multi-questions.dart';
import 'package:in_zone_app/utilities/socket_methods.dart';
import 'package:in_zone_app/widgets/containers/blur_background_container.dart';
import 'package:in_zone_app/widgets/containers/image_background_plain.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/waiting_for_other_players.dart';
import 'package:in_zone_app/widgets/screens/questions/player_bar.dart';
import 'package:provider/provider.dart';

class MultiScreen extends StatefulWidget {
  const MultiScreen({super.key});

  @override
  State<MultiScreen> createState() => _MultiScreenState();
}

class _MultiScreenState extends State<MultiScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.navigateToGameListener(context, () {
      Navigator.push(
        context,
        MaterialPageRoute(
            settings: const RouteSettings(name: '/multi-questions'),
            builder: (context) => const MultiQuestions()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Map room = Provider.of<LocaleProvider>(context, listen: true).room;
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;

    return ImageBackgroundPlain(
      image: user['selectedTheme'],
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: BlurBackgroundContainer(body: Container()),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: room['players']
                    .asMap()
                    .entries
                    .map<Widget>(
                      (player) => Column(
                        children: [
                          PlayerBar(
                            index: player.key,
                            image: player.value['userId']['selectedAvatar']
                                ['image'],
                            username: player.value['userId']['username'],
                          ),
                          // Show "VS." only if there are more players to be displayed
                          player.key != room['players'].length - 1 ||
                                  room['players'].length !=
                                      room['numberOfPlayers']
                              ? Image.asset(
                                  'assets/images/vs.png',
                                  width: 20,
                                  fit: BoxFit.cover,
                                )
                              : Container(),
                        ],
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 24),
              // Show waiting message if not all players have joined
              room['players'].length != room['numberOfPlayers']
                  ? const WaitingForOtherPlayers()
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
