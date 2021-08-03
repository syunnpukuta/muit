import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/tourist_area_data.dart';
import 'package:flutter_app/tourist_area_widget.dart';
import 'package:window_location_href/window_location_href.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MUIT Result',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'MUIT'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String para = "[{"
      "\"rural\":\"関西\","
  "\"city\": \"京都\","
  "\"genre\": [\"水族館\", \"舞妓\"],"
  "\"dish\":[\"和食\"],"
  "\"canDo\":[\"寺巡り\"],"
  "\"image\":[\"https://picsum.photos/250?image=9\"],"
  "\"explanation\": \"寺も回れるキレイな町並みです。\""
  "},"
      "{"
      "\"rural\":\"関西\","
      "\"city\": \"京都\","
      "\"genre\": [\"水族館\", \"舞妓\"],"
      "\"dish\":[\"和食\"],"
      "\"canDo\":[\"寺巡り\"],"
      "\"image\":[\"https://picsum.photos/250?image=9\"],"
      "\"explanation\": \"寺も回れるキレイな町並みです。\""
      "}]";


  @override
  Widget build(BuildContext context) {
    final href = getHref();
    print(href);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: (jsonDecode(para) as List)
                .map((e) => TouristAreaData(e))
                .map((e) => TouristAreaWidget(e))
                .toList(),
        ),
      ),
    );
  }
}
