import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String userId;
  final String photoUrl;
  final String username;
  final List<String> groupIds;

  const User({
    required this.username,
    required this.userId,
    required this.photoUrl,
    required this.email,
    required this.groupIds,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      userId: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      groupIds: List<String>.from(snapshot["groupIds"] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": userId,
        "email": email,
        "photoUrl": photoUrl,
        "groupIds": groupIds,
      };
}
