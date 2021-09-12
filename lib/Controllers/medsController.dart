import 'package:poopingapp/Controllers/userController.dart';

class Medicine {
  String medicineName;
  String medicineType;
  String medicineTakes;
  String medicineAmount;
  Medicine(this.medicineName, this.medicineType, this.medicineTakes,
      this.medicineAmount);
}

medSchema(medicineName, medicineType, medicineTakes, medicineAmount) => {
      'medicineName': medicineName,
      'medicineType': medicineType,
      'medicineTakes': medicineTakes,
      'medicineAmount': medicineAmount,
    };

checkTakeState() async {
  if (DateTime.now().add(Duration(hours: -1)).day != DateTime.now().day) {
    bool update = false;
    final takes = await getdaymeds(DateTime.now().add(Duration(hours: -1)));
    if (takes.length > 0) {
      Map<String, dynamic> result = new Map();
      takes.forEach((key, value) {
        result[key] = new Map();
        value.forEach((key1, value1) async {
          result[key][key1] = new Map();
          result[key][key1]['time'] = value1['time'];
          result[key][key1]['taken'] = value1['taken'];

          if (compareTime(value1['time']) && value1['taken'] == '0') {
            update = true;
            result[key][key1]['taken'] = '2';
          }
        });
      });
      if (update) {
        await UserController.createProp('medicineTakes', result);
      }
    }
  }
}

bool compareTime(String time) {
  int hour = int.parse(time.substring(0, time.indexOf(':')));
  int minute = int.parse(time.substring(time.indexOf(':') + 1, time.length));
  if (hour < DateTime.now().hour ||
      (hour == DateTime.now().hour && minute < DateTime.now().minute)) {
    return true;
  }
  return false;
}

Future<Map<String, dynamic>> getdaymeds(DateTime day) async {
  final format = day.toString().substring(0, day.toString().indexOf(' '));

  final allData = await UserController.getAllProp();

  if (allData.medicineTakesEntries[format] != null)
    return allData.medicineTakesEntries[format];
  else {
    final dayData = allData.medicineTakes;
    await UserController.createProp('medicineTakesEntries.$format', dayData);
    return dayData;
  }
}

bool checkMedStatus(data) {
  if (data != null) {
    int i = -1;
    while (++i < data.length) {
      int j = -1;
      while (++j < data[i.toString()].length)
        if (data[i.toString()][j.toString()]['taken'] == '0') return true;
    }
    return false;
  }
  return true;
}
