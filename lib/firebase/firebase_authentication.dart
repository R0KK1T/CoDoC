import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:codoc/models/user.dart' as model;
import 'package:codoc/firebase/firebase_storage.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  // Signing Up User

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required Uint8List file,
  }) async {
    String response = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty || file != null) {
        // register user
        UserCredential userCredentials =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        model.User user = model.User(
          username: username,
          userId: userCredentials.user!.uid,
          photoUrl: photoUrl,
          email: email,
        );

        // adding user in our database
        await _firestore.collection("users").doc(userCredentials.user!.uid).set(
            user.toJson(),
            /* {
              'username': username,
              'user_id': userCredentials.user!.uid,
              'photoUrl'
              'email': email,

            } */);

        response = "success";
      } else {
        response = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return response;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String response = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        response = "success";
      } else {
        response = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return response;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
