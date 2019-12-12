import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
HomePage ({this.onSignOut});

final VoidCallback onSignOut;


  void _signOut() async {
    try {
    await FirebaseAuth.instance.signOut();
    onSignOut();
    } catch (e){
      print ("error logout : " + e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            //textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'images/basar_logo.png',
                fit: BoxFit.contain,
                height: 50,
                alignment: Alignment.topLeft,
              ),
              Image.asset(
                'images/drawable-mdpi/Image7.png',
                fit: BoxFit.contain,
                height: 30,
                alignment: Alignment.center,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(35, 0, 0, 0),

                //color: Colors.black,
                alignment: Alignment(1, 0.0),
                width: 150,
                child: Text(
                  "10.000.000",
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            Text("test"),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text("Date Selection"),
              onPressed: (){},
            ),
            RaisedButton(
              child: Text("Login with Phone"),
              onPressed: (){},
            ),
            RaisedButton(
              child: Text("Login with Anonymous"),
              onPressed: (){
                  _signOut();
              },
            ),
          ],
        )));
  }
}