import 'package:poopingapp/Controllers/userController.dart';
// import 'package:poopingapp/utilities/notificationManager.dart';

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

restTakesState() async {
  final map = await UserController.getProp('medicineTakes');
  if (map.length > 0) {
    Map<String, dynamic> result = new Map();
    map.forEach((key, value) {
      result[key] = new Map();
      value.forEach((key1, value1) {
        result[key][key1] = new Map();
        result[key][key1]['time'] = value1['time'];
        result[key][key1]['taken'] = '0';
      });
    });
    await UserController.createProp('medicineTakes', result);
  }
}

checkTakeState() async {
  bool update = false;
  final meds = await UserController.getProp('medicine');
  final takes = await UserController.getProp('medicineTakes');
  if (takes.length > 0) {
    Map<String, dynamic> result = new Map();
    int i = 0;
    takes.forEach((key, value) {
      result[key] = new Map();
      value.forEach((key1, value1) async {
        result[key][key1] = new Map();
        result[key][key1]['time'] = value1['time'];
        result[key][key1]['taken'] = value1['taken'];

        if (compareTime(value1['time']) && value1['taken'] == '0') {
          update = true;
          result[key][key1]['taken'] = '2';
          print(meds[i.toString()]['medicineName'] +
              ' take at ' +
              value1['time'] +
              ' Is running late');
              // final notif = NotificationManager();
          // notif.showNotificationDaily(
          //     1,
          //     'Medicine running late',
          //     meds[i.toString()]['medicineName'] +
          //         ' take at ' +
          //         value1['time'] +
          //         ' Is running late',
          //     DateTime.now().hour,
          //     DateTime.now().minute + 1);
        
        }
      });
      i++;
    });
    if (update) {
      await UserController.createProp('medicineTakes', result);
    }
  }
}

bool compareTime(String time) {
  int hour = int.parse(time.substring(0, 2));
  int minute = int.parse(time.substring(3, time.length));
  if (hour < DateTime.now().hour ||
      (hour == DateTime.now().hour && minute < DateTime.now().minute)) {
    return true;
  }
  return false;
}
