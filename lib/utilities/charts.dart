import 'package:flutter/material.dart';
import 'package:poopingapp/Controllers/userController.dart';
import 'package:poopingapp/utilities/styles.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class WaterChart extends StatelessWidget {
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getWaterprops(),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.data != null) {
            final amount = double.parse(snapshot.data![0]);
            final drank = double.parse(snapshot.data![1]);
            final still = amount - drank;
            final List<_WaterData>? waterData = [
              _WaterData('To drink', still, '$still L'),
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

Future<List<String>> getWaterprops() async {
  final List<String> data = new List.generate(2, (index) => '');
  final String? drank = await UserController.getProp('waterDrank');
  final String? amount = await UserController.getProp('waterAmount');
  data[0] = amount != null ? amount : '';
  data[1] = drank != null ? drank : '';
  print(data);
  return data;
}

class _WaterData {
  _WaterData(this.xData, this.yData, [this.text]);
  final String? xData;
  final num yData;
  final String? text;
}

class MedsChart extends StatelessWidget {
  final List<String> img = [
    'assets/images/medsTaken.png',
    'assets/images/medsNtaken.png',
  ];
  final data = [
    _SalesData('22', 12.0),
    _SalesData('22', 2.0),
  ];
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Your meds Today',
          style: TextStyle(fontFamily: 'Bebas_Neue', fontSize: 20),
        ),
        Container(
          decoration: BoxDecoration(
            // color: Color(0xFF4f3324),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(0xFF4f3324),
            ),
          ),
          height: MediaQuery.of(context).size.height / 6.4,
          child: Expanded(
            flex: 1,
            child: FutureBuilder(
                future: UserController.getAllProp(),
                builder: (context, AsyncSnapshot<Users?> snapshot) {
                  if (snapshot.data != null) {
                    final Map<String, dynamic> takesData =
                        snapshot.data!.medicineTakes;
                    return ListView.builder(
                        itemCount: takesData.length,
                        itemBuilder: (context, index) {
                          return takeitem(
                              context, takesData[index.toString()], img);
                        });
                  }
                  return Container();
                }),
          ),
        ),
      ],
    ));
  }
}

Widget takeitem(context, Map<String, dynamic> item, List<String> img) {
  final String imgPath = item['taken'] != 'false' ? img[0] : img[1];
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
            width: MediaQuery.of(context).size.width / 12, fit: BoxFit.contain),
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
