import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gam/common/helpers/token.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

enum ServerStatus { online, offline, connecting }

class SocketChatService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late socket_io.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  socket_io.Socket get socket => _socket;

  void connect(String socketUrl) async {
    final Map<String, dynamic> dataToken = await json.decode(
      await Token.getToken()
    );
    

    _socket = socket_io.io(socketUrl, {
      'transports': ['websocket'],
      'autoConnect': 'true',
      'forceNew': true,
      'extraHeaders': {'x-token': dataToken['token']}
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
