import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:poopingapp/Controllers/bowlController.dart';
import 'package:poopingapp/Controllers/userController.dart';
import 'package:poopingapp/screens/getStarted.dart';
import 'package:poopingapp/screens/insertBowl.dart';
import 'package:poopingapp/screens/waterUpdate.dart';
import 'package:poopingapp/utilities/charts.dart';
import 'package:poopingapp/utilities/monthCalendar.dart';
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
          child: SingleChildScrollView(
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
        ),
      )),
      appBar: AppBar(),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
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
                              style: Styles.defaultTextStyleWhite,
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
                                style: Styles.defaultTextStyleWhite,
                              ),
                              FutureBuilder(
                                  future: UserController.getAllProp(),
                                  builder: (context,
                                      AsyncSnapshot<Users?> snapshot) {
                                    List<String> imgs = [
                                      'assets/images/noPain.png',
                                      'assets/images/moderatePain.png',
                                      'assets/images/unbearablePain.png',
                                      'assets/images/intensePain.png',
                                    ];
                                    String image = imgs[0];
                                    if (snapshot.data != null) {
                                      Map<int, dynamic> bowl =
                                          bowlToMap(snapshot.data!.bowlEntries);
                                      if (bowl.length == 0) {
                                        return RichText(
                                            text: TextSpan(
                                                text: '',
                                                style:
                                                    Styles.smallTextStyleWhite,
                                                children: [
                                              TextSpan(
                                                  text: 'No Entries Found',
                                                  style: TextStyle(
                                                      color: Colors.black))
                                            ]));
                                      }
                                      String text = '';
                                      final poopDays =
                                          timeSinceLatepooped(bowl);
                                      text = poopDays > 0
                                          ? "$poopDays days since you last Pooped"
                                          : "Yaay!! You've pooped just Today";
                                      color = poopDays >= 2
                                          ? Colors.yellow
                                          : Colors.green;
                                      color =
                                          poopDays >= 3 ? Colors.orange : color;
                                      color =
                                          poopDays >= 4 ? Colors.red : color;
                                      image = poopDays >= 2 ? imgs[1] : image;
                                      image = poopDays >= 3 ? imgs[3] : image;
                                      image = poopDays > 4 ? imgs[2] : image;
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(image),
                                          Text(''),
                                          RichText(
                                            text: TextSpan(
                                                text: '',
                                                style:
                                                    Styles.smallTextStyleWhite,
                                                children: [
                                                  TextSpan(
                                                      text: text,
                                                      style: TextStyle(
                                                          color: color))
                                                ]),
                                          ),
                                        ],
                                      );
                                      // }
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
                                return WaterUpdateScreen();
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
                monthCalander(context),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 80,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.brown,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 20,
                        child: Center(
                          child: Text(
                            'All your stool entries',
                            style: Styles.defaultTextStyleWhite,
                          ),
                        ),
                      ),
                      FutureBuilder(
                          future: UserController.getAllProp(),
                          builder: (context, AsyncSnapshot<Users?> snapshot) {
                            if (snapshot.data != null) {
                              Map<int, dynamic> bowl =
                                  bowlToMap(snapshot.data!.bowlEntries);
                              return Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height /
                                              (300)),
                                  decoration: BoxDecoration(
                                    color: Colors.brown,
                                  ),
                                  child: bowl.length == 0
                                      ? Center(
                                          child: RichText(
                                            text: TextSpan(
                                                text: '',
                                                style:
                                                    Styles.smallTextStyleWhite,
                                                children: [
                                                  TextSpan(
                                                      text: 'No Entries found',
                                                      style: TextStyle(
                                                          color: Colors.black))
                                                ]),
                                          ),
                                        )
                                      : ListView.builder(
                                          itemCount: bowl.length,
                                          itemBuilder: (context, index) {
                                            return bowlEntry(
                                                context,
                                                bowl[bowl.length - index - 1]
                                                    .value);
                                          },
                                        ),
                                ),
                              );
                            }
                            return Container();
                          }),
                    ],
                  ),
                )
              ],
            ),
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

int timeSinceLatepooped(Map data) {
  if (data.length > 0) {
    final listdayspermonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    final date = DateTime.parse(data.entries.last.value.value['time']);
    if (date.month == DateTime.now().month)
      return DateTime.now().day - date.day;
    return listdayspermonth[date.month] - date.day + DateTime.now().day;
  }
  return 0;
}
