
import 'package:flutter/material.dart';

Widget navbar(index) {
  final days = ['Today', 'Yesterday', 'The day before'];
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      index != 0 ? Icon(Icons.arrow_back_ios) : Text(''),
      Text(
        days[index],
        style: TextStyle(fontSize: 25, fontFamily: 'Bebas_Neue'),
      ),
      index != 2 ? Icon(Icons.arrow_forward_ios) : Text(''),
    ],
  );
}