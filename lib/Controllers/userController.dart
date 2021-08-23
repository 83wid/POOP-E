import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final currentUser = FirebaseAuth.instance.currentUser;
final currentUserid = FirebaseAuth.instance.currentUser?.uid;
CollectionReference users = FirebaseFirestore.instance.collection('users');
// final currentUserdata = FirebaseFirestore.instance.collection('users').doc(currentUserid).;

// class Medicine {
//   String medicineName;
//   String medicineType;
//   String medicineAmount;
//   String medicineTakes;
//   Medicine(this.medicineName, this.medicineType, this.medicineAmount, this.medicineTakes);
// }
class User {
  String completed;
  String email;
  Map<String, dynamic> medicine;
  Map<String, dynamic> medicineTakes;
  String name;
  String waterAmount;

  User(this.completed, this.email, this.medicine, this.medicineTakes, this.name,
      this.waterAmount);

  factory User.fromJson(dynamic json) {
    return User(
        json['completed'] as String,
        json['email'] as String,
        json['medicine'] as Map<String, dynamic>,
        json['medicineTakes'] as Map<String, dynamic>,
        json['name'] as String,
        json['waterAmount'] as String);
  }
}

class UserController {
  static Future<void> addUser() {
    return users.doc(currentUser?.uid).set({
      'email': currentUser?.email,
      'name': currentUser?.displayName,
      'completed': false,
    });
  }

  static Future<void> createProp(propName, prop) {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(currentUserid)
        .update({
          propName: prop,
        })
        .then((value) => print(propName + "Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static Future <String?> getProp(propName, {String? takeId}) async {
    final userData = await users.doc(currentUserid).get();
    final userprops = User.fromJson(userData.data());
    // if (propName == 'all') return userprops;
    if (propName == 'name') return userprops.name;
    if (propName == 'email') return userprops.email;
    if (propName == 'waterAmount') return userprops.waterAmount;
    if (propName == 'medicineAmount') return userprops.medicine['medicineAmount'].toString();
    if (propName == 'medicineName') return userprops.medicine['medicineName'].toString();
    if (propName == 'medicineType') return userprops.medicine['medicineType'].toString();
    if (propName == 'medicineTakes' && takeId != null) return userprops.medicineTakes[takeId].toString();
    if (propName == 'completed') return userprops.completed;
  }
}
