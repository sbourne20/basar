import 'package:flutter/material.dart';

class jawab extends StatelessWidget {
  final Function selectHandler;
  final String jawabText;

  jawab(this.selectHandler, this.jawabText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(child: Text(jawabText),
      color: Colors.blue,
      textColor: Colors.white,
      
      onPressed: selectHandler),
    );
  }
}