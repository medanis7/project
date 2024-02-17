// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isproject/models/session.dart';
import 'package:uuid/uuid.dart';


class AddSession extends StatefulWidget {
  const AddSession({super.key});

  @override
  State<AddSession> createState() => _AddSessionState();
}

class _AddSessionState extends State<AddSession> {
  final dayController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final placeController = TextEditingController();
  final typeController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text('Add Session'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(8),
                  suffixIcon: Icon(Icons.text_fields_sharp),
                  hintText: 'Enter session name',
                ),
              ),
              SizedBox(
                height: 22,
              ),
              TextField(
                controller: typeController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(8),
                  suffixIcon: Icon(Icons.question_answer),
                  hintText: 'TD or TP or LECTURE ',
                ),
              ),
              SizedBox(
                height: 22,
              ),
              TextField(
                controller: dayController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(8),
                  suffixIcon: Icon(Icons.timer_rounded),
                  hintText: 'Session Day ',
                ),
              ),
              SizedBox(
                height: 22,
              ),
              TextField(
                controller: startTimeController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(8),
                  suffixIcon: Icon(Icons.timer_rounded),
                  hintText: 'Starts at? ',
                ),
              ),
              SizedBox(
                height: 22,
              ),
              TextField(
                controller: endTimeController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(8),
                  suffixIcon: Icon(Icons.timer_rounded),
                  hintText: 'Ends at? ',
                ),
              ),
              SizedBox(
                height: 22,
              ),
              TextField(
                controller: placeController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.all(8),
                  suffixIcon: Icon(Icons.location_city_rounded),
                  hintText: 'Session place ',
                ),
              ),
              SizedBox(
                height: 22,
              ),
              ElevatedButton(
                onPressed: () async {
                  var sessionId = const Uuid().v1();
                 SessionData session = SessionData(
                      name: nameController.text,
                      sessionId: sessionId,
                      startTime: startTimeController.text,
                      day: dayController.text,
                      endTime: endTimeController.text,
                      place: placeController.text,
                      type: typeController.text);
                      CollectionReference sessions =
        FirebaseFirestore.instance.collection('sessionSSS');
       await sessions.doc(session.sessionId).set(session.convertToMap());
       Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 3, 96, 236)),
                  padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                ),
                child: Text(
                  "Add Session",
                  style: TextStyle(fontSize: 19, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
