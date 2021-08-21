import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:poopingapp/screens/getStarted.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

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
    if (user?.email != null && user?.displayName != null) {
      setState(() {
        email = user?.email.toString();
        name = user?.displayName.toString();
      });
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
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
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return GetStartedScreen();
  }));
}
