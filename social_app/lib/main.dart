
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:social_app/Screens/LogInProcess/login.dart';
import 'package:social_app/Screens/LogInProcess/search.dart';

import 'package:social_app/Screens/LogInProcess/signup.dart';
import 'package:social_app/Screens/wrapper.dart';
import 'package:social_app/Services/auth.dart';
//import 'package:social_app/chat/ChatScreen.dart';
import 'package:social_app/chat/FireUsers.dart';
import 'package:e3kit/e3kit.dart';

import 'Models/user.dart';
import 'pages/ProfilePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(


      MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<USER>.value(
      value: AuthService().user,
      child: ScreenUtilInit(
        //designSize:MediaQuery.of(context).size,

        child: MaterialApp(
          //builder:DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          //color:Colors.white,
          //home: Wrapper(),
          title: 'Social App',

          theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            dialogBackgroundColor: Colors.black,
            primarySwatch: Colors.grey,
            cardColor: Colors.white70,
            accentColor: Colors.black,
          ),
          routes: {
            //   "/":(context)=>checking()
            '/': (context) => Wrapper(), "/users": (context) => fireUsersS(),"profilepage":(context)=>ProfilePage(),"/search":(context)=>Search()

            //                       '/signup':(context) => SignUp(),

            //                       // '/location':(context) => Choose_Location(),
          },
        ),
      ),
    );
  }
}

