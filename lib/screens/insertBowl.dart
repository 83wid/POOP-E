import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poopingapp/Controllers/bowlController.dart';
import 'package:poopingapp/Controllers/userController.dart';
import 'package:poopingapp/utilities/styles.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

List<List<String>> itemsList = [
  type,
  color,
  smell,
  volume,
  pain,
  symptoms,
  duration,
];
List<List<String>> itemsImgList = [
  imgtype,
  imgcolor,
  imgsmell,
  imgvolume,
  imgpain,
  [],
  imgduration,
];
List<String> items = [
  'type',
  'color',
  'smell',
  'volume',
  'pain',
  'symptoms',
  'duration',
  'blood',
  'floatiness',
  'flalulence',
  'evacuatingStrain',
  'time'
];
List<TextEditingController> bowlControllers =
    List.generate(items.length, (index) => TextEditingController());

class InsertBowl extends StatefulWidget {
  InsertBowl({Key? key}) : super(key: key);

  @override
  _InsertBowlState createState() => _InsertBowlState();
}

class _InsertBowlState extends State<InsertBowl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).highlightColor,
        title: const Text('What happened on the toilet?'),
      ),
      body: Container(
          decoration: BoxDecoration(
            color: Color(0xFF645450),
          ),
          alignment: Alignment.center,
          child: Center(
            child: ListView.builder(
              itemCount: items.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index < itemsList.length)
                  return Container(
                    margin: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Theme.of(context).backgroundColor),
                    ),
                    child: Component(
                      id: index,
                      title: items[index],
                      options: itemsList[index],
                      imgs: itemsImgList[index],
                    ),
                  );
                else if (index < items.length - 1)
                  return Container(
                      margin: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).backgroundColor),
                      ),
                      child: MyCheckBox(id: index, title: items[index]));
                else if (index < items.length)
                  return Container(
                    margin: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Theme.of(context).backgroundColor),
                    ),
                    child: TextButton(
                        onPressed: () async {
                          final date = await DatePicker.showDateTimePicker(
                              context,
                              showTitleActions: true,
                              minTime: DateTime(
                                  DateTime.now().year, DateTime.now().month, 1),
                              maxTime: DateTime.now(), onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            print('confirm $date');
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                          setState(() {
                            bowlControllers[11].text = date.toString();
                          });
                        },
                        child: Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: Text(
                                    'Select Time',
                                    style: Styles.smallTextStyleWhite,
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    child: Text(
                                      bowlControllers[11].text != ''
                                          ? bowlControllers[11].text
                                          : DateTime.now().toString(),
                                      style: Styles.smallTextStyleWhite,
                                    )),
                              ]),
                        )),
                  );
                return TextButton(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFBC6F2B),
                    ),
                    height: 50.0,
                    width: double.infinity,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                        child: Center(
                          child: Text(
                            'Record',
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
                  onPressed: () async {
                    if (bowlControllers[11].text == '')
                      setState(() {
                        bowlControllers[11].text = DateTime.now().toString();
                      });
                    final data = bowlEntries(
                      bowlControllers[0].text,
                      bowlControllers[1].text,
                      bowlControllers[2].text,
                      bowlControllers[3].text,
                      bowlControllers[4].text,
                      bowlControllers[5].text,
                      bowlControllers[6].text,
                      bowlControllers[7].text,
                      bowlControllers[8].text,
                      bowlControllers[9].text,
                      bowlControllers[10].text,
                      bowlControllers[11].text,
                    );
                    // print('I' + bowlControllers[11].text + 'I');
                    if (bowlControllers[0].text != '' &&
                        bowlControllers[1].text != '' &&
                        bowlControllers[2].text != '' &&
                        bowlControllers[3].text != '' &&
                        bowlControllers[4].text != '' &&
                        bowlControllers[5].text != '' &&
                        bowlControllers[6].text != '' &&
                        bowlControllers[7].text != '' &&
                        bowlControllers[8].text != '' &&
                        bowlControllers[9].text != '' &&
                        bowlControllers[10].text != '' &&
                        bowlControllers[11].text != '') {
                      final date = bowlControllers[11]
                          .text
                          .substring(0, bowlControllers[11].text.indexOf(' '));
                      await UserController.createProp(
                          'bowlEntries.$date', data);
                      Navigator.pop(context);
                    }
                    // bowlControllers.forEach((element) {
                    //   print(element.text);
                    // });
                  },
                );
              },
            ),
          )),
    );
  }
}

class Component extends StatefulWidget {
  Component({
    Key? key,
    required this.id,
    required this.title,
    required this.options,
    required this.imgs,
  }) : super(key: key);

  final String title;
  final int id;
  final List<String> options;
  final List<String> imgs;
  @override
  _ComponentState createState() => _ComponentState();
}

class _ComponentState extends State<Component> {
  int index = 0;
  String value = '';
  @override
  Widget build(BuildContext context) {
    return ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minLeadingWidth: MediaQuery.of(context).size.width / 2.6,
        leading: new Text(widget.title, style: Styles.smallTextStyleWhite),
        title: new Text(value, style: Styles.smallTextStyleWhite),
        trailing: new Icon(Icons.forward),
        onTap: () {
          print(widget.options.length);
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return ListView.builder(
                    itemCount: widget.options.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).buttonColor
                              ),
                        ),
                        child: ListTile(
                          leading: widget.imgs.length > 0
                              ? Image(
                                  width: MediaQuery.of(context).size.width / 10,
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                    widget.imgs[index],
                                  ))
                              : new Icon(Icons.photo),
                          title: new Text(widget.options[index],
                              style: Styles.smallTextStyleWhite),
                          onTap: () {
                            setState(() {
                              value = widget.options[index];
                              bowlControllers[widget.id].text = value;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      );
                    });
              });
        });
  }
}

class MyCheckBox extends StatefulWidget {
  MyCheckBox({Key? key, required this.title, required this.id})
      : super(key: key);

  final String title;
  final int id;

  // final List<String> options;
  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool value = false;
  @override
  initState() {
    setState(() {
      bowlControllers[widget.id].text = 'false';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width / 1.1,
      // height: MediaQuery.of(context).size.height / 40,
      child: SwitchListTile(
          value: value,
          title: Text(widget.title, style: Styles.smallTextStyleWhite),
          onChanged: (_) => {
                setState(() {
                  value = _;
                  bowlControllers[widget.id].text = _.toString();
                })
              }),
    );
  }
}

Widget myValue(String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(value, style: Styles.smallTextStyleWhite),
      new Icon(Icons.forward),
    ],
  );
}
