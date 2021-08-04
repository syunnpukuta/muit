import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_app/result_page.dart';
import 'package:window_location_href/window_location_href.dart';
import 'package:url_launcher/url_launcher.dart';

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
  String _url = "https://www.yahoo.co.jp/";
  bool isMode = true;
  TextEditingController resController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final href = getHref();
    print(href);

    return Scaffold(
      appBar: AppBar(
        title: Text("ホーム",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff30d9a8),
      ),
      body: isMode ? createMode() : resultMode(),

    );
  }

  Widget createMode(){
    return ListView(
      children: [
        TextButton(
          // onPressed: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (c)=>ResultPage(para))
          // ),
            onPressed: (){

              setState(() {
                isMode = !isMode;
              });
            },
            child: Text("結果ページへ")
        )
      ],
    );
  }

  Widget resultMode(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [

          TextFormField(
            cursorColor: Color(0xff40e9b8),
            controller: resController,

            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusColor: Color(0xff40e9b8),
              hintText: "ID",
              contentPadding: const EdgeInsets.all(8.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),

          Container(height: 16,),

          filledButton(
            "結果表示",
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (c)=>ResultPage(para)));
            },
          ),
          TextButton(
            onPressed: (){
              setState(() {
                isMode = !isMode;
              });
            },
              child: Text("新規作成ページへ")
          )
        ],
      ),
    );
  }

  void _launchURL() async =>
      await launch(_url) ;

  // Future<Null> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: _date,
  //       firstDate: new DateTime(2016),
  //       lastDate: new DateTime.now().add(new Duration(days: 360))
  //   );
  //   if(picked != null) setState(() => _date = picked);
  // }


  Widget filledButton(String text, {double height = 48, Function()? onTap,
    double textScaleFactor = 0.9}){
    return Container(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xff30d9a8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(text, style: TextStyle(color: Colors.white),
          textScaleFactor: textScaleFactor,),
        onPressed: onTap,
      ),
    );
  }

}


