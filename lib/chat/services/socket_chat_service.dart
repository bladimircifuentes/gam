import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gam/common/global/environment.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

enum ServerStatus { online, offline, connecting }

class SocketChatService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late socket_io.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  socket_io.Socket get socket => _socket;

  void connect() async {
    const storage = FlutterSecureStorage();
    final String token = await storage.read(key: 'token') ?? '';

    _socket = socket_io.io(Environment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': 'true',
      'forceNew': true,
      'extraHeaders': {'x-token': token}
    });

    _socket.on('connect', (_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });
  }

  void disconnect() {
    _socket.disconnect();
  }
}
