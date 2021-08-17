import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poopingapp/utilities/styles.dart';
import 'package:poopingapp/screens/getStarted.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<AssetImage> _imageList = [
    AssetImage(
      'assets/images/onboarding0.jpg',
    ),
    AssetImage(
      'assets/images/onboarding1.jpg',
    ),
    AssetImage(
      'assets/images/onboarding2.jpg',
    ),
  ];

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];

    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFFBC6F2B),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _imageList[_currentPage],
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                          image: AssetImage('assets/images/logo.png'),
                          width: 40.0,
                          fit: BoxFit.contain),
                      _currentPage != _numPages - 1
                          ? Container(
                              // alignment: Alignment.centerRight,
                              height: 40.0,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _currentPage = _numPages - 1;
                                  });
                                  print('Skip');
                                  },
                                child: Text(
                                  'Skip',
                                  style: TextStyle(
                                    color: Color(0xFFBC6F2B),
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(height: 40.0),
                    ],
                  ),
                ),
                Container(
                  height: 600.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 300.0),
                            RichText(
                              text: TextSpan(
                                text: 'ALWAYS\n',
                                style: kTitleStyle,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'TRACK',
                                    style: TextStyle(color: Color(0xFFBC6F2B)),
                                  ),
                                  TextSpan(text: ' POOP'),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Track and analyse your bowel movements easily.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 300.0),
                            RichText(
                              text: TextSpan(
                                text: 'GET STATISTICS\nFOR EACH ',
                                style: kTitleStyle,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'bowel movements',
                                    style: TextStyle(color: Color(0xFFBC6F2B)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Monitor your daily bowel movements, right down to descriptive poop details, and volume...',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 300.0),
                            RichText(
                              text: TextSpan(
                                text: 'GET NOTIFIED\n',
                                style: kTitleStyle,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'EVERY DAY',
                                    style: TextStyle(color: Color(0xFFBC6F2B)),
                                  ),
                                  TextSpan(text: ' FOR PILLS & BOWEL'),
                                ],
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Grab the best deals and discounts around and save on your every order.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xFFBC6F2B),
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? GestureDetector(
              onTap: () => {
                print('Get started'),
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return GetStartedScreen();
                }))
              },
              child: Container(
                height: 50.0,
                width: double.infinity,
                color: Color(0xFFBC6F2B),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                    child: Center(
                      child: Text(
                        'Get started',
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
          : Text(''),
    );
  }
}
