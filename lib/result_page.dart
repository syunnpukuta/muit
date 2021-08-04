import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/detail_page.dart';
import 'package:flutter_app/tourist_area_data.dart';
import 'package:flutter_app/tourist_area_widget.dart';

class ResultPage extends StatefulWidget{

  String data;

  ResultPage(this.data);

  @override
  State<StatefulWidget> createState() => _ResultPageState();

}

class _ResultPageState extends State<ResultPage>{

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
        child: ListView(
          children: (jsonDecode(widget.data) as List)
              .map((e) => TouristAreaData(e))
              .map((e) => TouristAreaWidget(e))
              .map((e) => GestureDetector(
                  child: e,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>DetailPage(e.data)));
                  },
                )
              )
              .toList(),
        ),
      ),
    );
  }

}