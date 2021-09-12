import 'package:flutter/material.dart';
import 'package:poopingapp/Controllers/medsController.dart';
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
      future: UserController.getAllProp(),
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

Widget weekCalander(context, i, data) {
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
                  height: MediaQuery.of(context).size.height / 20,
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 600,
                    vertical: MediaQuery.of(context).size.width / 600,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 300,
                    vertical: MediaQuery.of(context).size.width / 600,
                  ),
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

Widget dayCalander(context, int index, int weekid, data) {
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
  final daybowlData = data.bowlEntries[DateTime(today.year, month, day)
      .toString()
      .substring(0, today.toString().indexOf(' '))];
  if (daybowlData != null) {
    imgId = daybowlData.entries.first.value['type'];
  }
  // if (month == today.month && day == today.day) {
  //   color = Colors.orange.shade300;
  // }
  return Container(
    decoration: BoxDecoration(
      // borderRadius: BorderRadius.circular(10),
      border: Border.all(
          color: month == today.month && day == today.day
              ? Colors.white
              : Colors.black),
      color: color,
    ),
    width: MediaQuery.of(context).size.width / 7.2,
    height: MediaQuery.of(context).size.height / 20,
    margin: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width / 600,
      vertical: MediaQuery.of(context).size.width / 600,
    ),
    padding: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width / 300,
      vertical: MediaQuery.of(context).size.width / 600,
    ),
    child: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(children: [
          Text(day.toString(),
              style: TextStyle(
                color: month == today.month ? Colors.white : Colors.grey,
              )),
        ]),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bowlData(context, daybowlData, imgId),
              moreBowlToday(context, daybowlData),
              waterData(context, data, today, month, day),
              dayMeds(context, data, today, month, day)
            ],
          ),
        ),
        dayIndicator(context, data, daybowlData, today, month, day)
      ],
    )),
  );
}

Widget waterData(context, allData, today, month, day) {
  final data = allData.waterDrank[DateTime(today.year, month, day)
      .toString()
      .substring(0, today.toString().indexOf(' '))];
  if (data != null &&
      DateTime(today.year, month, day) !=
          DateTime(today.year, today.month, today.day)) {
    final target = double.parse(data['waterTarget']);
    final drunk = double.parse(data['waterDrunk']);
    final image = target - drunk <= 0.05
        ? 'assets/images/waterTargetMet.png'
        : 'assets/images/waterTargetNmet.png';
    return Image.asset(image,
        width: MediaQuery.of(context).size.width / 35, fit: BoxFit.contain);
  }
  return SizedBox(height: 0, width: 0);
}

Widget bowlData(context, daybowlData, imgId) {
  if (daybowlData != null) {
    return Container(
      // color: Colors.brown[100],
      child: Image.asset('assets/images/type${int.parse(imgId) + 1}.png',
          width: MediaQuery.of(context).size.width / 25, fit: BoxFit.contain),
    );
  }
  return SizedBox(height: 0, width: 0);
}

Widget moreBowlToday(context, daybowlData) {
  if (daybowlData != null && daybowlData.length > 1) {
    return Container(
        width: MediaQuery.of(context).size.width / 35,
        height: MediaQuery.of(context).size.width / 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.green,
        ),
        child: Center(
            child: Text('+' + (daybowlData.length - 1).toString(),
                style: TextStyle(fontSize: 8))));
  }
  return SizedBox(height: 0, width: 0);
}

Widget dayMeds(context, allData, today, month, day) {
  if (month < today.month || (month == today.month && today.day > day)) {
    final medsData = allData.medicineTakesEntries[
        DateTime(today.year, month, day)
            .toString()
            .substring(0, today.toString().indexOf(' '))];
    final image = checkMedStatus(medsData)
        ? 'assets/images/medsNtaken.png'
        : 'assets/images/medsTaken.png';
    if (medsData != null)
      return Image.asset(image,
          width: MediaQuery.of(context).size.width / 35, fit: BoxFit.contain);
  }
  return SizedBox(height: 0, width: 0);
}

Widget dayIndicator(context, allData, daybowlData, today, month, day) {
  if (month < today.month || (month == today.month && today.day >= day)) {
    final waterData = allData.waterDrank[DateTime(today.year, month, day)
        .toString()
        .substring(0, today.toString().indexOf(' '))];
    int count = 0;
    final medsData = allData.medicineTakesEntries[
        DateTime(today.year, month, day)
            .toString()
            .substring(0, today.toString().indexOf(' '))];
    final target =
        waterData != null ? double.parse(waterData['waterTarget']) : 2;
    final drunk = waterData != null ? double.parse(waterData['waterDrunk']) : 0;
    final color = month == today.month
        ? [Colors.green, Colors.yellow, Colors.orange, Colors.red]
        : [
            Color(0xff1ea714),
            Color(0xffa2a714),
            Color(0xffa77514),
            Color(0xffa71414)
          ];
    count += daybowlData == null ? 1 : 0;
    count += waterData == null || target > drunk + 0.05 ? 1 : 0;
    count += /*medsData == null || */ checkMedStatus(medsData) ? 1 : 0;
    return Container(
      color: color[count],
      width: MediaQuery.of(context).size.width / 10,
      height: MediaQuery.of(context).size.width / 200,
    );
  }
  return SizedBox(height: 0, width: 0);
}
