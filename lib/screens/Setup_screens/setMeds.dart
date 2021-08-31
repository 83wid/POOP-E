import 'package:flutter/material.dart';
import 'package:poopingapp/Controllers/userController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poopingapp/screens/Setup_screens/setMedReminder.dart';

bool _isNumeric(String? str) {
  if (str == null || str.indexOf('.') != -1) {
    return false;
  }
  return double.tryParse(str) != null;
}

class SetMedsScreen extends StatefulWidget {
  SetMedsScreen({Key? key}) : super(key: key);

  @override
  _SetMedsScreenState createState() => _SetMedsScreenState();
}

class _SetMedsScreenState extends State<SetMedsScreen> {
  int index = 0;
  TextEditingController medNameController = TextEditingController();
  TextEditingController medTypeController =
      TextEditingController(text: 'Liquid');
  TextEditingController medAmountController = TextEditingController();
  TextEditingController medTakesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final hintStyle = TextStyle(
        color: Theme.of(context).textSelectionTheme.selectionColor,
        fontSize: MediaQuery.of(context).size.width / 25);
    final suffixStyle = TextStyle(
        color: Theme.of(context).textSelectionTheme.selectionColor,
        fontSize: MediaQuery.of(context).size.width / 25);
    List<String> medsNames = <String>['Liquid', 'Tablet', 'Capsule'];
    List<Widget> medsList = <Widget>[
      med(context, imgPath: 'assets/images/liquid.png', medType: 'Liquid'),
      med(context, imgPath: 'assets/images/tablet.png', medType: 'Tablet'),
      med(context, imgPath: 'assets/images/capsule.png', medType: 'Capsule'),
    ];
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
                  'assets/images/medshero.svg',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: medNameController,
                          // keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          validator: (_value) {
                            return '';
                          },
                          decoration: InputDecoration(
                            hintText: 'Medicine Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintStyle: hintStyle,
                          )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      child: DropdownButton<Widget>(
                        value: index < 0 ? medsList[0] : medsList[index],
                        items: medsList.map((Widget value) {
                          return DropdownMenuItem<Widget>(
                            value: value,
                            child: Container(
                                width: MediaQuery.of(context).size.width / 2.6,
                                child: value),
                            onTap: () {
                              print('child taped');
                              print(value);
                              setState(() {
                                index = medsList.indexOf(value);
                                print("index: " + index.toString());
                                medTypeController.text = medsNames[index];
                              });
                            },
                          );
                        }).toList(),
                        onTap: () {
                          print('parent taped');
                        },
                        onChanged: (_) {
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / (40)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: medAmountController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        validator: (_value) {
                          return '';
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: '0.0',
                          suffixText: (medTypeController.text == 'Liquid'
                                  ? 'Spon'
                                  : medTypeController.text) +
                              ' / Take',
                          hintStyle: hintStyle,
                          suffixStyle: suffixStyle,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.2,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: medTakesController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        validator: (_value) {
                          if (_isNumeric(_value) == false) {
                            return 'This isn\'t a number';
                          }
                          else if (_value != null && int.parse(_value) > 7)
                            return 'Too much for one Day';
                          return '';
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: '0',
                          suffixText: 'Takes / Day',
                          hintStyle: hintStyle,
                          suffixStyle: suffixStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / (40)),
                GestureDetector(
                  onTap: () async => {
                    UserController.createProp('medicine', {
                      'medicineName': medNameController.text,
                      'medicineType': medTypeController.text,
                      'medicineAmount': medAmountController.text,
                      'medicineTakes': medTakesController.text,
                    }),
                    // UserController.createProp('completed', 'true'),
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SetMedReminderScreen(
                        takes: int.parse(medTakesController.text),
                      );
                    })),
                    print('water stored'),
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
                SizedBox(height: MediaQuery.of(context).size.height / (5)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget med(context, {required imgPath, required medType}) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(
      medType,
      style: TextStyle(
          color: Theme.of(context).textSelectionTheme.selectionColor,
          fontSize: MediaQuery.of(context).size.width / 25),
    ),
    Image(
        width: MediaQuery.of(context).size.width / 20,
        fit: BoxFit.contain,
        image: AssetImage(imgPath)),
  ]);
}
