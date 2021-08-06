import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/detail_page.dart';
import 'package:flutter_app/tourist_area_data.dart';
import 'package:flutter_app/tourist_area_widget.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

//結果ページ
class ResultPage extends StatefulWidget{

  String data;

  ResultPage(this.data);

  @override
  State<StatefulWidget> createState() => _ResultPageState();

}

class _ResultPageState extends State<ResultPage>{

  StreamController<String> _controller = StreamController.broadcast();
  List<TouristAreaData> list = [];

  @override
  void initState() {
    super.initState();
    getRes();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("結果",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
          ),
        ),
        centerTitle: true,
        backgroundColor: MyHomePage.mainColor,
      ),
      body: Center(

        //Streamにデータが流れるたびに再描画
        child: StreamBuilder<String>(
          stream: _controller.stream,
          builder: (context, snapshot) {

            //エラーがでたら、その旨を表示
            if(snapshot.connectionState != ConnectionState.waiting && snapshot.data == "error"){
              return Center(child: Text("取得に失敗しました\nIDを確認してください"));
            }

            //まだデータが１つもないときはグルグルを出す
            if(list.length == 0){
              return Center(child: CircularProgressIndicator(),);
            }

            //観光地のWidgetを並べる
            return ListView(
              children: list
                  .map((e) => TouristAreaWidget(e))
                  .map((e) => GestureDetector(
                      child: e,
                      //タップしたら詳細ページへ遷移
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (c)=>DetailPage(e.data)));
                      },
                    )
                  )
                  .toList(),
            );
          }
        ),
      ),
    );
  }

  //GASから１位から１０位を取得
  Future getRes() async {
    await Future.forEach(List.generate(10, (index) => index), (element) async {
      //１～１０位をまとめて取得
      http.get(Uri.parse("https://script.google.com/macros/s/AKfycbxXwM05RBhDM5"
          "r6V7fuXDnms-TR1oflS_WTnGi1LwtlKSIOGq6sI88hOfFgumcsmhlSyA/exec"
          "?id=${widget.data}&i=$element"),)
      .then((value){
        // 取得し次第スコアでソートし、Streamにデータを流す
        print(value.body);
        list.add(TouristAreaData(json.decode(value.body)));
        list.sort((a, b)=>(b.score - a.score).ceil());
        _controller.add("");
      })
      .catchError((e) {
        print(e.toString());
        _controller.add("error");
      })
      .timeout(
        Duration(seconds: 20),
        onTimeout: (){
          print("timeout");
          _controller.add("error");
        }
      );

    });



  }

}