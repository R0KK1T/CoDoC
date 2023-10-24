import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String userId;
  final String photoUrl;
  final String username;
  final List<String> groups;

  const User({
    required this.username,
    required this.userId,
    required this.photoUrl,
    required this.email,
    required this.groups,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      userId: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      groups: List<String>.from(snapshot["groups"] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": userId,
        "email": email,
        "photoUrl": photoUrl,
        "groups": groups,
      };
}
