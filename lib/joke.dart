// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Joke extends StatefulWidget {
  @override
  State<Joke> createState() => _JokeState();
}

Map data = {};

class _JokeState extends State<Joke> {
  bool isGettingData = true;
  late int ind;

  final FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak('Sure. here is a joke for you:' + text);
  }

  getData() async {
    ind = Random().nextInt(12);
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('jokeSSS')
          .doc('jokes')
          .get();
      data = snapshot.data()!;
      setState(() {
        isGettingData = false;
      });
      speak(data['jokes'][ind]);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return isGettingData
        ? CircularProgressIndicator()
        : Column(
            children: [
              Container(
                margin: EdgeInsets.all(11),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(22)),
                padding: EdgeInsets.all(15),
                child: Text(
                  data['jokes'][ind] + ' :))',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Icon(
                Icons.tag_faces,
                size: 300,
                color: Color.fromARGB(88, 17, 14, 7),
              )
            ],
          );
  }
}
