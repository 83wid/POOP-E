import 'package:poopingapp/Controllers/userController.dart';

Future<Map<String, dynamic>> waterTodayProps() async {
  final data = await UserController.getProp('waterDrank');
  final waterAmount = await UserController.getProp('waterAmount');
  final today = DateTime.now()
      .toString()
      .substring(0, DateTime.now().toString().indexOf(' '));
  if (data[today] == null) {
    await UserController.createProp('waterDrank.$today', {
      'waterTarget': waterAmount,
      'waterDrunk': '0',
    });
    return {
      'waterTarget': waterAmount,
      'waterDrunk': '0',
    };
  }
  return data[today];
}

Future<Map<String, dynamic>> waterPropsof(date) async {
  final data = await UserController.getProp('waterDrank');
  return data[date];
}

Future<Map<String, dynamic>> waterAllProps() async {
  return await UserController.getProp('waterDrank');
}
