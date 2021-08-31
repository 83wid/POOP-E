import 'package:flutter/material.dart';
import 'package:poopingapp/Controllers/userController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poopingapp/screens/Setup_screens/setMeds.dart';

class SetWaterScreen extends StatefulWidget {
  SetWaterScreen({Key? key}) : super(key: key);

  @override
  _SetWaterScreenState createState() => _SetWaterScreenState();
}

class _SetWaterScreenState extends State<SetWaterScreen> {
  TextEditingController water = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/water.svg',
                width: MediaQuery.of(context).size.width / 1.1,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              Text(
                'Enter Your daily Target of Drinking Water',
                style: TextStyle(
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontSize: 14),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / (1.2 * 2),
                    height: MediaQuery.of(context).size.height / (15),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: water,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      validator: (_value) {
                        if (_value.toString() == '') return 'Enter a value';
                        if (double.parse(_value.toString()) > 4) {
                          return 'Too much to your heath';
                        }
                        if (double.parse(_value.toString()) < 1) {
                          return 'You can do more';
                        }
                        return '';
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: '0.0',
                        suffixText: 'L / Day',
                        hintStyle: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontSize: 20),
                        suffixStyle: TextStyle(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async => {
                      if (1 <= double.parse(water.text) &&
                          double.parse(water.text) <= 4)
                        {
                          UserController.createProp('waterAmount', water.text),
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SetMedsScreen();
                          })),
                          print('water stored'),
                        }
                      else
                        {print('water not stored')}
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF2b1605),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: MediaQuery.of(context).size.height / (15),
                      width: MediaQuery.of(context).size.width / (1.2 * 2),
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
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / (5)),
            ],
          ),
        ),
      ),
    );
  }
}
