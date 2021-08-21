import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poopingapp/utilities/styles.dart';
import 'package:poopingapp/utilities/header.dart';
import 'package:poopingapp/utilities/googleSignBotton.dart';

class GetStartedScreen extends StatefulWidget {
  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Header(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '',
                          style: kTitleStyle,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'GET',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            ),
                            TextSpan(
                              text: ' STARTED',
                              style: TextStyle(color: Color(0xFFBC6F2B)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0),
                      RichText(
                        text: TextSpan(
                          text: '',
                          style: kSubtitleStyle,
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  'Track and analyse your bowel movements easily.',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50.0),
                      Center(
                          child: GoogleSignInButton(
                        context: context,
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
