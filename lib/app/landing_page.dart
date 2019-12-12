import 'package:basar/app/login/login_page1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

class LandingPage extends StatefulWidget {

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  FirebaseUser _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();    
    
    _updateUser(user);
  }

  void _updateUser(FirebaseUser user) {
    setState(() {
      _user = user;
      _user != null ? 
      print("sudah sign in : " + _user.uid) : _user = null;
      //print("sudah sign in : " + _user.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return LoginPage1(onSignIn: _updateUser);
    }
    return HomePage(
      onSignOut: () => _updateUser(null),
    );
  }
}
