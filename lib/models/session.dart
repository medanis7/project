
class SessionData {
   final String name;
final String startTime;
final String endTime;
final String place;
final String sessionId;
final String type;
final String day;
  SessionData(
      {required this.name,
      required this.sessionId,
      required this.startTime,
      required this.day,
      required this.endTime,
      required this.place,
      required this.type,
      });

  Map<String, dynamic> convertToMap() {
    return {
      'name': name,
      'sessionId': sessionId,
      'startTime': startTime,
      'day': day,
      'endTime': endTime,
      'place': place,
      'type': type
    };
  }
  // function that convert "DocumentSnapshot" to a User
// function that takes "DocumentSnapshot" and return a User

  // static convertSnap2Model(DocumentSnapshot snap) {
  //   var snapshot = snap.data() as Map<String, dynamic>;
  //   return PostData(
  //     profileImg: snapshot["profileImg"],
  //     username: snapshot["username"],
  //     description: snapshot['description'],
  //     imgPost: snapshot["imgPost"],
  //     uid: snapshot["uid"],
  //     postId: snapshot['Postid'],
  //     datePublished: snapshot['datePublished'],
  //     likes: snapshot['likes'],
  //   );
  // }
}
