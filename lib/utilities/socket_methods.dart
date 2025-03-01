import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/multi_screen.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/utilities/socket.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance?.socket;

  // Emitters
  void joinRoom(BuildContext context, LocaleProvider localeProvider,
      {String questionMode = '', bool coinsPayed = false}) {
    Map user = localeProvider.user;
    if (user.isNotEmpty) {
      _socketClient
          ?.emit('joinRoom', {'userId': user['_id'], 'coinsPayed': coinsPayed});
    } else {
      if (context.mounted) {
        Navigator.pushNamed(context, '/signup');
      }
    }
  }

  void leaveRoomEarly(data, coinsPayed, BuildContext context,
      LocaleProvider localeProvider, user) {
    if (coinsPayed) {
      PutApi('users/${user['_id']}', {'coins': user['coins'] + 100}, (res) {
        localeProvider.setUser(res);
      }).put(context);
    }
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
    _socketClient?.on('joinRoomSuccess', (data) {
      // Access and modify the room data
      String userId = localeProvider.user['_id'];

      // Find and rearrange the current user's data
      Map myUser = data['room']['players']
          .firstWhere((player) => player['userId']['_id'].toString() == userId);
      data['room']['players'].remove(myUser);
      data['room']['players'].insert(0, myUser);
      localeProvider.setRoom(data['room']);
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            settings: const RouteSettings(name: '/multi-screen'),
            builder: (context) => MultiScreen(
              coinsPayed: data['coinsPayed'],
            ),
          ),
        );
      }
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
