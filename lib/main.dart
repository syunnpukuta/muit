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

  //アプリのテーマカラー
  static const Color mainColor = Color(0xff30d9a8);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _isMode = true;
  DateTime _date = new DateTime.now(); //締め切り日
  TimeOfDay _time = new TimeOfDay.now(); //締め切り時間
  TextEditingController _resController = TextEditingController();
  String _deadLine = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("ホーム",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),
          ),
          centerTitle: true,
          backgroundColor: MyHomePage.mainColor,
        ),
        body: Stack(
          children: [
            //背景画像
            Image.asset(
              "assets/home.jpg",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.none,
            ),

            //モードによって作成画面、結果の入力画面を切り替える
            _isMode ? createMode() : resultMode(),
          ],
        ),

      ),
    );
  }

  //新規作成の画面
  Widget createMode(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(64, 16, 64, 16),
      child: ListView(
        children: [
          title(),

          //締切日の設定
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
                      debugPrint(_deadLine = "${deadDate.year}/${deadDate.month}/${deadDate.day} ${deadTime.hour}:${deadTime.minute.toString().padRight(2, "0")}");
                      setState(() {});
                    },
                    child: Text("締め切り日")
                ),
                Container(width: 16,),
                Text(_deadLine=="" ? "未設定" : _deadLine),
              ],
            ),
          ),
          Container(height: 16,),

          //新規作成のボタン
          filledButton("新規作成", onTap: () async {
            showProgressDialog();
            http.Response res = await http.get(
              Uri.parse("https://script.google.com/macros/s/AKfycbyQPT2V7BmSSah"
                  "_sHTqQ9NNPGJOpVty3UugyLd6qUIX85KDcGNnQJX_o9jzUeXamPf9rA/exec")
            );
            print(res.body);
            Map<String, dynamic> data = jsonDecode(res.body);
            Navigator.pop(context);
            await launch(data["url"]);
          }),

          //結果の画面への切り替え
          TextButton(
            onPressed: (){
                setState(() {
                  _isMode = !_isMode;
                });
              },
              child: Text("結果ページへ", style: TextStyle(color: Colors.white),)
          )
        ],
      ),
    );
  }

  // 結果の画面
  Widget resultMode(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(64.0, 16, 64, 16),
      child: ListView(
        children: [
          title(),

          //IDの入力フォーム
          TextFormField(
            cursorColor: Color(0xff40e9b8),
            controller: _resController,
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

          //結果画面に遷移
          filledButton(
            "結果表示",
            onTap: (){
              FocusScope.of(context).unfocus();
              Navigator.push(context, MaterialPageRoute(builder: (c)=>ResultPage(_resController.text)));
            },
          ),
          TextButton(
            onPressed: (){
              setState(() {
                FocusScope.of(context).unfocus();
                _isMode = !_isMode;
              });
            },
            child: Text("新規作成ページへ", style: TextStyle(color: Colors.white),)
          )
        ],
      ),
    );
  }

  //アプリのタイトル
  Widget title(){
    return Column(
      children: [
        Container(height: MediaQuery.of(context).size.height/5,),
        Center(child: Text("Travel Planner", style: TextStyle(color: Colors.white, fontSize: 43, fontWeight: FontWeight.bold),)),
        Center(child: Text("みんなで決めよう！", style: TextStyle(color: Colors.white, fontSize: 16,),)),
        Container(height: MediaQuery.of(context).size.height/5,),
      ],
    );
  }

  //締め切り日の選択
  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(2021),
        lastDate: new DateTime.now().add(new Duration(days: 360)),
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

  //色が塗られたボタン
  Widget filledButton(String text, {double height = 48, Function()? onTap,
    double textScaleFactor = 0.9}){
    return Container(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: MyHomePage.mainColor,
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

  //処理中のグルグルを画面全体に出す
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


