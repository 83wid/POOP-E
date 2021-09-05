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
// import 'dart:isolate';
// import 'dart:ui';

// String portname = 'portName';
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
  // ReceivePort port = new ReceivePort();
  // @override
  // void initState()  {
  //   super.initState();
  // }
  // initIsolate() {
  //   if(!IsolateNameServer.registerPortWithName(port.sendPort, portname))
  //   {
  //     throw "Unable to register $port with $portname";
  //   }
  // }
  // @override
  // void dispose() {
  //   super.dispose();
  //   IsolateNameServer.removePortNameMapping(portname);
  // }
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
                                      if (bowl.length == 0) {
                                        return RichText(
                                            text: TextSpan(
                                                text: '',
                                                style:
                                                    Styles.smallTextStyleWhite,
                                                children: [
                                              TextSpan(
                                                  text: 'No Entries Yet',
                                                  style: TextStyle(
                                                      color: Colors.black))
                                            ]));
                                      }
                                      // print(bowl[date]);
                                      if (count != 0) {
                                        final int days = int.parse(
                                            date.substring(
                                                date.length - 2, date.length));
                                        final per = days / count;
                                        String text = '';
                                        if (per == 1) {
                                          text = 'Once per day';
                                          color = Colors.green;
                                          image = imgs[0];
                                        }
                                        if (per > 1) {
                                          text = 'Once per ' +
                                              per.toStringAsFixed(1) +
                                              ' days';
                                          color = per > 2
                                              ? Colors.red
                                              : Colors.yellow;
                                          image = per > 2 ? imgs[2] : imgs[1];
                                        } else {
                                          text = (1 / per).toStringAsFixed(1) +
                                              ' times per day';
                                          color = Colors.green;
                                          image = imgs[0];
                                        }
                                        final poopDays =
                                            timeSinceLatepooped(bowl);
                                        if (poopDays > 2) {
                                          text =
                                              "$poopDays days since you last Pooped";
                                          color = poopDays >= 3
                                              ? Colors.orange
                                              : Colors.yellow;
                                          color = poopDays >= 4
                                              ? Colors.red
                                              : color;
                                          image =
                                              poopDays >= 3 ? imgs[3] : imgs[1];
                                          image =
                                              poopDays > 4 ? imgs[2] : image;
                                        }
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset(image),
                                            Text(''),
                                            RichText(
                                              text: TextSpan(
                                                  text: '',
                                                  style: Styles
                                                      .smallTextStyleWhite,
                                                  children: [
                                                    TextSpan(
                                                        text: text,
                                                        style: TextStyle(
                                                            color: color))
                                                  ]),
                                            ),
                                          ],
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
                              // bowl = SplayTreeMap.from(bowl, (a, b) {
                              //   final day1 = DateTime.parse(bowl[a]['time']);
                              //   final day2 = DateTime.parse(bowl[b]['time']);
                              //   if (day1.year > day2.year &&
                              //       day1.month > day2.month &&
                              //       day1.day > day2.day) {
                              //     return 1;
                              //   }
                              //   return -1;
                              // });
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
                                            final Map<String, dynamic> item =
                                                bowl[index];
                                            return bowlEntry(context, item);
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
    final date = DateTime.parse(data.entries.last.value['time']);
    if (date.month == DateTime.now().month)
      return DateTime.now().day - date.day;
    else
      return listdayspermonth[date.month] - date.day + DateTime.now().day;
  }
  return 0;
}
