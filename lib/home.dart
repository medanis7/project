// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:isproject/full_schedule.dart';
import 'package:isproject/register.dart';
import 'package:isproject/speech.dart';
import 'package:isproject/text.dart';
import 'package:isproject/time.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 209, 200, 169),
      appBar: AppBar(
        backgroundColor: Colors.black12,
        actions: [  Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Register()));
                        },
                        icon: Icon(
                          Icons.logout,
                          size: 24.0,
                        ),
                        label: Text(
                          "Logout",
                          style: TextStyle(fontSize: 19),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(121, 212, 221, 200)),
                          padding: MaterialStateProperty.all(EdgeInsets.all(7)),
                          
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.black))),
                        ),
                      ),
        ),],
        title: Text('HOME'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Icon(Icons.message_rounded,size: 50,),),
                  Container(
                    margin: EdgeInsets.fromLTRB(22, 0, 22, 22),
                      padding: EdgeInsets.all(22),
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(44)),
                      child: Text(
                        'Hi I am IS assistant.. how can I help you today?',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              Padding(
                padding: const  EdgeInsets.fromLTRB(50, 18, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SpeechScreen()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange[100]),
                    padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  child: Text(
                    "Speech to text",
                    style: TextStyle(fontSize: 29),
                  ),
                ),
              ),
              Padding(
                padding: const  EdgeInsets.fromLTRB(50, 18, 0, 0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TextScreen()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange[100]),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: Text(
                      "Text to speech",
                      style: TextStyle(fontSize: 29),
                    ),
                  ),
              ),
                Padding(
                  padding: const  EdgeInsets.fromLTRB(50, 18, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SpeechScreen()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange[100]),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: Text(
                      "Tell me a joke",
                      style: TextStyle(fontSize: 29),
                    ),
                  ),
                ),
                Padding(
                  padding: const  EdgeInsets.fromLTRB(50, 18, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FullSchedule()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange[100]),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: Text(
                      "My Schedule",
                      style: TextStyle(fontSize: 29),
                    ),
                  ),
                ),
               
            ],
          ),
        ),
      ),
    );
  }
}
