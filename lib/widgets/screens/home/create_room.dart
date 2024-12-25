import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/socket_methods.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:provider/provider.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    _socketMethods.joinRoomSuccesListener(context, localeProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    return Column(
      children: [
        MainButton(
            buttonText: 'Join a Room',
            action: () => _socketMethods.joinRoom(context, localeProvider))
      ],
    );
  }
}
