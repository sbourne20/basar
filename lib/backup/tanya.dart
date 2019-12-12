import 'package:flutter/material.dart';

class tanya extends StatelessWidget {
  final String tanyaText;
  final String tanyaNo;
  
  tanya(this.tanyaText, this.tanyaNo);

  @override
  Widget build(BuildContext context) {
    String tanyaX;

    tanyaX = tanyaText + tanyaNo;
    return Container(
    width: double.infinity,
    margin: const EdgeInsets.all(10.0),
    child: Text(tanyaX, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
    ,
    );
  }
}