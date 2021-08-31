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
String imgblood = 'assets/images/blood.png';
String imgstrain = 'assets/images/constipation.png';
String imgflutelance = 'assets/images/fart.png';
String imgfloatiness = 'assets/images/float.png';
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
List<String> imgsmell = [
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
List<String> imgvolume = [
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

List<String> imgpain = [
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

List<String> imgduration = [
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
Map<int, dynamic> bowlToMap(Map<String, dynamic> bowl) {
  final data = new Map<int, dynamic>();
  int i = 0;
  bowl.forEach((key, value) {
    value.forEach((key, value) {
      data[i++] = value;
    });
  });
  return data;
}

Widget bowlEntry(BuildContext context, item) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color(0xFF4f3324),
    ),
    height: MediaQuery.of(context).size.height / (15),
    margin: new EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height / (600)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(''),
        Text(
          item['time'].substring(0, item['time'].indexOf(' ')) +
              ' at' +
              item['time'].substring(
                  item['time'].indexOf(' '), item['time'].indexOf(' ') + 6),
        ),
        Image.asset(imgpain[int.parse(item['pain'])],
            width: MediaQuery.of(context).size.width / 15, fit: BoxFit.contain),
        Image.asset(imgtype[int.parse(item['type'])],
            width: MediaQuery.of(context).size.width / 15, fit: BoxFit.contain),
        Image.asset(imgcolor[int.parse(item['color'])],
            width: MediaQuery.of(context).size.width / 15, fit: BoxFit.contain),
        Image.asset(imgsmell[int.parse(item['smell'])],
            width: MediaQuery.of(context).size.width / 15, fit: BoxFit.contain),
        Image.asset(imgvolume[int.parse(item['volume'])],
            width: MediaQuery.of(context).size.width / 15, fit: BoxFit.contain),
        Image.asset(imgduration[int.parse(item['duration'])],
            width: MediaQuery.of(context).size.width / 15, fit: BoxFit.contain),
        if (item['blood'] == 'true')
          Image.asset(imgblood,
              width: MediaQuery.of(context).size.width / 15,
              fit: BoxFit.contain),
        if (item['floatiness'] == 'true')
          Image.asset(imgfloatiness,
              width: MediaQuery.of(context).size.width / 15,
              fit: BoxFit.contain),
        if (item['flalulence'] == 'true')
          Image.asset(imgflutelance,
              width: MediaQuery.of(context).size.width / 15,
              fit: BoxFit.contain),
        if (item['evacuatingStrain'] == 'true')
          Image.asset(imgstrain,
              width: MediaQuery.of(context).size.width / 15,
              fit: BoxFit.contain),
        Text(''),
      ],
    ),
  );
  
}
