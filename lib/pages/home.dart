import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/band.dart';
import '../services/socket_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band('1', "Viejo Miseria", 50),
    Band('2', "Los Beatles", 9),
    Band('3', "Metalica", 4),
    Band('4', "Los Guanaqueros", 10),
    Band('5', "Los Piojos", 1),
  ];
  @override
  Widget build(BuildContext context) {
    final serverStatus = Provider.of<SocketService>(context).serverStatus;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Band Names",
            style: TextStyle(color: Colors.black54),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 10),
              child: serverStatus == ServerStatus.Online
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.blue[300],
                    )
                  : const Icon(
                      Icons.offline_bolt,
                      color: Colors.red,
                    ))
        ],
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, index) => _bandTile(bands[index])),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: _addBand,
        child: const Icon(Icons.add),
      ),
    );
  }

  _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        print('direction: $direction');
        print('id: ${band.id}');
        //TODO: Llamar el borrado del server
      },
      background: Container(
        color: Colors.red,
        child: Row(
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.delete,
                color: Colors.black54,
              ),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Delete Band",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: const TextStyle(fontSize: 18),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  _addBand() {
    final textEditingController = TextEditingController();
    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("New Band Name:"),
              content: TextField(
                controller: textEditingController,
              ),
              actions: [
                MaterialButton(
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => _addBandToList(textEditingController.text),
                    child: const Text("Add"))
              ],
            );
          });
    } else {
      showCupertinoDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
              title: const Text("New Band Name:"),
              content: CupertinoTextField(
                controller: textEditingController,
              ),
              actions: [
                CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () => _addBandToList(textEditingController.text),
                    child: const Text("Add")),
                CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Dismiss"))
              ],
            );
          });
    }
  }

  _addBandToList(String name) {
    if (name.length > 1) {
      bands.add(Band(DateTime.now().toString(), name, 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
