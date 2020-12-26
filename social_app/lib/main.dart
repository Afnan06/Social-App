import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/Screens/LogInProcess/login.dart';

import 'package:social_app/Screens/LogInProcess/signup.dart';
import 'package:social_app/Screens/wrapper.dart';
import 'package:social_app/Services/auth.dart';
import 'package:social_app/chat/ChatScreen.dart';
import 'package:social_app/chat/FireUsers.dart';

import 'Models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<USER>.value(
      value: AuthService().user,
        child: MaterialApp(
        //home: Wrapper(),
          routes: {
                           '/':(context) => Wrapper(),"/users":(context)=>fireUsersS(),"/chat":(context)=>chatscreen()

        //                       '/signup':(context) => SignUp(),

   
        //                       // '/location':(context) => Choose_Location(),
                            },
        
      ),
    );
  }
}

