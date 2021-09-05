import 'package:flutter/material.dart';
import 'package:poopingapp/Controllers/medsController.dart';
import 'package:poopingapp/Controllers/userController.dart';
import 'package:poopingapp/screens/Setup_screens/setMedReminder.dart';
import 'package:poopingapp/screens/homeScreen.dart';
import 'package:poopingapp/utilities/charts.dart';
import 'package:poopingapp/utilities/styles.dart';

final prop = [
  'medicineName',
  'medicineType',
  'medicineTakes',
  'medicineAmount'
];
final doseScale = {
  'Liquid': 'spon',
  'Tablet': 'Tablet',
  'Capsule': 'capsule',
};

class MedsListScreen extends StatefulWidget {
  MedsListScreen({Key? key, required this.data, required this.medId})
      : super(key: key);
  final data;
  final medId;
  @override
  _MedsListScreenState createState() => _MedsListScreenState();
}

class _MedsListScreenState extends State<MedsListScreen> {
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
            height: MediaQuery.of(context).size.height,
            color: Colors.brown,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Center(
                child: medicineInfo(context, widget.data, widget.medId))),
      ),
    );
  }
}

Widget header(context, data) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(height: MediaQuery.of(context).size.height / 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 10,
              child: Center(
                  child: Text('Medicine Name: ',
                      style: Styles.defaultTextStyleWhite))),
          Container(
              height: MediaQuery.of(context).size.height / 10,
              child: Center(
                  child: Text(data[prop[0]],
                      style: Styles.defaultTextStyleWhite))),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 10,
              child: Center(
                  child: Text('Medicine Type: ',
                      style: Styles.defaultTextStyleWhite))),
          Container(
              height: MediaQuery.of(context).size.height / 10,
              child: Text(data[prop[1]], style: Styles.defaultTextStyleWhite)),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 10,
              child: Center(
                  child: Text('Medicine Dose: ',
                      style: Styles.defaultTextStyleWhite))),
          Container(
              height: MediaQuery.of(context).size.height / 10,
              child: Text(data[prop[3]] + ' ' + doseScale[data[prop[1]]],
                  style: Styles.defaultTextStyleWhite)),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 10,
              child: Center(
                  child: Text('Medicine takes: ',
                      style: Styles.defaultTextStyleWhite))),
          Container(
              height: MediaQuery.of(context).size.height / 10,
              child: Text(data[prop[2]] + ' takes',
                  style: Styles.defaultTextStyleWhite)),
        ],
      ),
    ],
  );
}

Widget medicineInfo(context, data, id) {
  return FutureBuilder<Users>(
      future: UserController.getAllProp(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          final Map<String, dynamic> takes = snapshot.data!.medicineTakes;
          return Column(
            children: [
              header(context, data),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: takes[id].length,
                  itemBuilder: (context, ind) {
                    return GestureDetector(
                        child:
                            takeitem(context, takes[id][ind.toString()], img),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.brown,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('Update you take',
                                            style:
                                                Styles.defaultTextStyleWhite),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                                onPressed: () async {
                                                  if (takes[id][ind.toString()]
                                                          ['taken'] !=
                                                      '1') {
                                                    takes[id][ind.toString()]
                                                        ['taken'] = '2';
                                                    await UserController
                                                        .createProp(
                                                            'medicineTakes',
                                                            takes);
                                                  }
                                                },
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            35,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.brown[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Center(
                                                        child: Text('Skip')))),
                                            TextButton(
                                                onPressed: () async {
                                                  takes[id][ind.toString()]
                                                      ['taken'] = '1';
                                                  await UserController
                                                      .createProp(
                                                          'medicineTakes',
                                                          takes);
                                                  Navigator.pop(context);
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MedsListScreen(
                                                                  data: data,
                                                                  medId: id)));
                                                },
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            8,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            35,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.brown[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Center(
                                                        child: Text('Take')))),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        });
                  }),
              SizedBox(height: MediaQuery.of(context).size.height / 10),
              TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SetMedReminderScreen(
                              data: new Medicine(
                                data['medicineName'],
                                data['medicineType'],
                                data['medicineTakes'],
                                data['medicineAmount'],
                              ),
                              medId: id,
                            ))),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF2b1605),
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                      child: Center(
                        child: Text(
                          'Modify',
                          style: TextStyle(
                            color: Colors.white,
                            // fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
          //   },
          // );
        }
        return Container();
      });
}
