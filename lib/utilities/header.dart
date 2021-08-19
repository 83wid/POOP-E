import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Header extends StatelessWidget {
  Widget build(BuildContext context) {
    final isDarkTheme = SchedulerBinding.instance?.window.platformBrightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
              image: isDarkTheme 
              ? AssetImage('assets/images/logo_dark.png')
              : AssetImage('assets/images/logo.png'),
              width: 40.0,
              fit: BoxFit.contain),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
