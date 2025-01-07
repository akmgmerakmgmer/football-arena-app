import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/socket.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance?.socket;

  // Emitters
  void joinRoom(BuildContext context, LocaleProvider localeProvider,
      {String questionMode = ''}) {
    Map user = localeProvider.user;
    if (user.isNotEmpty) {
      _socketClient?.emit(
          'joinRoom', {'userId': user['_id'], 'questionMode': questionMode});
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  void leaveRoomEarly(data) {
    _socketClient?.emit('leaveRoomEarly', data);
  }

  void leaveRoom(room) {
    _socketClient?.emit('leaveRoom', room);
  }

  void sendPoints(data) {
    _socketClient?.emit('sendPoints', data);
  }

  void playerTimeDone(data) {
    _socketClient?.emit('timeDone', data);
  }

  void gameDone(data) {
    _socketClient?.emit('gameDone', data);
  }

  // Listeners
  void joinRoomSuccesListener(
      BuildContext context, LocaleProvider localeProvider) {
    _socketClient?.on('joinRoomSuccess', (room) {
      // Access and modify the room data
      String userId = localeProvider.user['_id'];

      // Find and rearrange the current user's data
      Map myUser = room['players']
          .firstWhere((player) => player['userId']['_id'].toString() == userId);
      room['players'].remove(myUser);
      room['players'].insert(0, myUser);
      localeProvider.setRoom(room);
      Navigator.pushNamed(context, '/multi-screen');
    });
  }

  void sendPointsListener(LocaleProvider localeProvider) {
    _socketClient?.on('sendPointsListener', (data) {
      Map room = localeProvider.room;
      for (var player in room['players']) {
        if (player['userId']['_id'] == data['userId']) {
          player["points"] = data['points'];
        }
      }
      localeProvider.setRoom(room);
    });
  }

  void navigateToGameListener(callback) {
    _socketClient?.once('navigateToGameListener', (room) {
      callback();
    });
  }

  void timeDoneListener(LocaleProvider localeProvider, callback) {
    _socketClient?.on('timeDoneListener', (data) {
      Map room = localeProvider.room;
      for (var player in room['players']) {
        if (player['userId']['_id'] == data['userId']) {
          player["timeDone"] = true;
        }
      }
      localeProvider.setRoom(room);
      callback(room);
    });
  }

  void leaveRoomEarlyListener(LocaleProvider localeProvider) {
    _socketClient?.once('leaveRoomEarlyListener', (data) {
      localeProvider.setRoom(data['room']);
    });
  }

  void leaveRoomListener(LocaleProvider localeProvider, callback) {
    _socketClient?.once('leaveRoomListener', (data) {
      localeProvider.setRoom(data['fullRoom']);
      callback(data['roomPlayers'], data['fullRoom']);
    });
  }
}
