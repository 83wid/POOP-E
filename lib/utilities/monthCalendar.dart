import 'package:flutter/material.dart';
import 'package:poopingapp/Controllers/userController.dart';
import 'package:poopingapp/utilities/styles.dart';

List<int> dayspermonth = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

List daysOfWeek = [
  'Sun',
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
];

Widget monthCalander(context) {
  return FutureBuilder<dynamic>(
      future: UserController.getProp('bowlEntries'),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Column(
            children: List.generate(
                6, (index) => weekCalander(context, index, snapshot.data)),
          );
        }
        return Container();
      });
}

Widget weekCalander(context, i, Map<String, dynamic> data) {
  return i == 0
      ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              7,
              (index) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.brown,
                  ),
                  width: MediaQuery.of(context).size.width / 7.2,
                  height: MediaQuery.of(context).size.height / 25,
                  child: Center(
                    child: Text(
                      daysOfWeek[index],
                      style: Styles.defaultTextStyleWhite,
                    ),
                  ))))
      : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              7, (index) => dayCalander(context, index, i - 1, data)));
}

Widget dayCalander(context, int index, int weekid, Map<String, dynamic> data) {
  final today = DateTime.now();
  int month = today.month;
  final firstDay = DateTime(today.year, today.month, 1);
  Color color = Color(0xFF4f3324);
  int day = 0;
  String imgId = '1';
  if (weekid == 0 && firstDay.weekday > index) {
    color = Colors.grey.shade800;
    month = month != 1 ? month - 1 : 12;
    day = dayspermonth[month] - firstDay.weekday + index + 1;
  } else if (((7 * weekid) + index - firstDay.weekday) < dayspermonth[month]) {
    day = (7 * weekid) + index - firstDay.weekday + 1;
  } else {
    color = Colors.grey.shade800;
    month = month != 12 ? month + 1 : 1;
    day = 7 * weekid + index - dayspermonth[month] - 1;
  }
  final dayData = data[DateTime(today.year, month, day)
      .toString()
      .substring(0, today.toString().indexOf(' '))];
  if (dayData != null) {
    imgId = dayData.entries.first.value['type'];
    // .forEach((key, value) {
    // return (int.parse(value['type']) + 1).toString();
    // });
    print(dayData.entries.first.value['type']);
  }
  return Container(
    decoration: BoxDecoration(
      border: Border.all(),
      color: color,
    ),
    width: MediaQuery.of(context).size.width / 7.2,
    height: MediaQuery.of(context).size.height / 20,
    child: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(children: [
          Text(day.toString()),
        ]),
        dayData != null
            ? Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // color: Colors.brown[100],
                      child: Image.asset('assets/images/type$imgId.png',
                          width: MediaQuery.of(context).size.width / 20,
                          fit: BoxFit.contain),
                    ),
                    dayData.length > 1
                        ? Container(
                            width: MediaQuery.of(context).size.width / 30,
                            height: MediaQuery.of(context).size.width / 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.green,
                            ),
                            child: Center(
                                child: Text(
                                    '+' + (dayData.length - 1).toString(),
                                    style: TextStyle(fontSize: 10))))
                        : SizedBox(height: 0, width: 0)
                  ],
                ),
              )
            : Text(''),
        dayData != null
            ? Container(
                color: Colors.green,
                width: MediaQuery.of(context).size.width / 10,
                height: MediaQuery.of(context).size.width / 200,
              )
            : SizedBox(height: 0),
      ],
    )),
  );
}
