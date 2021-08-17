import 'package:flutter/material.dart';
import 'package:poopingapp/screens/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poopingapp/screens/homeScreen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}
class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of your application.
  ////////////////////////////////////////////////////
   bool _initialized = false;
  bool _error = false;
  bool _looged = false;

  // // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      print(e);
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }
  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }
  // ///////////////////////////////////////////////
  // @override
  Widget build(BuildContext context) {
        // Show error message if initialization failed
    if(_error) {
      return Center(child:CircularProgressIndicator());
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Center(child:CircularProgressIndicator());
    }
    final email = FirebaseAuth.instance.currentUser?.email;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: email != null ? MyHomePage(title: 'home') : OnboardingScreen(),//MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
