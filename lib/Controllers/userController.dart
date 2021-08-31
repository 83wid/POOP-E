import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

userScheme(name, email) => {
      'completed': 'false',
      'email': email,
      'name': name,
      'waterAmount': '0',
      'medicine': {
        'medicineName': '',
        'medicineType': '',
        'medicineTakes': '',
        'medicineAmount': '',
      },
      'medicineTakes': {},
      'bowlEntries': {
        'type': '',
        'color': '',
        'smell': '',
        'volume': '',
        'pain': '',
        'symptoms': '',
        'duration': '',
        'blood': 'false',
        'floatiness': 'false',
        'flalulence': 'false',
        'evacuatingStrain': 'false',
        'time': '',
      },
    };

class Users {
  String completed;
  String email;
  Map<String, dynamic> medicine;
  Map<String, dynamic> medicineTakes;
  Map<String, dynamic> bowlEntries;
  String name;
  String waterAmount;
  String waterDrank;

  Users(this.bowlEntries, this.completed, this.email, this.medicine,
      this.medicineTakes, this.name, this.waterAmount, this.waterDrank);

  factory Users.fromJson(dynamic json) {
    return Users(
        json['bowlEntries'] as Map<String, dynamic>,
        json['completed'] as String,
        json['email'] as String,
        json['medicine'] as Map<String, dynamic>,
        json['medicineTakes'] as Map<String, dynamic>,
        json['name'] as String,
        json['waterAmount'] as String,
        json['waterDrank'] as String);
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

  static Future<String?> getProp(propName, {String? takeId}) async {
    final userprops = await getAllProp();
    // if (propName == 'all') return userprops;
    if (propName == 'name') return userprops.name;
    if (propName == 'email') return userprops.email;
    if (propName == 'waterAmount') return userprops.waterAmount;
    if (propName == 'waterDrank') return userprops.waterDrank;
    if (propName == 'medicineAmount')
      return userprops.medicine['medicineAmount'].toString();
    if (propName == 'medicineTakeNum')
      return userprops.medicine['medicineTakes'].toString();
    if (propName == 'medicineName')
      return userprops.medicine['medicineName'].toString();
    if (propName == 'medicineType')
      return userprops.medicine['medicineType'].toString();
    if (propName == 'medicineTakes' && takeId != null)
      return userprops.medicineTakes[takeId]['time'].toString();
    if (propName == 'completed') return userprops.completed;
  }

  static Future<Users> getAllProp() async {
    final currentUserid = FirebaseAuth.instance.currentUser?.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final userData = await users.doc(currentUserid).get();
    final userprops = Users.fromJson(userData.data());
    return userprops;
  }
}
