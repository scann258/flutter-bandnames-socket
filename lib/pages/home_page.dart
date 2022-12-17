import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:band_names/models/band_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BandModel> bands = [
    BandModel(id: '1', name: 'Metalica', votes: 5),
    BandModel(id: '2', name: 'Mana', votes: 8),
    BandModel(id: '3', name: 'Queen', votes: 3),
    BandModel(id: '4', name: 'Bon Jovi', votes: 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'BandNames',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white12,
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          addNewBand();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => bandTitle(bands[i]),
      ),
    );
  }

  // ·······································
  // ······ bandTitle
  // ᗧ···ᗣ···ᗣ···
  Widget bandTitle(BandModel band) {
    return Dismissible(
      onDismissed: (direction) {
        bands.remove(band);
        print(bands.length);
      },
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: const EdgeInsets.only(left: 30),
        alignment: Alignment.centerLeft,
        color: Colors.red,
        child: Row(
          children: const [
            Icon(Icons.delete, color: Colors.white, size: 26),
            SizedBox(
              width: 10,
            ),
            Text(
              'Delete Band',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(
            band.name.substring(0, 2).toUpperCase(),
          ),
        ),
        title: Text(band.name),
        trailing: Text(
          band.votes.toString(),
          style: const TextStyle(fontSize: 18),
        ),
        onTap: () {},
      ),
    );
  }

  // ·······································
  // ······ addNewBand
  // ᗧ···ᗣ···ᗣ···
  void addNewBand() {
    final textController = TextEditingController();

    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('New Band Name'),
            content: TextField(
              controller: textController,
            ),
            actions: [
              MaterialButton(
                onPressed: () => addBandToList(textController.text),
                elevation: 0,
                focusElevation: 0,
                disabledElevation: 0,
                highlightElevation: 0,
                textColor: Colors.blue,
                color: Colors.grey[100],
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text('New Band Name'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Add'),
              onPressed: () => addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Dismiss'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  // ·······································
  // ······ addBandToList
  // ᗧ···ᗣ···ᗣ···
  void addBandToList(String name) {
    if (name.length > 1) {
      bands.add(
        BandModel(id: DateTime.now().toString(), name: name, votes: 0),
      );
      setState(() {});
    }
    Navigator.pop(context);
  }
}
