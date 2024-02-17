// ignore_for_file: prefer_const_constructors, avoid_print, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';
import 'package:isproject/full_schedule.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  late int count;
  List<String> allTodaySessions = [];

  DateTime date = DateTime.now();

  String findMinimumTime(List clockTimes) {
    if (clockTimes.isEmpty) {
      return 'jjj'; // or handle the case as needed
    }

    DateTime baseDate = DateTime(2000, 1, 1);

    // Initialize minTime with the hours and minutes components of the first parsed time
    DateTime firstParsedTime = DateFormat('HH:mm').parse(clockTimes[0]);
    DateTime minTime = DateTime(baseDate.year, baseDate.month, baseDate.day,
        firstParsedTime.hour, firstParsedTime.minute);

    for (String clockTime in clockTimes) {
      DateTime parsedTime = DateFormat('HH:mm').parse(clockTime);
      DateTime currentTime = DateTime(baseDate.year, baseDate.month,
          baseDate.day, parsedTime.hour, parsedTime.minute);

      if (currentTime.isBefore(minTime)) {
        minTime = currentTime;
      }
    }

    return DateFormat('HH:mm').format(minTime);
  }

  bool isTimeGreaterThanCurrent(String time) {
    print('par par par');
    print(time);
    DateTime currentTime = DateTime.now();

    // Create a DateTime object for the specified time without a specific date
    DateTime specifiedTime =
        DateTime(currentTime.year, currentTime.month, currentTime.day, 0, 0);
        print('ssssssssss');

print(specifiedTime);

    // Parse the specified time string and set the hours and minutes
    DateTime parsedSpecifiedTime = DateFormat('h:mm').parse(time);
    specifiedTime = DateTime(
        specifiedTime.year,
        specifiedTime.month,
        specifiedTime.day,
        parsedSpecifiedTime.hour,
        parsedSpecifiedTime.minute);

    return specifiedTime.hour > currentTime.hour ||
        (specifiedTime.hour == currentTime.hour &&
            specifiedTime.minute > currentTime.minute);
  }

  bool isTime1GreaterThanTime2(String time1, String time2) {
    DateTime baseDate = DateTime(2000, 1, 1);

    // Parse the clock time strings
    DateTime parsedTime1 = DateFormat('h:mm a').parse(time1);
    DateTime parsedTime2 = DateFormat('h:mm a').parse(time2);

    // Combine with the base date to get DateTime variables
    DateTime dateTime1 = DateTime(baseDate.year, baseDate.month, baseDate.day,
        parsedTime1.hour, parsedTime1.minute);
    DateTime dateTime2 = DateTime(baseDate.year, baseDate.month, baseDate.day,
        parsedTime2.hour, parsedTime2.minute);

    // Compare DateTime objects
    return dateTime1.isAfter(dateTime2);
  }

  getData() async {
    // Timestamp timeNow = DateFormat('Hm', 'en_US').format(date)
    // print(timeNow);
    var a = await FirebaseFirestore.instance
        .collection('sessionSSS')
        .where("day", isEqualTo: DateFormat('EEEE').format(date))
        .get();
    setState(() {
      count = a.docs.length;
    });
    print('##############');
    print(a);
    print(a.docs);
  }
final FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak('Alright,' +text+'. If you would like to see the full schedule please press the button!');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(isTimeGreaterThanCurrent('8:22'));
    print(isTimeGreaterThanCurrent('20:33'));
    getData();
    print(DateFormat('Hm', 'en_US').format(date));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 16,
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('sessionSSS')
                .where("day", isEqualTo: DateFormat('EEEE').format(date))
                .get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }
        
              if (snapshot.connectionState == ConnectionState.done) {
                
                for (int i = 0; i < count; i++) {
                  if (isTimeGreaterThanCurrent(
                    
                      snapshot.data.docs[i]['startTime'])){
                    allTodaySessions.add(snapshot.data.docs[i]['startTime']);

                      print('ttttttttttt'+snapshot.data.docs[i]['startTime']);}
                }
                print(allTodaySessions);
                print('#############');
                print(DateFormat('EEEE').format(date));
        
                print(snapshot.data.docs);
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount:count,
                    itemBuilder: (BuildContext context, int index) {
                      print(snapshot.data.docs[index]['startTime']);
                      print(index);
                      String aa = snapshot.data.docs[index]['startTime'];
                      print('testttttt' + aa);
                      print('aaaaaaaaaaaaaaaaaa');
                      print(allTodaySessions);
                    if (snapshot.data.docs[index]['startTime']==findMinimumTime(allTodaySessions))  speak('Today is ' +
                                DateFormat('EEEE').format(date) +
                                ' and your next session is ' +
                                snapshot.data.docs[index]['name'] +
                                ' in ' +
                                snapshot.data.docs[index]['place'] +
                                ' at ' +
                                findMinimumTime(allTodaySessions));
                      return snapshot.data.docs[index]['startTime']==findMinimumTime(allTodaySessions)? Center(
                        child:  Container(
                          padding: EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                          ),
                          child: Text(
                            'Today is ' +
                                DateFormat('EEEE').format(date) +
                                ' and your next session is ' +
                                snapshot.data.docs[index]['name'] +
                                ' in ' +
                                snapshot.data.docs[index]['place'] +
                                ' at ' +
                                findMinimumTime(allTodaySessions),
                            style: TextStyle(fontSize: 22),
                          ),
                        )
                      ):SizedBox();
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
          flex: 5,
          child: TextButton.icon(
   onPressed: (){
     Navigator.push(
                  context,
                   MaterialPageRoute(
                      builder: (BuildContext context) =>  FullSchedule()));
   },
   icon: Icon(Icons.schedule_sharp, color: Colors.black,size: 24.0,),
   label: Text('See full schedule', style: TextStyle(color: Color.fromARGB(255, 26, 17, 153),fontSize: 31 , fontWeight: FontWeight.w600,fontStyle: FontStyle.italic)),)
)
      ],
    );
  }
}
