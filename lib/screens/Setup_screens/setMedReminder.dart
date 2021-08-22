import 'package:flutter/material.dart';
import 'package:poopingapp/Controllers/userController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poopingapp/screens/homeScreen.dart';

Map<int, String> entries = new Map<int, String>();

class SetMedReminderScreen extends StatefulWidget {
  SetMedReminderScreen({Key? key, required this.takes}) : super(key: key);

  final int takes;

  @override
  _SetMedReminderScreenState createState() => _SetMedReminderScreenState();
}

class _SetMedReminderScreenState extends State<SetMedReminderScreen> {
  int index = 0;

  // late List<TextEditingController> takeControllers;
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
  Future<TimeOfDay?> _selectTime() async {
    return await showTimePicker(
      context: context,
      initialTime: _time,
    );
  }

  @override
  Widget build(BuildContext context) {
    // takeControllers =
    //     List.generate(widget.takes, (index) => TextEditingController());
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
                      itemCount: widget.takes,
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
                    // UserController.createProp('medicine', {
                    //   // 'medicineName': medNameController.text,
                    //   // 'medicineType': medTypeController.text,
                    //   // 'medicineAmount': medAmountController.text,
                    //   // 'medicineTakes': MedTakesController.text,
                    // }),
                    if (entries.isNotEmpty)
                      {
                        entries.forEach((key, value) async {
                          await UserController.createProp(
                              'medicineTakes.$key', {
                            key.toString(): value,
                          });
                          // print(key.toString() + ': ' + value);
                        }),
                    UserController.createProp('completed', 'true'),
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return MyHomePage(title: 'tet');
                        })),
                      }
                    // print('water stored'),
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFBC6F2B),
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
              child:takeText(entries[widget.index], widget.index)
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
                    entries[widget.index] =
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

Widget takeText (String? name, index){
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
    value = name;
  }
  return value != '' ? Text(value) : Text(
            takes[index] + ' Take');
}
