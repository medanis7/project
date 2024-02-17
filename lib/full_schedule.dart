// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isproject/add_session.dart';

class FullSchedule extends StatefulWidget {
  const FullSchedule({super.key});

  @override
  State<FullSchedule> createState() => _FullScheduleState();
}

class _FullScheduleState extends State<FullSchedule> {
  late int count;
  getData() async {
    // Timestamp timeNow = DateFormat('Hm', 'en_US').format(date)
    // print(timeNow);
    var a = await FirebaseFirestore.instance.collection('sessionSSS').get();
    setState(() {
      count = a.docs.length;
    });
    print('##############');
    print(a);
    print(a.docs);
  }

  bool touched = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 239, 239),
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text('Schedule'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: FutureBuilder(
              future: FirebaseFirestore.instance.collection('sessionSSS').get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }
          
                if (snapshot.connectionState == ConnectionState.done) {
                  print(snapshot.data.docs);
                  return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: count,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              touched = !touched;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(9),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: touched? const Color.fromARGB(12, 0, 0, 0):Colors.black12,
                                borderRadius: BorderRadius.circular(11),
                                border: Border.all(style: BorderStyle.solid)),
                            child: Text(
                                snapshot.data.docs[index]['name'] +
                                    ' session on ' +
                                    snapshot.data.docs[index]['day'] +
                                    ' at ' +
                                    snapshot.data.docs[index]['startTime']
                                        .toString() +
                                    ' in ' +
                                    snapshot.data.docs[index]['place'],
                                style: TextStyle(fontSize: 22)),
                          ),
                        );
                      });
                }
          
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child:  Center(
              child: Padding(
                  padding: const  EdgeInsets.fromLTRB(10, 28, 0, 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddSession()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange[100]),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: Text(
                      "Alter Schedule",
                      style: TextStyle(fontSize: 29),
                    ),
                  ),
                ),
            ),)
        ],
      ),
    );
  }
}
