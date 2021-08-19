import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:poopingapp/Controllers/userController.dart';
import 'package:poopingapp/screens/HomeScreen.dart';

class GoogleSignInButton extends StatefulWidget {
  GoogleSignInButton({Key? key, required BuildContext context})
      : super(key: key);
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });

                signInWithGoogle(context);
                setState(() {
                  _isSigningIn = false;
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/images/google_logo.png"),
                      height: 35.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

void signInWithGoogle(BuildContext context) async {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  bool isSignedIn = await _googleSignIn.isSignedIn();

  var firebaseUser = _firebaseAuth.currentUser;

  // after 1st time signin
  if (isSignedIn && firebaseUser != null) {
    print("user name signed in");
    print("display name" + firebaseUser.displayName.toString());
    print("email: ${firebaseUser.email}");
  } else {
    // first-time sign in
    GoogleSignInAccount? signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication? signInAuthentication =
        await signInAccount?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      idToken: signInAuthentication?.idToken,
      accessToken: signInAuthentication?.accessToken,
    );
    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    firebaseUser = userCredential.user;
    UserController.addUser();
    if (firebaseUser != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MyHomePage(title: 'title');
      }));
    }
  }
}

// Future<UserCredential> signInWithGoogle() async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth =
//       await googleUser?.authentication;

//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );

//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }
