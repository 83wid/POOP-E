import 'package:flutter/cupertino.dart';

List<String> type = [
  'Separated hard lumps',
  'Lumpy and sausage like',
  'Sausage shaped with cracks',
  'Like a smooth soft sausge or snake',
  'Soft bolbs, with clear cut edges',
  'Mushy with ragged edges',
  'Liquid, with no solid pieces'
];
List<String> imgtype = [
 'assets/images/type1.png',
 'assets/images/type2.png',
 'assets/images/type3.png',
 'assets/images/type4.png',
 'assets/images/type5.png',
 'assets/images/type6.png',
 'assets/images/type7.png',
];
List<String> color = [
  'Darkned',
  'Dark Brown',
  'Brown',
  'Light Brown',
  'Little Green',
  'Green',
];
List<String> imgcolor = [
 'assets/images/darkned.png',
 'assets/images/darkBrown.png',
 'assets/images/brown.png',
 'assets/images/lightBrown.png',
 'assets/images/littleGreen.png',
 'assets/images/green.png',
];
List<String> smell = [
  'Smelless',
  'Soft Smell',
  'Moderate Smell',
  'Strong Smell',
  'Unbearable Smell',
];
List <String> imgsmell = [
 'assets/images/smelless.png',
 'assets/images/soft.png',
 'assets/images/moderatesmell.png',
 'assets/images/strongSmell.png',
 'assets/images/unbearaleSmell.png',
];
List<String> volume = [
  'Less than normal',
  'Normal',
  'More than normal',
];
List <String> imgvolume = [
  'assets/images/less.png',
  'assets/images/normal.png',
  'assets/images/more.png',
];

List<String> pain = [
  'No pain',
  'Mild pain',
  'Moderate pain',
  'Intense pain',
  'Unbearable pain',
];

List <String> imgpain = [
  'assets/images/noPain.png',
  'assets/images/mildPain.png',
  'assets/images/moderatePain.png',
  'assets/images/intensePain.png',
  'assets/images/unbearablePain.png',
];
List<String> symptoms = [
  'Dizziness',
  'Constipation',
  'Nausea',
  'Tremors',
  'Colic',
  'Chills',
  'Urgency',
];
List<String> duration = ['5 min', '10 min', '15 min', '20 min', '25 min'];

List <String> imgduration = [
  'assets/images/5min.png',
  'assets/images/10min.png',
  'assets/images/15min.png',
  'assets/images/20min.png',
  'assets/images/25min.png',
];

bool blood = false;
bool floatiness = false;
bool flalulence = false;
bool evacuatingStrain = false;
String time = '';

bowlEntries(type, color, smell, volume, pain, symptoms, duration, blood,
        floatiness, flalulence, evacuatingStrain, time) =>
    {
      'type': type,
      'color': color,
      'smell': smell,
      'volume': volume,
      'pain': pain,
      'symptoms': symptoms,
      'duration': duration,
      'blood': blood,
      'floatiness': floatiness,
      'flalulence': flalulence,
      'evacuatingStrain': evacuatingStrain,
      'time': time,
    };
