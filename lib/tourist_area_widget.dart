import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/tourist_area_data.dart';
import 'package:like_button/like_button.dart';

class TouristAreaWidget extends StatefulWidget{

  final TouristAreaData data;

  TouristAreaWidget(this.data);

  @override
  State<StatefulWidget> createState() => _TouristAreaWidgetState();

}

class _TouristAreaWidgetState extends State<TouristAreaWidget>{


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1.0,
              blurRadius: 10.0,
            ),
          ],

        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 16),
          child: Column(
            children: [
              top(),
              Align(child: photoList(), alignment: Alignment.center,),
              Container(height: 10,),
              Row(
                children: [
                  Text("${widget.data.rural} / ${widget.data.genre.toString().replaceAll(RegExp(r"[\[\]]"), "")}"),
                  Expanded(child: Container()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget top(){
    return Padding(
      padding: const EdgeInsets.only(bottom:8.0),
      child: Row(
        children: [
          Text(widget.data.city, textScaleFactor: 1.3, style: TextStyle(fontWeight: FontWeight.bold),),
          Expanded(child: Container()),
          LikeButton(
            isLiked: false,
            size: 28,
            onTap: (f) async{
              return !f;
            },
          ),
        ],
      ),
    );
  }

  Widget photoList(){
    return Container(
      height: 160,
      child: Center(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: widget.data.image.map((e) =>
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image.network(e, height: 160,)
                    ),
                    if(e != widget.data.image.last)
                      Container(width: 10,)
                  ],
                )
            ).toList(),
          ),
        ),
      ),
    );
  }



}