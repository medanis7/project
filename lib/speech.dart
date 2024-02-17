// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously, deprecated_member_use

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:isproject/joke.dart';
import 'package:isproject/schedule.dart';
import 'package:isproject/shared/snackbar.dart';
import 'package:isproject/time.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:url_launcher/url_launcher.dart';

class SpeechScreen extends StatefulWidget {
  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  bool showTime = false;
  bool showJoke = false;
  bool showNextSession = false;
  
  DateTime date = DateTime.now();
  late SpeechToText speech;
  bool isListening = false;
  String text = '...';
  double confidence = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    speech = SpeechToText();
  }

  openApp() async {
    showSnackBar(context, 'Openning Spotify');
     const songName = 'Bruno Mars'; 
  final query = Uri.encodeComponent(songName);
  final url = 'spotify:search:$query';

  if (await canLaunch(url)) {
    await launch(url);
  } else {
 showSnackBar(context, 'Could not open Spotify');
  }}
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 158, 158, 158),
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text('Press the mic'),
      ),
      floatingActionButton: AvatarGlow(
        child: FloatingActionButton(
          
          
          onPressed: () {
            // isListening = !isListening;
            isListening? showSnackBar(context, 'Press the mic again if you need something'):null;
            showNextSession = false;
            showJoke = false;
            showTime = false;
            listen();
          },
          child: Icon(isListening ? Icons.mic : Icons.mic_none,size: 40,),
        ),
        //  endRadius: 70,
        animate: isListening,
        duration: Duration(milliseconds: 2000),
        glowColor: Colors.red,
        // repeatPauseDuration: Duration(milliseconds: 100),
        repeat: true,
      ),
      body: !showTime && !showJoke && !showNextSession? SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(30, 30, 30, 150),
          child:  Text(text,style: TextStyle(fontSize: 28),)
        ),
      ):showTime && !showJoke&&!showNextSession? Center(
        child: Time()
      ):
      showNextSession? Schedule():
      Center(child: Joke())
    );
  }

  void listen() async {
     
    if (!isListening) {
      bool available = await speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => isListening = true);

        speech.listen(
          onResult: (val) => setState(() {
            text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              confidence = val.confidence;
             isListening =false;
             showSnackBar(context, 'Press the mic again if you need something');
            }
            if (val.recognizedWords.contains('Spotify')||val.recognizedWords.contains('music')) {
              openApp();

            }
            else if (val.recognizedWords.contains('time')) {
              setState(() {
                showTime = true;
                isListening = false;
              });
        
            }
            else if (val.recognizedWords.contains('schedule')) {
              setState(() {
                showNextSession=true;
                isListening = false;
              });
        
            }
             else if (val.recognizedWords.contains('joke')||val.recognizedWords.contains('jokes')||val.recognizedWords.contains('funny')) {
              print('time time time time time time time time');
              setState(() {
                showJoke = true;
                isListening = false;
              });
              
           
            }
          }),
        );
      }
    } else {
      setState(() => isListening = false);
      speech.stop();
    }
  }
}
