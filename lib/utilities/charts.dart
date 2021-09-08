import 'package:flutter/material.dart';
import 'package:poopingapp/Controllers/userController.dart';
import 'package:poopingapp/Controllers/waterController.dart';
import 'package:poopingapp/screens/medsListing.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WaterChart extends StatelessWidget {
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: waterTodayProps(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.data != null) {
            final amount = double.parse(snapshot.data!['waterTarget']);
            final drank = double.parse(snapshot.data!['waterDrunk']);
            final still = amount - drank;
            final List<_WaterData>? waterData = [
              _WaterData('To drink', still, still.toStringAsFixed(2) + ' L'),
              _WaterData('Drank', drank, '$drank L'),
            ];
            return Center(
                child: SfCircularChart(
                    title: ChartTitle(
                        text: 'Water record for today',
                        textStyle:
                            TextStyle(fontFamily: 'Bebas_Neue', fontSize: 14)),
                    legend: Legend(
                      isVisible: true,
                    ),
                    series: <PieSeries<_WaterData, String>>[
                  PieSeries<_WaterData, String>(
                      explode: true,
                      explodeIndex: 1,
                      dataSource: waterData,
                      xValueMapper: (_WaterData data, _) => data.xData,
                      yValueMapper: (_WaterData data, _) => data.yData,
                      dataLabelMapper: (_WaterData data, _) => data.text,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle:
                            TextStyle(fontFamily: 'Bebas_Neue', fontSize: 10),
                      )),
                ]));
          }
          return Container();
        });
  }
}

class _WaterData {
  _WaterData(this.xData, this.yData, [this.text]);
  final String? xData;
  final num yData;
  final String? text;
}

final List<String> img = [
  'assets/images/medstake.png',
  'assets/images/medsTaken.png',
  'assets/images/medsNtaken.png',
];

class MedsChart extends StatelessWidget {
  final data = [
    _SalesData('22', 12.0),
    _SalesData('22', 2.0),
  ];
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserController.getAllProp(),
        builder: (context, AsyncSnapshot<Users> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            final today = DateTime.now()
                .toString()
                .substring(0, DateTime.now().toString().indexOf(' '));
            final Map<String, dynamic> takesData =
                snapshot.data!.medicineTakesEntries[today];
            if (takesData.length > 0) {
              // print('tkaes: ');
              // print(takesData.length);
              return Container(
                width: MediaQuery.of(context).size.width / 6.4,
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: generate(
                        context, takesData, img, snapshot.data!.medicine)),
              );
            }
          }
          return Container();
        });
  }
}

Widget takeitem(context, Map<String, dynamic> item, List<String> img) {
  final String imgPath = img[int.parse(item['taken'])];
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFF4f3324),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Color(0xFF4f3324),
      ),
    ),
    margin: new EdgeInsets.symmetric(
      vertical: MediaQuery.of(context).size.height / (600),
      horizontal: MediaQuery.of(context).size.height / (600),
    ),
    padding: new EdgeInsets.symmetric(
      vertical: MediaQuery.of(context).size.height / (300),
      horizontal: MediaQuery.of(context).size.height / (300),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(imgPath,
            width: MediaQuery.of(context).size.width / 15, fit: BoxFit.contain),
        Text(item['time']),
      ],
    ),
  );
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

List<Widget> generate(context, takesData, img, medsdata) {
  return new List.generate(takesData.length, (index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MedsListScreen(
                      data: medsdata[index.toString()],
                      medId: index.toString(),
                    )));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(''),
          RichText(
            text: TextSpan(
                text: '',
                style: TextStyle(fontFamily: 'Bebas_Neue', fontSize: 16),
                children: [
                  TextSpan(
                      text: medsdata[index.toString()]['medicineName'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).highlightColor)),
                  TextSpan(
                    text: ' Takes for Today',
                  ),
                ]),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2.1,
            height: MediaQuery.of(context).size.height / 6.5,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: takesData[index.toString()].length,
                itemBuilder: (context, idex) {
                  // print(takesData[idex.toString()]);
                  return takeitem(context,
                      takesData[index.toString()][idex.toString()], img);
                }),
          ),
        ],
      ),
    );
  });
}
