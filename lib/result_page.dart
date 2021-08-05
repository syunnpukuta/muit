import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/detail_page.dart';
import 'package:flutter_app/tourist_area_data.dart';
import 'package:flutter_app/tourist_area_widget.dart';
import 'package:http/http.dart' as http;

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
        backgroundColor: Color(0xff30d9a8),
      ),
      body: Center(
        child: StreamBuilder<String>(
          stream: _controller.stream,
          builder: (context, snapshot) {
            if(snapshot.connectionState != ConnectionState.waiting && snapshot.data == "timeout"){
              return Center(child: Text("取得に失敗しました\nIDを確認してください"));
            }
            if(list.length == 0){
              return Center(child: CircularProgressIndicator(),);
            }
            return ListView(
              children: list
                  .map((e) => TouristAreaWidget(e))
                  .map((e) => GestureDetector(
                      child: e,
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

  Future getRes() async {
    await Future.forEach(List.generate(10, (index) => index), (element) async {

      http.get(Uri.parse("https://script.google.com/macros/s/AKfycbxOorM_dr1VF2yrf_P5mkQzyeP6l5zftr-E4HqfudbStFx9XwC63zQeU8QPqgcrZsjqUw/exec"
          "?id=${widget.data}&i=$element"),)
      .then((value){
        print(value.body);
        list.add(TouristAreaData(json.decode(value.body)));
        list.sort((a, b)=>(b.score - a.score).ceil());
        _controller.add("");
      })
         .catchError((e) {
        print(e.toString());
        _controller.add("timeout");
      }).timeout(
        Duration(seconds: 20),
        onTimeout: (){
          print("timeout");
          _controller.add("timeout");
        }
      );

    });



  }

}