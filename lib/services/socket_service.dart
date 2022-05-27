import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  online,
  offline,
  connecting
}


class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  
  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;
 

  void connect() async {

    final token =  await AuthService.getToken();
    
    // Dart client
    _socket = IO.io(Enviroment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew':true,
      'extraHeaders':{
        'x-token':token
      }
    });

    _socket.on('connect', (_) {
      _serverStatus = ServerStatus.online;
      print('Client Connect');
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      print('Client Disconnect');
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

  }

  void disconnect() {
    _socket.disconnect();
  }

}