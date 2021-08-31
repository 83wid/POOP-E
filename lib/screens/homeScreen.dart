import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:poopingapp/Controllers/bowlController.dart';
import 'package:poopingapp/Controllers/userController.dart';
import 'package:poopingapp/screens/getStarted.dart';
import 'package:poopingapp/screens/insertBowl.dart';
import 'package:poopingapp/utilities/charts.dart';
import 'package:poopingapp/utilities/styles.dart';

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
  Color color = Colors.green;
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
      drawer: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.brown,
              ),
              height: MediaQuery.of(context).size.height / (10),
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Text('Your Name: ' + name,
                      style: Styles.smallTextStyleWhite))),
          SizedBox(
            height: MediaQuery.of(context).size.height / (20),
          ),
          Container(
              decoration: BoxDecoration(
                color: Colors.brown,
              ),
              height: MediaQuery.of(context).size.height / (10),
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Text('Your Email: ' + email,
                      style: Styles.smallTextStyleWhite))),
          SizedBox(
            height: MediaQuery.of(context).size.height / (20),
          ),
          TextButton(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.brown,
                ),
                height: MediaQuery.of(context).size.height / (10),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text('Sign Out', style: Styles.smallTextStyleWhite),
                )),
            onPressed: () => signOut(context: context),
          ),
        ],
      )),
      appBar: AppBar(),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // SizedBox(
              //   height: MediaQuery.of(context).size.height / 40,
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      border: Border.all(
                        color: Color(0xFF4f3324),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width / 2.1,
                    height: MediaQuery.of(context).size.height / 5,
                    child: TextButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/poop.png',
                            width: MediaQuery.of(context).size.width / 5,
                            fit: BoxFit.contain,
                          ),
                          Text(
                            'Record Your Bowl movement',
                            style: Styles.smallTextStyleWhite,
                          ),
                        ],
                      ),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return InsertBowl();
                      })),
                    ),
                  ),
                  // bowl average
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      border: Border.all(
                        color: Color(0xFF4f3324),
                      ),
                      // border: ShapeBorder()
                    ),
                    width: MediaQuery.of(context).size.width / 2.1,
                    height: MediaQuery.of(context).size.height / 5,
                    child: TextButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Frequency for this Month',
                              style: Styles.smallTextStyleWhite,
                            ),
                            FutureBuilder(
                                future: UserController.getAllProp(),
                                builder:
                                    (context, AsyncSnapshot<Users?> snapshot) {
                                  if (snapshot.data != null) {
                                    Map<int, dynamic> bowl =
                                        bowlToMap(snapshot.data!.bowlEntries);
                                    final date = DateTime.now()
                                        .toString()
                                        .substring(0, 10);
                                    int count = 0;
                                    bowl.forEach((key, value) {
                                      if (value['time'].substring(0, 8) ==
                                          DateTime.now()
                                              .toString()
                                              .substring(0, 8)) {
                                        count++;
                                      }
                                    });
                                    print(bowl[date]);
                                    if (count != 0) {
                                      final int days = int.parse(date.substring(
                                          date.length - 2, date.length));
                                      final per = days / count;
                                      String text = '';
                                      if (per == 1) {
                                        text = 'Once per day';
                                        color = Colors.green;
                                      }
                                      if (per > 1) {
                                        text = 'Once per ' +
                                            per.toStringAsFixed(1) +
                                            ' days';
                                        color = per > 2
                                            ? Colors.red
                                            : Colors.yellow;
                                      } else {
                                        text = (1 / per).toStringAsFixed(1) +
                                            ' per day';
                                        color = Colors.green;
                                      }
                                      return RichText(
                                        text: TextSpan(
                                            text: '',
                                            style: Styles.smallTextStyleWhite,
                                            children: [
                                              TextSpan(
                                                  text: text,
                                                  style:
                                                      TextStyle(color: color))
                                            ]),
                                      );
                                    }
                                  }
                                  return Container();
                                })
                          ],
                        ),
                        onPressed: () => null
                        // onPressed: () => Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return InsertBowl();
                        // })),
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      border: Border.all(
                        color: Color(0xFF4f3324),
                      ),
                      // border: ShapeBorder()
                    ),
                    width: MediaQuery.of(context).size.width / 2.1,
                    height: MediaQuery.of(context).size.height / 5,
                    child: GestureDetector(
                        onDoubleTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return InsertBowl();
                            })),
                        child: WaterChart()),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      border: Border.all(
                        color: Color(0xFF4f3324),
                      ),
                      // border: ShapeBorder()
                    ),
                    width: MediaQuery.of(context).size.width / 2.1,
                    height: MediaQuery.of(context).size.height / 5,
                    child: MedsChart(),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 80,
              ),
              FutureBuilder(
                  future: UserController.getAllProp(),
                  builder: (context, AsyncSnapshot<Users?> snapshot) {
                    if (snapshot.data != null) {
                      Map<int, dynamic> bowl =
                          bowlToMap(snapshot.data!.bowlEntries);
                      return Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height / (300)),
                          decoration: BoxDecoration(
                            color: Colors.brown,
                          ),
                          child: ListView.builder(
                            itemCount: bowl.length,
                            itemBuilder: (context, index) {
                              final Map<String, dynamic> item = bowl[index];
                              return bowlEntry(context, item);
                            },
                          ),
                        ),
                      );
                    }
                    return Container();
                  })
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
