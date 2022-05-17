import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  ServerStatus get serverStatus => _serverStatus;
  IO.Socket? _socket;
  IO.Socket? get socket => _socket;
  Function get emit => _socket!.emit;

  SocketService() {
    initConfig();
  }

  void initConfig() {
    // Dart client
    //_socket = IO.io('https://basic-socket-server-flutter.herokuapp.com');

    _socket = IO.io('https://server-socket-bands.herokuapp.com',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // optional
            .build()
    );
    _socket!.connect();
    print(_socket!.connected);
    print(_socket!.disconnected);
    _socket!.onConnect((_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket!.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    //_socket.on('nuevo-mensaje', (payload){
    //  print( 'nuevo mensaje: $payload');
    //});
  }
}
