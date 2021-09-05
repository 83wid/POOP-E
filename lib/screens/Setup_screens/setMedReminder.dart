import 'package:flutter/material.dart';
import 'package:poopingapp/Controllers/medsController.dart';
import 'package:poopingapp/Controllers/userController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poopingapp/screens/homeScreen.dart';
import 'package:poopingapp/utilities/notificationManager.dart';

late Map<String, Map<String, dynamic>> entries = new Map();

final manager = NotificationManager();

class SetMedReminderScreen extends StatefulWidget {
  SetMedReminderScreen(
      {Key? key, required this.data, required this.medId, this.oldData})
      : super(key: key);

  final Medicine data;
  final String medId;
  final dynamic oldData;

  @override
  _SetMedReminderScreenState createState() => _SetMedReminderScreenState();
}

class _SetMedReminderScreenState extends State<SetMedReminderScreen> {
  int index = 0;
  String numTakes = '';

  // late List<TextEditingController> takeControllers;
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 00);
  Future<TimeOfDay?> _selectTime() async {
    return await showTimePicker(
      context: context,
      initialTime: _time,
    );
  }

  void initentries() async {
    // final userdata = await UserController.getAllProp();
    int i = -1;
      final items = await UserController.getProp('medicineTakes', medId: widget.medId);
      // print(items[widget.medId]);
      while (++i < int.parse(widget.data.medicineTakes)) {
        setState(() {
          entries[i.toString()] = {'time': '', 'taken': '0'};
          if (items != null && items[widget.medId].length != 0)
            entries[i.toString()] = items[i.toString()];
        });
    }
  }

  @override
  void initState() {
    initentries();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10,
              left: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/images/timer.svg',
                  width: MediaQuery.of(context).size.width / 1.2,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 80),
                Text(
                  'Enter Your Medicine Info',
                  style: TextStyle(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      fontSize: 20),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 40),

                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 4,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: int.parse(widget.data.medicineTakes),
                      itemBuilder: (BuildContext context, int index) {
                        return MedTake(
                          selectTime: _selectTime,
                          index: index,
                          // takeControllers: takeControllers
                        );
                      }),
                ),

                SizedBox(height: MediaQuery.of(context).size.height / (40)),
                // Submit Button:
                GestureDetector(
                  onTap: () async => {
                    if (entries.isNotEmpty)
                      {
                        UserController.createProp(
                                'medicineTakes.${widget.medId}', entries)
                            .then((value) => {
                                  entries.forEach((key, value) async {
                                    final val = value['time'].split(':');

                                    print(widget.data.medicineName +
                                        ' ' +
                                        widget.data.medicineType +
                                        ' ' +
                                        widget.data.medicineAmount);
                                    manager.showNotificationDaily(
                                        int.parse(key),
                                        'Meds to Take' +
                                            widget.data.medicineName,
                                        'Your Dose is: ' +
                                            widget.data.medicineAmount +
                                            ' ' +
                                            widget.data.medicineType +
                                            ' of The Day',
                                        int.parse(val[0]),
                                        int.parse(val[1]));

                                    // print(key.toString() + ': ' + value);
                                  }),
                                  UserController.createProp(
                                      'completed', 'true'),
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return MyHomePage(title: numTakes);
                                  })),
                                }),
                      }
                    // print('water stored'),
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF2b1605),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // height: MediaQuery.of(context).size.height / (15),
                    // width: MediaQuery.of(context).size.width / (1.2 * 2),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MedTake extends StatefulWidget {
  MedTake({
    Key? key,
    required this.selectTime,
    required this.index,
    // required this.time,
    // required this.takeControllers
  }) : super(key: key);

  final int index;
  final selectTime;
  // final TimeOfDay time;
  // final List<TextEditingController> takeControllers;

  @override
  _MedTakeState createState() => _MedTakeState();
}

class _MedTakeState extends State<MedTake> {
  final takes = [
    'Fisrt',
    'Second',
    'Third',
    'Fouth',
    'Fourth',
    'Fifth',
    'Sixth',
    'Seventh',
  ];
  TimeOfDay? time;
  String value = '';
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              // width: MediaQuery.of(context).size.width / 2.2,
              child: takeText(entries[widget.index.toString()], widget.index)
              // style: hintStyle,
              ),
          Container(
            width: MediaQuery.of(context).size.width / 2.2,
            child: ElevatedButton(
              onPressed: () async => {
                time = await widget.selectTime(),
                setState(() {
                  if (time != null) {
                    value = time.toString();
                    entries[widget.index.toString()] = Map();
                    entries[widget.index.toString()]!['taken'] = '0';
                    entries[widget.index.toString()]!['time'] =
                        value.substring(10, value.length - 1);
                  }
                })
              },
              child: Text('SELECT TIME'),
            ),
          ),
        ],
      ),
    );
  }
}

Widget takeText(Map<String, dynamic>? name, index) {
  String value = '';
  final takes = [
    'Fisrt',
    'Second',
    'Third',
    'Fouth',
    'Fourth',
    'Fifth',
    'Sixth',
    'Seventh',
  ];
  if (name != null) {
    value = name['time'];
  }
  return value != '' ? Text(value) : Text(takes[index] + ' Take');
}
