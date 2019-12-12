
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginPage1 extends StatefulWidget {
  LoginPage1({this.onSignIn});
  final Function(FirebaseUser) onSignIn;  

  @override
  _LoginPage1State createState() => _LoginPage1State(mySignIn: onSignIn);
}

class _LoginPage1State extends State<LoginPage1> {
  String _valueHP = "";
  String _valueOTP = "0";
  String _actualCode;
  String _textButton = "Selanjutnya >>";
  String _labelText = "No Handphone";
  bool otpReady = false;

  final FocusNode _nodeText1 = FocusNode();

  final Function(FirebaseUser) mySignIn;
  _LoginPage1State({this.mySignIn});
  


  final TextEditingController _textController = new TextEditingController();

  Widget PrefixOnTextbox() {
    return !otpReady
        ? Text("+62", style: TextStyle(color: Colors.white))
        : null;
  }

  void _valueHpOtp(String value) {
    //_valueOTP == "0" ? _valueHP = value : _valueOTP = value;

    if (_valueOTP == "0") {
      setState(() {
        _valueHP = value;
      });
    } else {
      setState(() {
        _valueOTP = value;
      });
    }
    //print(value);
  }

  Future _waitSMS() async {
    await SmsAutoFill().listenForCode;
  }

  Future<void> _returnOTPPhone() async {
    var firebaseAuth = FirebaseAuth.instance;

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this._actualCode = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {};

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {};

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential auth) {};

    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: _valueHP,
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout).then((onValue){
          //print(onValue);
          print ("here");
        });

   

    setState(() {
      _textButton = "Masuk >>";
      _labelText = "Masukan OTP dari SMS anda";
    });
  }

  Future _signInWithPhoneNumber() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    AuthCredential _authCredential = PhoneAuthProvider.getCredential(
        verificationId: _actualCode, smsCode: _valueOTP);

    try {
      final FirebaseUser _user =
          (await _auth.signInWithCredential(_authCredential)).user;
      mySignIn(_user);
    } catch (e) {
      print("error sign in : " + e.toString());
    }
  }

  void _selanjutnyaButton() {
    setState(() {
      if (_valueOTP == "0") {
        _valueHP = '+62' + _valueHP;
        _valueOTP = "";
        otpReady = true;
        _returnOTPPhone();
      } else {
        _signInWithPhoneNumber();
      }

      _textController.clear();

      print("nohp: " + _valueHP);
      print("nootp: " + _valueOTP);
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Theme.of(context).primaryColor,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'images/basar2.png',
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Text(
                    "Masuk",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  //SizedBox(width: 350, child: textHpOTP()),
                  SizedBox(
                    width: 350,
                    child: !otpReady
                        ? TextField(
                            keyboardType: TextInputType.number,
                            focusNode: _nodeText1,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            controller: _textController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0)),
                              labelStyle: TextStyle(color: Colors.white),
                              labelText: _labelText,
                              prefix: PrefixOnTextbox(),
                            ),
                            onChanged: _valueHpOtp,
                          )
                        :  PinFieldAutoFill(
                            //currentCode: "", // prefill with a code""
                            keyboardType: TextInputType.number,
                            onCodeSubmitted: (value) {
                              _valueHpOtp(value);
                              print(value);
                            }, //code submitted callback

                            codeLength: 6 //code length, default 6
                            ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    child: Text(_textButton),
                    color: Theme.of(context).buttonColor,
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _selanjutnyaButton,
                  ),
                   RaisedButton(
                    child: Text("ready sms"),
                    color: Theme.of(context).buttonColor,
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _waitSMS,
                  ),
                ],
              ),
            )));
  }
}
