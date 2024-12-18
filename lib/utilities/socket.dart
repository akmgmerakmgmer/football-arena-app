// ignore: library_prefixes
import 'package:in_zone_app/utilities/base_url.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  IO.Socket? socket;
  static SocketClient? _instance;
  SocketClient._internal() {
    socket = IO.io(BaseUrl().baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket!.connect();
  }

  static SocketClient? get instance{
    _instance ??=SocketClient._internal();
    return _instance;
  }
}
