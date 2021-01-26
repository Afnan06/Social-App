import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/Models/user.dart';
import 'package:social_app/Screens/LogInProcess/authenticate.dart';
import 'package:social_app/Screens/LogInProcess/login.dart';
import 'package:social_app/Screens/LogInProcess/signup.dart';
import 'package:social_app/chat/FireUsers.dart';
import 'package:social_app/pages/HomePage.dart';
import 'package:social_app/pages/ProfileSignUp.dart';

import 'Home/home.dart';
import 'LogInProcess/search.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String userIdP;
  var check=[];
  
  

    
    
   getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
var c;
    userIdP = sharedPreferences.getString('id');
    print(userIdP);
     List<DocumentSnapshot> flist = (await FirebaseFirestore.instance
            .collection("Profile Users")
            .where("id",isEqualTo: userIdP)
            .get(GetOptions()))
        .docs;
        print("hello");
        print(flist);
        setState(() {
          check=flist;
        });
    
    
    }
    
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<USER>(context);
    print(user);
    if (user == null) {
      return Authenticate();
    } else {
      getUser();
      print(userIdP);
      if (check.length ==0){
         return ProfileSignUp();

      }
      else{
         return HomePage();

      }
      
     
    }
  }
}
