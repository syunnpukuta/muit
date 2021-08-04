import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/tourist_area_data.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailPage extends StatefulWidget{

  final TouristAreaData data;

  DetailPage(this.data);

  @override
  State<StatefulWidget> createState() => _DetailState();

}

class _DetailState extends State<DetailPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: body(),
    );
  }

  AppBar appbar(){
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(widget.data.city, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black,),
        onPressed: ()=>Navigator.pop(context),
      ),
    );
  }

  Widget body(){
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Container(
          height: 211,
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: widget.data.image.map((e) =>
                Image.network(e,
                  height: 211,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                )).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 4, 16.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.data.rural),
              Container(height: 10,),
              Text(widget.data.city, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
              Container(height: 10,),
              Text(widget.data.explanation),
              Container(height: 10,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    iconText(Icons.account_balance_outlined, "ジャンル", child: Text(widget.data.genre.toString().replaceAll(RegExp(r"[\[\]]"), ""))),
                    Container(height: 10,),
                    iconText(Icons.volunteer_activism, "料理", child: Text(widget.data.dish.toString().replaceAll(RegExp(r"[\[\]]"), ""))),
                    Container(height: 10,),
                    iconText(Icons.accessibility_new, "できること", child: Text(widget.data.canDo.toString().replaceAll(RegExp(r"[\[\]]"), ""))),
                    Container(height: 10,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget iconText(IconData icon, String text, {Widget? child}){
    child ??= Container();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(icon!=null)Icon(icon, color: Colors.black26, size: 20,),
        if(icon==null)Container(width: 20,),
        Container(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text, style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),),
            child,
            Container(height: 16,),
          ],
        ),
      ],
    );
  }

}