import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:poopingapp/Controllers/userController.dart';
import 'package:poopingapp/screens/getStarted.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  TextEditingController water = TextEditingController();
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
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/water.svg',
                width: MediaQuery.of(context).size.width / 1.1,
                fit: BoxFit.contain,
                // color: Colors.blue,
                // matchTextDirection: true,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Text(
                'Enter Your daily Target of Drinking Water',
                style: TextStyle(
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontSize: 14),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / (1.2 * 2),
                    height: MediaQuery.of(context).size.height / (15),
                    child: TextFormField(
                      controller: water,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: '0.0',
                        // show kg
                        suffixText: 'L / Day',
                        hintStyle: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontSize: 20),
                        suffixStyle: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  // TODO: add validator for water amount
                  GestureDetector(
                    onTap: () async => {
                      UserController.createProp('waterAmount', water.text),
                      print('water stored'),

                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return GetStartedScreen();
                      // }))
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Theme.of(context).primaryColor,
                        color: Color(0xFFBC6F2B),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: MediaQuery.of(context).size.height / (15),
                      width: MediaQuery.of(context).size.width / (1.2 * 2),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                          child: Center(
                            child: Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
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
