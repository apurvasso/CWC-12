import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:/CWC-12/ProductDataModel.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<ProductDataModel> _chartData;
  late TrackballBehavior _trackballBehavior;
  @override
  void initState() {
    _chartData =
        readJsonData() as List<ProductDataModel>; //chartdata to jsondata
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SfCartesianChart(
        title: ChartTitle(text: 'AAPL - 2016'), //CharTitle(text: 'AAPL - 2016')
        legend: Legend(isVisible: true),
        trackballBehavior: _trackballBehavior,
        series: <HiloOpenCloseSeries>[
          HiloOpenCloseSeries<ProductDataModel, DateTime>(
              dataSource: _chartData,
              name: 'AAPL',
              xValueMapper: (ProductDataModel sales, _) => sales.date,
              lowValueMapper: (ProductDataModel sales, _) => sales.low,
              highValueMapper: (ProductDataModel sales, _) => sales.high,
              openValueMapper: (ProductDataModel sales, _) => sales.open,
              closeValueMapper: (ProductDataModel sales, _) => sales.close)
        ],
        primaryXAxis: DateTimeAxis(dateFormat: DateFormat.MMM()),
      ),
    ));
  }

  // ignore: non_constant_identifier_names
  Future<List<ProductDataModel>> readJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('jsonD/stock_list.json');
    final list = json.decode(jsondata) as List<dynamic>;
    List<ProductDataModel> productDataList = list
        .map<ProductDataModel>((json) => ProductDataModel.fromJason(json))
        .toList();

    return productDataList; //list.map((e) => ProductDataModel.fromJson(e)).toList();
  }
  // Future<ProductDataModel> readJsonData() async {
  //   var response = await http.get(
  //     //http://api.marketstack.com/v1/
  //     Uri.parse(
  //         'https://api.polygon.io/v2/aggs/ticker/AAPL/range/1/day/2020-06-01/2020-06-17?apiKey=slzf3Z2Lp4TMl6RS60glUp0Ug_9RJt8o'),
  //     headers: {
  //       //2d807e70d2d15a403bd7981c66c986d5
  //       HttpHeaders.authorizationHeader: 'slzf3Z2Lp4TMl6RS60glUp0Ug_9RJt8o',
  //     },
  //   );
  //   final rrresponse = jsonDecode(response.body);
  //   return ProductDataModel.fromJason(rrresponse);

  //return productDataList; //list.map((e) => ProductDataModel.fromJson(e)).toList();
}
