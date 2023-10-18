import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String userId;
  //final String photoUrl;
  final String username;

  const User({
    required this.username,
    required this.userId,
    //required this.photoUrl,
    required this.email,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      userId: snapshot["uid"],
      email: snapshot["email"],
      //photoUrl: snapshot["photoUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": userId,
        "email": email,
        //"photoUrl": photoUrl,
      };
}
