import 'package:basar/app/landing_page.dart';
import 'package:flutter/material.dart';

//void main() {
/*runApp(MaterialApp(
    title: 'Navigation Basics',
    
    home: MyApp(),
  ));*/
//}

void main() => runApp(myMain());

class myMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Basar",
      theme: ThemeData(
        primaryColor: Color.fromRGBO(31, 152, 109, 1),
        buttonColor: Color.fromRGBO(128, 255, 210, 1),
        
      ),
      home: LandingPage(),
    );
  }
}