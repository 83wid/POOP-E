import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poopingapp/Controllers/userController.dart';
import 'package:poopingapp/screens/Setup_screens/setWaterScreen.dart';
import 'package:poopingapp/screens/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poopingapp/screens/homeScreen.dart';
import 'package:poopingapp/utilities/darkThemeProvider.dart';
import 'package:provider/provider.dart';

import 'utilities/styles.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider<DarkThemeProvider>(
    create: (_) => new DarkThemeProvider(),
    child: App(),
  ));
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of your application.
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
  bool _initialized = false;
  bool _error = false;
  // // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
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
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.providerPreferences.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return Center(child: CircularProgressIndicator());
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Center(child: CircularProgressIndicator());
    }
    final email = FirebaseAuth.instance.currentUser?.email;
    return Consumer<DarkThemeProvider>(
      builder: (context, theme, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: Styles.themeData(themeChangeProvider.darkTheme, context),
        home: email != null ? toshow() : OnboardingScreen(),
      ),
    );
  }
}

Widget toshow() {
final currentUserid = FirebaseAuth.instance.currentUser?.uid;
CollectionReference users = FirebaseFirestore.instance.collection('users');
  return FutureBuilder(
    future: users.doc(currentUserid).get(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasError) {
        return Text("Something went wrong");
      }
      if (snapshot.hasData && !snapshot.data!.exists) {
        UserController.addUser();
        return SetWaterScreen();
      }
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.data['completed'] == 'true')
          return MyHomePage(title: snapshot.data['medicine']['medicineTakes']);
        if (snapshot.data['completed'] == 'false') {
          return SetWaterScreen();
        }
      }
      return Center(child: CircularProgressIndicator());
    },
  );
}
