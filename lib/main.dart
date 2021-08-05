import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/result_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MUIT-D',
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

 bool isMode = true;
  DateTime _date = new DateTime.now(); //締め切り日
  TimeOfDay _time = new TimeOfDay.now(); //締め切り時間
  TextEditingController resController = TextEditingController();
  TextEditingController controller = TextEditingController();
  String deadLine = "";

  String test = "";

  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        children: [
          Image.asset(
            "assets/home.jpg",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.none,
          ),
          isMode ? createMode() : resultMode(),
        ],
      ),

    );
  }

  Widget createMode(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(64, 16, 64, 16),
      child: ListView(
        children: [
          Container(height: MediaQuery.of(context).size.height/5,),
          Center(child: Text("MUIT - D", style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),)),
          Container(height: MediaQuery.of(context).size.height/5,),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: ()async{
                      DateTime? deadDate = await _selectDate(context);
                      if(deadDate == null) return;
                      TimeOfDay? deadTime = await _selectTime(context);
                      if(deadTime == null) return;
                      debugPrint(deadLine = "${deadDate.year}/${deadDate.month}/${deadDate.day} ${deadTime.hour}:${deadTime.minute.toString().padRight(2, "0")}");
                      setState(() {});
                    },
                    child: Text("締め切り日")
                ),
                Container(width: 16,),
                Text(deadLine=="" ? "未設定" : deadLine),
              ],
            ),
          ),
          Container(height: 16,),
          filledButton("新規作成", onTap: () async {
            showProgressDialog();
            http.Response res = await http.get(
              Uri.parse("https://script.google.com/macros/s/AKfycbyuiiD9f4KZ2EtNMA9xg3vFMBSCFktSsqdtk7SIxtIuvqg4AQXhm2wU05yiEy9j6pei6Q/exec")
            );
            print(res.body);
            Map<String, dynamic> data = jsonDecode(res.body);
            Navigator.pop(context);
            await launch(data["url"]);
          }),
        TextButton(
            onPressed: (){
                setState(() {
                  isMode = !isMode;
                });
              },
              child: Text("結果ページへ", style: TextStyle(color: Colors.white),)
          )
        ],
      ),
    );
  }

  Widget resultMode(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(64.0, 16, 64, 16),
      child: ListView(
        children: [
          Container(height: MediaQuery.of(context).size.height/5,),
          Center(child: Text("MUIT - D", style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),)),
          Container(height: MediaQuery.of(context).size.height/5,),
          TextFormField(
            cursorColor: Color(0xff40e9b8),
            controller: resController,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              filled: true,
              fillColor: Colors.white,
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
              Navigator.push(context, MaterialPageRoute(builder: (c)=>ResultPage("10310805")));
            },
          ),
          TextButton(
            onPressed: (){
              setState(() {
                isMode = !isMode;
              });
            },
            child: Text("新規作成ページへ", style: TextStyle(color: Colors.white),)
          )
        ],
      ),
    );
  }

  void _launchURL() async => await launch(_url);

  //締め切り日の選択
  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2021),
        lastDate: new DateTime.now().add(new Duration(days: 360)),
        // locale: Locale("ja"),
    );
    if(picked != null) setState(() => _date = picked);
    return picked;
  }

  //締め切り時間の選択
  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if(picked != null) setState(() => _time = picked);
    return picked;
  }

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
  void showProgressDialog() {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }


}


