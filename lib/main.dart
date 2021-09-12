import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poopingapp/Controllers/medsController.dart';
import 'package:poopingapp/Controllers/userController.dart';
import 'package:poopingapp/screens/Setup_screens/setWaterScreen.dart';
import 'package:poopingapp/screens/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poopingapp/screens/homeScreen.dart';
import 'package:poopingapp/utilities/darkThemeProvider.dart';
import 'package:poopingapp/utilities/notificationManager.dart';
import 'package:provider/provider.dart';
import 'utilities/styles.dart';
import 'dart:isolate';
import 'package:android_alarm_manager/android_alarm_manager.dart';

String name = 'portName';

void takeState() async {
  final int isolateId = Isolate.current.hashCode;
  await Firebase.initializeApp();
  checkTakeState();
  print({'id' : 'meds update', 'isolateId': isolateId});
}

void watercheckState() async {
  final int isolateId = Isolate.current.hashCode;
  if (DateTime.now().hour > 6) {
    await Firebase.initializeApp();

    final drunk = await UserController.getProp('waterDrank').catchError((err) {
      print({'message': err.message, 'id': isolateId});
    });
    final amount =
        await UserController.getProp('waterAmount').catchError((err) {
      print({'message': err.message, 'id': isolateId});
    });
    if (drunk / amount < (DateTime.now().hour - 6) / 12) {
      final notif = NotificationManager();
      notif.showNotificationDaily(
          3,
          'You should drink some water',
          'you out of schedule',
          DateTime.now().hour,
          DateTime.now().minute + 1);
    }
  }
  print({'id': 'water', 'isolateId': isolateId});
}

void checkTakesNotif() async {
  await Firebase.initializeApp();
  final int isolateId = Isolate.current.hashCode;
  final meds = await UserController.getProp('medicine');
  final takes = await getdaymeds(DateTime.now());
  final notif = NotificationManager();
  if (takes.length > 0) {
    int i = 0;
    takes.forEach((key, value) {
      value.forEach((key1, value1) {
        if (compareTime(value1['time']) && value1['taken'] == '0') {
          print(meds[i.toString()]['medicineName'] +
              ' take at ' +
              value1['time'] +
              ' Is running late');
          notif.showNotificationDaily(
              i + int.parse(key1),
              'Medicine running late',
              meds[i.toString()]['medicineName'] +
                  ' take at ' +
                  value1['time'] +
                  ' Is running late',
              DateTime.now().hour,
              DateTime.now().minute + 1);
        }
      });
      i++;
    });
  }
  print({'id': 'meds late', 'isolateId': isolateId});
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await AndroidAlarmManager.initialize();
  await AndroidAlarmManager.periodic(
    const Duration(minutes: 30),
    2,
    checkTakesNotif,
    startAt: DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, DateTime.now().hour, 0),
    exact: true,
    rescheduleOnReboot: true,
    wakeup: true,
  );
  await AndroidAlarmManager.periodic(
    const Duration(minutes: 1),
    1,
    takeState,
    exact: true,
    rescheduleOnReboot: true,
    wakeup: true,
  ).catchError((err) {
    print(err.message);
  });
  await AndroidAlarmManager.periodic(
    const Duration(minutes: 15),
    66,
    watercheckState,
    exact: true,
    rescheduleOnReboot: true,
    wakeup: true,
  ).catchError((err) {
    print(err.message);
  });

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
      // await restTakesState().catchError((err) {
      //   print(err.message);
      // });
      // await checkTakeState().catchError((err) {
      // print(err.message);
      // });

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
        if (snapshot.data!['completed'] == 'true')
          return MyHomePage(title: 'shit');
        if (snapshot.data!['completed'] == 'false') {
          return SetWaterScreen();
        }
      }
      return Center(child: CircularProgressIndicator());
    },
  );
}
