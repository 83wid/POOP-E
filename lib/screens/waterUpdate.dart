import 'package:flutter/material.dart';
import 'package:poopingapp/Controllers/userController.dart';
import 'package:poopingapp/Controllers/waterController.dart';
import 'package:poopingapp/utilities/daynav.dart';
import 'package:poopingapp/utilities/styles.dart';
import 'homeScreen.dart';

class WaterUpdateScreen extends StatefulWidget {
  WaterUpdateScreen({Key? key, this.date, this.index}) : super(key: key);
  final date;
  final index;
  @override
  _WaterUpdateScreenState createState() => _WaterUpdateScreenState();
}

class _WaterUpdateScreenState extends State<WaterUpdateScreen> {
  double sip = 0;
  double siped = 0;
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
              navbar(widget.index),
              Image.asset('assets/images/water.png',
                  width: MediaQuery.of(context).size.width / 1.3,
                  fit: BoxFit.contain),
              FutureBuilder<Map>(
                  future: waterPropsof(widget.date),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      if (sip == 0)
                        sip = double.parse(snapshot.data!['waterTarget']);
                      if (snapshot.data!['waterdrunk'] != null)
                        siped = double.parse(snapshot.data!['waterdrunk']);
                      return Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Row(
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
                                              text: sip.toStringAsFixed(2),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 24)),
                                          TextSpan(
                                            text: ' Liters',
                                            style: TextStyle(fontSize: 17),
                                          )
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return ListView(
                                            children: [
                                              ListTile(
                                                  leading: Text('1.5 L'),
                                                  onTap: () {
                                                    setState(() {
                                                      sip = 1.5;
                                                    });
                                                    Navigator.pop(context);
                                                  }),
                                              ListTile(
                                                  leading: Text('2 L'),
                                                  onTap: () {
                                                    setState(() {
                                                      sip = 2;
                                                    });
                                                    Navigator.pop(context);
                                                  }),
                                              ListTile(
                                                  leading: Text('2.5 L'),
                                                  onTap: () {
                                                    setState(() {
                                                      sip = 2.5;
                                                    });
                                                    Navigator.pop(context);
                                                  }),
                                              ListTile(
                                                  leading: Text('3 L'),
                                                  onTap: () {
                                                    setState(() {
                                                      sip = 3;
                                                    });
                                                    Navigator.pop(context);
                                                  }),
                                              ListTile(
                                                  leading: Text('3.5'),
                                                  onTap: () {
                                                    setState(() {
                                                      sip = 3.5;
                                                    });
                                                    Navigator.pop(context);
                                                  }),
                                              ListTile(
                                                  leading: Text('4 L'),
                                                  onTap: () {
                                                    setState(() {
                                                      sip = 4;
                                                    });
                                                    Navigator.pop(context);
                                                  }),
                                            ],
                                          );
                                        });
                                    final drunk =
                                        await waterPropsof(widget.date);

                                    final today = DateTime.now()
                                        .toString()
                                        .substring(
                                            0,
                                            DateTime.now()
                                                .toString()
                                                .indexOf(' '));
                                    drunk['waterTarget'] =
                                        sip.toStringAsFixed(2);
                                    await UserController.createProp(
                                        'waterDrank.$today', drunk);
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Colors.white, // Color(0xFF2b1605),
                                      ),
                                      // height: 50.0,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              (25),
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      child: Center(
                                          child: Text('Modify',
                                              style: TextStyle(
                                                fontFamily: 'Bebas_Neue',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              )))),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                              text: siped == 0
                                                  ? snapshot.data!['waterDrunk']
                                                  : (siped +
                                                          double.parse(snapshot
                                                                  .data![
                                                              'waterDrunk']))
                                                      .toStringAsFixed(2),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 24)),
                                          TextSpan(
                                            text: ' Liters',
                                            style: TextStyle(fontSize: 17),
                                          )
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return ListView(
                                            children: [
                                              ListTile(
                                                  leading: Text('1 L'),
                                                  onTap: () {
                                                    setState(() {
                                                      siped = 1.0;
                                                    });
                                                    Navigator.pop(context);
                                                  }),
                                              ListTile(
                                                  leading: Text('1/2 L'),
                                                  onTap: () {
                                                    setState(() {
                                                      siped = 0.5;
                                                    });
                                                    Navigator.pop(context);
                                                  }),
                                              ListTile(
                                                  leading: Text('1/3 L'),
                                                  onTap: () {
                                                    setState(() {
                                                      siped = 1 / 3;
                                                    });
                                                    Navigator.pop(context);
                                                  }),
                                              ListTile(
                                                  leading: Text('1/4 L'),
                                                  onTap: () {
                                                    setState(() {
                                                      siped = 1 / 4;
                                                    });
                                                    Navigator.pop(context);
                                                  }),
                                              ListTile(
                                                  leading: Text('a Cup'),
                                                  onTap: () {
                                                    setState(() {
                                                      siped = 0.220;
                                                    });
                                                    Navigator.pop(context);
                                                  }),
                                              ListTile(
                                                  leading: Text('a Small cup'),
                                                  onTap: () {
                                                    setState(() {
                                                      siped = 0.1;
                                                    });
                                                    Navigator.pop(context);
                                                  }),
                                              ListTile(
                                                  leading: Text('a Sip'),
                                                  onTap: () {
                                                    setState(() {
                                                      siped = 0.05;
                                                    });
                                                    Navigator.pop(context);
                                                  }),
                                            ],
                                          );
                                        });

                                    final drunk =
                                        await waterPropsof(widget.date);
                                    final today = DateTime.now()
                                        .toString()
                                        .substring(
                                            0,
                                            DateTime.now()
                                                .toString()
                                                .indexOf(' '));
                                    drunk['waterDrunk'] = (siped +
                                            double.parse(drunk['waterDrunk']))
                                        .toStringAsFixed(2);
                                    await UserController.createProp(
                                        'waterDrank.$today', drunk);
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Colors.white, // Color(0xFF2b1605),
                                      ),
                                      // height: 50.0,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              (25),
                                      width:
                                          MediaQuery.of(context).size.width / 5,
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
                          ],
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return CircularProgressIndicator();
                    return Container(
                      child: Center(
                        child: Text('No data Found',
                            style: Styles.defaultTextStyleWhite),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class WaterUpdateListScreen extends StatefulWidget {
  WaterUpdateListScreen({Key? key}) : super(key: key);
  @override
  _WaterUpdateListScreenState createState() => _WaterUpdateListScreenState();
}

class _WaterUpdateListScreenState extends State<WaterUpdateListScreen> {
  double sip = 0;
  double siped = 0;
  Widget build(BuildContext context) {
    return PageView(
      children: List.generate(3, (index) {
        return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: WaterUpdateScreen(
                date: DateTime.now().add(Duration(days: -index)),
                index: index));
      }),
    );
  }
}
