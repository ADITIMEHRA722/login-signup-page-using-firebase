import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoadungDailog extends StatelessWidget {


  
  final String? message;
  LoadungDailog({this.message});

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 14),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Color(000047)),
            ),
          ), 
SizedBox(height: 10,),
          Text(message.toString() + " , Please wait..."),
        ],
      ),
    );
    
  }
}