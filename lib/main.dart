import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:band_names/pages/status.dart';
import 'package:band_names/services/socket_service.dart';
import 'package:band_names/pages/home.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SocketService(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MaterialApp',
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePage(),
          'status' :(_) => const StatusPage()
        },
      ),
    );
  }
}
