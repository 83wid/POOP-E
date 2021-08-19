import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

final currentuser = FirebaseAuth.instance.currentUser;
final currentuserid = FirebaseAuth.instance.currentUser?.uid;
 CollectionReference users = FirebaseFirestore.instance.collection('users');

class UserController {

  static Future<void> addUser() {
    return users.doc(currentuserid).set({
    'email': currentuser?.email,
    'name': currentuser?.displayName,
});
  }
  static Future<void> createProp(propName, prop) {

    // Call the user's CollectionReference to add a new user
    return users
        .doc(currentuserid)
        .update({
          propName: prop,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  // FirebaseAuth.instance.update
}
