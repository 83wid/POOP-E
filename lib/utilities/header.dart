import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
              image: AssetImage('assets/images/logo.png'),
              width: 40.0,
              fit: BoxFit.contain),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
