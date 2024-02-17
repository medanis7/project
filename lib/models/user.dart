import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String email;
  String password;
  String title;
  String username;
  String uid;
  
  UserData(
      {required this.email,
      required this.password,
      required this.title,
      required this.username,
      required this.uid,
    });

  Map<String, dynamic> convertToMap() {
    return {
      'password': password,
      'email': email,
      'title': title,
      'username': username,
      'uid': uid,
     
    };
  }
  // function that convert "DocumentSnapshot" to a User
// function that takes "DocumentSnapshot" and return a User

  static convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserData(
      email: snapshot["email"],
      username: snapshot["username"],
      password: snapshot['password'],
      title: snapshot["title"],
      uid: snapshot['uid'],
     
    );
  }
}
