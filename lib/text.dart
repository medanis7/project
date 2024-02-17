// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextScreen extends StatefulWidget {
  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  final FlutterTts flutterTts = FlutterTts();

  final TextEditingController myController = TextEditingController();

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    speak('please type something and press go, and I will read it');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text('Text to speech service'),
      ),
      body: Center(
        child: Container(
          color: Color.fromARGB(255, 241, 224, 219),
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(33),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: 'Enter your text'),
                  controller: myController,
                ),
                SizedBox(
                  height: 100,
                ),
                 Padding(
                  padding: const  EdgeInsets.fromLTRB(10, 28, 0, 20),
                  child: ElevatedButton(
                    onPressed: () {
                       speak(myController.text);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 209, 178)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(32)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(38))),
                    ),
                    child: Text(
                      "Go",
                      style: TextStyle(fontSize: 29),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
