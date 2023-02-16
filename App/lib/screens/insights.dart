import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:countup/countup.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ShopInsights extends StatefulWidget {
  const ShopInsights({super.key});

  @override
  State<ShopInsights> createState() => _ShopInsightsState();
}

class _ShopInsightsState extends State<ShopInsights> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('01/02', 1350),
      _ChartData('02/02', 1280),
      _ChartData('03/02', 1134),
      _ChartData('04/02', 3200),
      _ChartData('05/02', 1400),
      _ChartData('06/02', 2400),
      _ChartData('07/02', 3800)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Insights',
      theme: ThemeData(primaryColor: Colors.blueGrey[900]),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Insights'),
          centerTitle: true,
          backgroundColor: Color(0xff307A59),
        ),
        body: Column(
          children: [
            Container(
                height: 180,
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Lottie.asset('assets/lottie/insights.json',
                      fit: BoxFit.fill),
                )),
            Container(
              height: 130,
              decoration: BoxDecoration(
                  color: Color(0xff307A59),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 1,
                    ),
                    Column(
                      children: [
                        Text(
                          "TODAY'S REVENUE",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        Row(
                          children: [
                            Text(
                              'Rs ',
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Countup(
                              begin: 0,
                              end: 1200,
                              duration: Duration(seconds: 3),
                              separator: ',',
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Countup(
                              begin: 0,
                              end: 15,
                              duration: Duration(seconds: 3),
                              separator: ',',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              ' Orders',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ), //get todays order
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "WEEK SO FAR",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        Row(
                          children: [
                            Text(
                              'Rs ',
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Countup(
                              begin: 0,
                              end: 12050,
                              duration: Duration(seconds: 3),
                              separator: ',',
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Countup(
                              begin: 0,
                              end: 55,
                              duration: Duration(seconds: 3),
                              separator: ',',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              ' Orders',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ), //get weeks order
                      ],
                    ),
                    SizedBox(
                      width: 1,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis:
                      NumericAxis(minimum: 0, maximum: 5000, interval: 500),
                  tooltipBehavior: _tooltip,
                  series: <ChartSeries<_ChartData, String>>[
                    BarSeries<_ChartData, String>(
                      dataSource: data,
                      xValueMapper: (_ChartData data, _) => data.x,
                      yValueMapper: (_ChartData data, _) => data.y,
                      name: 'Income',
                      color: Color(0xff307A59),
                    )
                  ]),
            ),
          ],
        ),
      ));
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
