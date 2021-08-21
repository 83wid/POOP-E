import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final currentUser = FirebaseAuth.instance.currentUser;
final currentUserid = FirebaseAuth.instance.currentUser?.uid;
CollectionReference users = FirebaseFirestore.instance.collection('users');

// class Medicine {
//   String medicineName;
//   String medicineType;
//   String medicineAmount;
//   String medicineTakes;
//   Medicine(this.medicineName, this.medicineType, this.medicineAmount, this.medicineTakes);
// }
// class User {
//   String name;
//   String email;
//   bool completed;

//   User(this.name, this.email, this.completed);

//   factory User.fromJson(dynamic json) {
//     return User(json['name'] as String, json['email'] as String, json['completed'] as bool);
//   }
// }

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
}
