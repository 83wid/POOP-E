import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:poopingapp/screens/getStarted.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final user = FirebaseAuth.instance.currentUser;
  var email;
  var name;
  @override
  Widget build(BuildContext context) {
    // final name = user?.displayName.toString();
    if (user?.email != null && user?.displayName != null) {
      setState(() {
        email = user?.email.toString();
        name = user?.displayName.toString();
      });
    }
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(name),
            Text(email),
            Text(
              'You have pushed the button this many times:',
            ),
            TextButton(
              child: Text('Sign Out'),
              onPressed: () => signOut(context: context),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> signOut({required BuildContext context}) async {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  try {
    if (!kIsWeb) {
      await googleSignIn.signOut();
    }
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    Text('Error signing out. Try again.');
    return;
  }
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return GetStartedScreen();
  }));
}
