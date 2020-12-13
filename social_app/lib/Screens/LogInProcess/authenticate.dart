import 'package:flutter/material.dart';
import 'package:social_app/Screens/LogInProcess/login.dart';
import 'package:social_app/Screens/LogInProcess/signup.dart';
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn=true;
  void toggleView(){
    setState(() {
      showSignIn= !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showSignIn){
      return LogIn(toggleView: toggleView);
    }else{
      return SignUp(toggleView: toggleView);
    }
  
  }
}