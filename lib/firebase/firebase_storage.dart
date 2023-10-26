import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final String? uid;
  StorageMethods({this.uid});

  // reference for our collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  // adding image to firebase storage
  Future<String> storageUploadImage(
      String childName, Uint8List file, bool isPost) async {
    // creating location to our firebase storage

    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    // putting in uint8list format -> Upload task like a future but not future
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future storageCreateGroup(String id, String userName, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add(
      {
        "groupName": groupName,
        "groupIcon": "",
        "admin": "${id}_$userName",
        "members": [],
        "groupId": "",
        "recentMessage": "",
        "posts": [],
      },
    );
    // update group members
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${id}_$userName"]),
      "groupId": groupDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }

  storageGetPosts(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("posts")
        .orderBy("datePublished", descending: true)
        .snapshots();
  }

  storageGetUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  storageGetGroupMembers(groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  Future<bool> storageIsUserJoined(
      String groupName, String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> getUserByEmail(String email) async {
    try {
      QuerySnapshot querySnapshot =
          await userCollection.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        // User found, return the first matching document
        return querySnapshot.docs.first['uid'];
      } else {
        // User not found
        return null;
      }
    } catch (e) {
      // Handle errors here
      debugPrint('Error: $e');
      return null;
    }
  }

  Future<String?> getProfilePictureById(String userId) async {
    try {
      QuerySnapshot querySnapshot =
          await userCollection.where('uid', isEqualTo: userId).get();

      if (querySnapshot.docs.isNotEmpty) {
        // User found, return the first matching document
        return querySnapshot.docs.first['photoUrl'];
      } else {
        // User not found
        return null;
      }
    } catch (e) {
      // Handle errors here
      debugPrint('Error: $e');
      return null;
    }
  }

  Future<String?> getUserNameById(String userId) async {
    try {
      QuerySnapshot querySnapshot =
          await userCollection.where('uid', isEqualTo: userId).get();

      if (querySnapshot.docs.isNotEmpty) {
        // User found, return the first matching document
        return querySnapshot.docs.first['username'];
      } else {
        // User not found
        return null;
      }
    } catch (e) {
      // Handle errors here
      debugPrint('Error: $e');
      return null;
    }
  }

  Future storageAddUserToGroup(
      String userId, String userName, String groupId, String groupName) async {
    DocumentReference userDocumentReference = userCollection.doc(userId);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

    // if user has our groups -> then remove then or also in other part re join
    if (!groups.contains("${groupId}_$groupName")) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${userId}_$userName"])
      });
    }
  }

  Future storageToggleGroupJoin(
      String groupId, String userName, String groupName) async {
    // doc reference
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

    // if user has our groups -> then remove then or also in other part re join
    if (groups.contains("${groupId}_$groupName")) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_$userName"])
      });
    } else {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }

  storageCreatePost(String groupId, Map<String, dynamic> postData) async {
    groupCollection.doc(groupId).collection("posts").add(postData);
  }
}
