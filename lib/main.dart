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
    return ListView(
      children: [
        TextButton(
            onPressed: _launchURL,
            child: Text("結果表示")
        ),
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
            child: Text("新規作成ページへ")
        )
      ],
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


}


