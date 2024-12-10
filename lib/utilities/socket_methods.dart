import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/socket.dart';
import 'package:provider/provider.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance?.socket;

  // Emitters
  void joinRoom(BuildContext context) {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    if (user.isNotEmpty) {
      _socketClient?.emit('joinRoom', {'userId': user['_id']});
    }
  }

  void sendPoints(BuildContext context, room) {
    _socketClient?.emit('sendPoints', room);
  }

  // Listeners
  void joinRoomSuccesListener(BuildContext context) {
    _socketClient?.on(
        'joinRoomSuccess',
        (room) => {
              Provider.of<LocaleProvider>(context, listen: false).setRoom(room),
              Navigator.pushReplacementNamed(context, '/multi-screen')
            });
  }

  // Listeners
  void sendPointsListener(BuildContext context) {
    _socketClient?.on(
        'sendPointsListener',
        (room) => {
              Provider.of<LocaleProvider>(context, listen: false).setRoom(room),
            });
  }
}
