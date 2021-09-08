import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

userScheme(name, email) => {
      'completed': 'false',
      'email': email,
      'name': name,
      'waterAmount': '0',
      'waterDrank': '0',
      'medicine': {},
      'medicineTakes': {},
      'bowlEntries': {},
    };

class Users {
  String completed;
  String email;
  Map<String, dynamic> medicine;
  Map<String, dynamic> medicineTakes;
  Map<String, dynamic> medicineTakesEntries;
  Map<String, dynamic> bowlEntries;
  String name;
  String waterAmount;
  Map<String, dynamic> waterDrank;

  Users(this.bowlEntries, this.completed, this.email, this.medicine,
      this.medicineTakes, this. medicineTakesEntries, this.name, this.waterAmount, this.waterDrank);

  factory Users.fromJson(dynamic json) {
    return Users(
        json['bowlEntries'] as Map<String, dynamic>,
        json['completed'] as String,
        json['email'] as String,
        json['medicine'] as Map<String, dynamic>,
        json['medicineTakes'] as Map<String, dynamic>,
        json['medicineTakesEntries'] as Map<String, dynamic>,
        json['name'] as String,
        json['waterAmount'] as String,
        json['waterDrank'] as Map<String, dynamic>);
  }
}

class UserController {
  static Future<void> addUser() {
    final currentUser = FirebaseAuth.instance.currentUser;
    final currentUserid = currentUser?.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseFirestore.instance.collection('users').doc(currentUserid).get();
    dynamic data = userScheme(currentUser?.displayName, currentUser?.email);
    return users.doc(currentUser?.uid).set(data);
  }

  static Future<void> createProp(propName, prop) {
    final currentUserid = FirebaseAuth.instance.currentUser?.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseFirestore.instance.collection('users').doc(currentUserid).get();
    // Call the user's CollectionReference to add a new user
    return users
        .doc(currentUserid)
        .update({
          propName: prop,
        })
        .then((value) => print(propName + "Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static Future<dynamic> getProp(propName, {String? medId}) async {
    final userprops = await getAllProp();
    // if (propName == 'all') return userprops;
    if (propName == 'name') return userprops.name;
    if (propName == 'email') return userprops.email;
    if (propName == 'waterAmount') return userprops.waterAmount;
    if (propName == 'waterDrank') return userprops.waterDrank;
    if (propName == 'bowlEntries') return userprops.bowlEntries;
    if (propName == 'medicineTakesEntries') return userprops.medicineTakesEntries;
    if (propName == 'medicine' && medId != null)
      return userprops.medicine[medId];
    else if (propName == 'medicine') return userprops.medicine;
    if (propName == 'completed') return userprops.completed;
    if (propName == 'medicineTakes' && medId != null)
      return userprops.medicineTakes[medId];
    else if (propName == 'medicineTakes') return userprops.medicineTakes;
  }

  static Future<Users> getAllProp() async {
    final currentUserid = FirebaseAuth.instance.currentUser?.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final userData = await users.doc(currentUserid).get();
    final userprops = Users.fromJson(userData.data());
    return userprops;
  }
}
