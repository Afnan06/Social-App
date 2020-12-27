import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/Models/user.dart';
import 'package:social_app/Screens/LogInProcess/authenticate.dart';
import 'package:social_app/Screens/LogInProcess/login.dart';
import 'package:social_app/Screens/LogInProcess/signup.dart';

import 'Home/home.dart';
class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user= Provider.of<USER>(context);
    print(user);

    if (user==null){
    return Authenticate();
    }else{
      return Home();
    }

  }
}