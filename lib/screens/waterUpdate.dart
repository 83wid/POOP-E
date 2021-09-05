import 'package:flutter/material.dart';
import 'package:poopingapp/Controllers/userController.dart';
import 'package:poopingapp/utilities/styles.dart';
import 'homeScreen.dart';

class WaterUpdateScreen extends StatefulWidget {
  WaterUpdateScreen({Key? key}) : super(key: key);
  @override
  _WaterUpdateScreenState createState() => _WaterUpdateScreenState();
}

class _WaterUpdateScreenState extends State<WaterUpdateScreen> {
  double sip = 0;
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(title: 'title')));
        return false;
      },
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.blue),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 200),
              Image.asset('assets/images/water.png',
                  width: MediaQuery.of(context).size.width / 1.3,
                  fit: BoxFit.contain),
              FutureBuilder<Map>(
                  future: waterProps(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Your Daily Target: ',
                                  style: Styles.defaultTextStyleWhite,
                                ),
                                RichText(
                                    text: TextSpan(
                                  text: '',
                                  style: Styles.defaultTextStyleWhite,
                                  children: [
                                    TextSpan(
                                        text: snapshot.data!['waterAmount'],
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 24)),
                                    TextSpan(
                                      text: ' Liters',
                                      style: TextStyle(fontSize: 17),
                                    )
                                  ],
                                )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Your Drunk: ',
                                  style: Styles.defaultTextStyleWhite,
                                ),
                                RichText(
                                    text: TextSpan(
                                  text: '',
                                  style: Styles.defaultTextStyleWhite,
                                  children: [
                                    TextSpan(
                                        text: snapshot.data!['waterDrank'],
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 24)),
                                    TextSpan(
                                      text: ' Liters',
                                      style: TextStyle(fontSize: 17),
                                    )
                                  ],
                                )),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    return Container();
                  }),
              TextButton(
                onPressed: () async {
                  await showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ListView(
                          children: [
                            ListTile(
                                leading: Text('1/2 L'),
                                onTap: () {
                                  setState(() {
                                    sip = 0.5;
                                  });
                                  Navigator.pop(context);
                                }),
                            ListTile(
                                leading: Text('1/3 L'),
                                onTap: () {
                                  setState(() {
                                    sip = 1 / 3;
                                  });
                                  Navigator.pop(context);
                                }),
                            ListTile(
                                leading: Text('1/4 L'),
                                onTap: () {
                                  setState(() {
                                    sip = 1 / 4;
                                  });
                                  Navigator.pop(context);
                                }),
                            ListTile(
                                leading: Text('a Cup'),
                                onTap: () {
                                  setState(() {
                                    sip = 0.220;
                                  });
                                  Navigator.pop(context);
                                }),
                            ListTile(
                                leading: Text('a Small cup'),
                                onTap: () {
                                  setState(() {
                                    sip = 0.1;
                                  });
                                  Navigator.pop(context);
                                }),
                            ListTile(
                                leading: Text('a Sip'),
                                onTap: () {
                                  setState(() {
                                    sip = 0.05;
                                  });
                                  Navigator.pop(context);
                                }),
                          ],
                        );
                      });
                  final drunk = await UserController.getProp('waterDrank');
                  sip = sip + double.parse(drunk);
                  await UserController.createProp(
                      'waterDrank', sip.toStringAsFixed(2));
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white, // Color(0xFF2b1605),
                    ),
                    // height: 50.0,
                    height: MediaQuery.of(context).size.height / (15),
                    // width:MediaQuery.of(context).size.width / 1.3,
                    child: Center(
                        child: Text('Add a sip',
                            style: TextStyle(
                              fontFamily: 'Bebas_Neue',
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            )))),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<Map> waterProps() async {
  return {
    'waterAmount': await UserController.getProp('waterAmount'),
    'waterDrank': await UserController.getProp('waterDrank'),
  };
}
