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
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  void leaveRoom(BuildContext context, room) {
    _socketClient?.emit('leaveRoom', room);
  }

  void sendPoints(BuildContext context, data) {
    _socketClient?.emit('sendPoints', data);
  }

  void playerTimeDone(BuildContext context, data) {
    _socketClient?.emit('timeDone', data);
  }

  // Listeners
  void joinRoomSuccesListener(BuildContext context) {
    _socketClient?.on('joinRoomSuccess', (room) {
      Provider.of<LocaleProvider>(context, listen: false).setRoom(room);
      Navigator.pushNamed(context, '/multi-screen');
    });
  }

  void sendPointsListener(BuildContext context) {
    _socketClient?.on('sendPointsListener', (data) {
      Map room = Provider.of<LocaleProvider>(context, listen: false).room;
      for (var player in room['players']) {
        if (player['userId']['_id'] == data['userId']) {
          player["points"] = data['points'];
        }
      }
      Provider.of<LocaleProvider>(context, listen: false).setRoom(room);
    });
  }

  void navigateToGameListener(BuildContext context, callback) {
    _socketClient?.on('navigateToGameListener', (room) {
      callback();
    });
  }

  void timeDoneListener(BuildContext context) {
    _socketClient?.on('timeDoneListener', (data) {
      Map room = Provider.of<LocaleProvider>(context, listen: false).room;
      for (var player in room['players']) {
        if (player['userId']['_id'] == data['userId']) {
          player["timeDone"] = true;
        }
      }
      Provider.of<LocaleProvider>(context, listen: false).setRoom(room);
    });
  }

  void leaveRoomListener(BuildContext context, callback) {
    _socketClient?.once('leaveRoomListener', (roomPlayers) {
      callback(roomPlayers);
    });
  }
}
