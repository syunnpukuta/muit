import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/tourist_area_data.dart';

void main() {
  runApp(MyApp());

  TouristAreaData(
      "{"
          "\"rural\":\"関西\","
          "\"city\": \"京都\","
          "\"genre\": [\"水族館\", \"舞妓\"],"
          "\"dish\":[\"和食\"],"
          "\"canDo\":[\"寺巡り\"],"
          "\"image\":[\"https://msp.c.yimg.jp/images/v2/FUTi93tXq405grZVGgDqG7Nl8NPWUjOSXbEzJJqdxSW6EZY7URlnw5YxI6uj0UTuiifkRVSoTpFXzs52zSRnTFKhGOOT4JO2vNncN8rsSdDTDi9fayW6-nvcAMSb0B-4JX3IUsg8M3zFgcVb9PlfJ0XQZ5SMoOGkIqPNuQxm7rmnv5SaTHLSUQF04ywNAKCpA1RoYU9F2aSjAUh5BvF51rqW9vYjedFL_RtM7rND0efii9BWDz03kAS6caQO0k4AefGApbi3MqoKXC5PGsSSZHmuQPm4X_fEknIch4eqpAakkWRH-YzsVi7Jx1oxBzs6n9w75wTQTa9mIjvmcU3cfR-7YsXEmnsqEncwMxaTscKIqLMA6RyNQDfIlr4-WosJgJpfUCNSmmupG-V0U4mU4_sJGhupJ3XEnHAxP_fP27JTN2h2luPDPdvcT30BDCF2DWTfuAuhyTWBeJJSzbfpwxm45ncKa_d5Q5HoJVkmvdaDZNRaifXhNCs_BugWVA5o/a2000423_main.jpg\"],"
          "\"explanation\": \"寺も回れるキレイな町並みです。\""
          "}"
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MUIT Result',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'errgegr'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
