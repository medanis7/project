// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';

class Time extends StatefulWidget {
  const Time({super.key});

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  final FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }
  DateTime date = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(date);
    speak('it is ' +DateFormat('Hm', 'en_US').format(date) + 'on, ' + DateFormat('MMMM d, ' 'y').format(date));
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(77)),
          height: 400,
          padding: EdgeInsets.all(70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('Hm', 'en_US').format(date),
                style: TextStyle(fontSize: 84,fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                DateFormat('MMMM d, ' 'y').format(date),
                style: TextStyle(fontSize: 24),
              ),
              
            ],
          ),
        ),
      
    );
  }
}
