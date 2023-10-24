import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String title;
  final String postId;
  final String datePublished;
  final String postUrl;

  const Post({
    required this.description,
    required this.uid,
    required this.title,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      description: snapshot["description"],
      uid: snapshot["uid"],
      title: snapshot["title"],
      postId: snapshot["postId"],
      datePublished: snapshot["datePublished"],
      postUrl: snapshot['postUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "title": title,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
      };
}
