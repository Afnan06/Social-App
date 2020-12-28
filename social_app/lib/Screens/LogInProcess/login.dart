import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Screens/LogInProcess/signup.dart';
import 'package:social_app/Services/auth.dart';
import 'package:social_app/shared/loading.dart';
import 'package:social_app/Models/user.dart';


class LogIn extends StatefulWidget {
   final Function toggleView;
  LogIn({this.toggleView});
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

final AuthService _auth= AuthService();
 final _formkey= GlobalKey<FormState>();
 String email;
 String password;
 String error='';
 bool loading =false;

  @override
  Widget build(BuildContext context) {
   return loading ? Loading(): Scaffold(
     //backgroundColor:Colors.green[700],
//      appBar:
//        PreferredSize(child: AppBar(
//          actions: [
////                      FlatButton.icon(
////            icon:Icon (Icons.person,size:20,),
////            label: Text("Sign up"),
////            onPressed: ()async {
////                       widget.toggleView();
////
////
////                      },
////          )
//
//
//          ],
//
//          title:Text("SocialApp"),backgroundColor:Colors.green[700],bottomOpacity: 0,elevation: 0,
//        ), preferredSize: Size.fromHeight(50),
//
//        ),
        body:
        
//        Container(decoration: BoxDecoration(
//            color:Colors.white,
//            borderRadius:BorderRadius.only(
//              topLeft: Radius.circular(20),topRight: Radius.circular(20)
//              ,        )
//        ),
          //child:
        Stack(
            children: [Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color:Colors.white,borderRadius:BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30))
,


              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("images/back.png"),
              ),
              ),
            ),
              //Image.asset("pics/back.png"),
              ListView(
                children: [
                  //SizedBox(height:10,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 60, 20, 10),
                    child:
                    SizedBox(height:70,width: 60,child: Image.asset("images/app_icon.jpeg",)),
                  ),
                  Center(child:Text("CHAT APP",style:TextStyle(color:Colors.blue[900],fontSize: 12),),),
                  //Text("SPORTREHAPP",style:TextStyle(color:Colors.blue[900],fontSize: 8),),

                  SizedBox(
                    height:30,
                  ),
                  Center(child:
                   Column(children: [
                   Text("SIGN IN",style:TextStyle(fontSize:20,fontWeight:FontWeight.bold),),

                   Text("____",style:TextStyle(color:Colors.green[700]),)

                   ]),

                  ),
                  // Text("Login",style:TextStyle(fontSize:20,fontWeight:FontWeight.bold),),
                  SizedBox(height:3),
                  Padding(padding:EdgeInsets.fromLTRB(20, 1,20, 8),
                      child:
                      Form(
                          key:_formkey,
                          child:
                          Column(
                              children: [
                                SizedBox(height:20,),
                                TextFormField(
                                  decoration:InputDecoration(
                                    isDense:true,
                                      border:OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(40.0),
                                        ),
                                      ),
                                      labelText:"Enter Your Email",
                                      prefixIcon:Icon(
                                        Icons.email,color:Colors.green,)
                                  ),
                                  validator:(val)=>val.isEmpty?"Enter something":null,

    onChanged: (val){
                          setState(() {
                            email=val;
                          });}

                                  ,
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  decoration:InputDecoration(
                                    isDense: true,
                                      border:OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(40.0),
                                        ),
                                      ),
                                      labelText:"Password",
                                      prefixIcon:Icon(
                                        Icons.lock,color:Colors.green,)
                                  ),
                                  validator:(val)=>val.isEmpty?"enter  password":null,
                                    onChanged: (val){
                                      setState(() {
                                        password=val;
                                      });}
                                ),
//                              Row(
//                                children: [
//                                  Checkbox(value:true, onChanged: null),Text("Remember"),SizedBox(width:80,),Text("Forgetpassword")
//                                ],
//                              ),
                                SizedBox(height:9,),
                                SizedBox(width:320,height:48,
                                  child:RaisedButton(
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(30),
                                    ),
                                    onPressed: ()async{
                                      if(_formkey.currentState.validate()){
                                        setState(() {
                                          loading=true;
                                        });
                                        print(email);
                                        print(password);
                                        dynamic result= await _auth.signInWithEmailAndPassword(email, password);
                                        print("my result");
                                        if (result==null){
                                          setState(() {
                                            loading =false;
                                            error="Could'nt sign in with this  email" ;
                                          });
                                        }
                                      }
                                    },
                                    color:Colors.green,
                                    child:Text("LOGIN",
                                      style:TextStyle(color:Colors.white),
                                    ),)
                                  ,),

                                SizedBox(
                                  height:10,
                                ),


                                   Text("if you dont have an account?"),
                                   //Text("SIGNUPHERE",style:TextStyle(color:Colors.green),)


                                GestureDetector(
                                  onTap: ()async{

                                      widget.toggleView();


                                    },

                                    child: Text("SIGNUPHERE",style:TextStyle(color:Colors.green),))

                               // Text("if you dont have an account"),
                              ]
                          ),

                      )  ),
//                  SizedBox(
//                    height:79,
//                  ),
//                  Text("if you dont have an account"),
               ],
              ),
            ],
          ),
        );
     // body:
//      ListView(
//        children:[ Form(
//          key:_formkey,
//          child:Column(
//          children: [
//            Padding(
//              padding: const EdgeInsets.fromLTRB(30, 150, 30, 0),
//              child: Container(
//                child: TextFormField(
//                  decoration: InputDecoration(labelText: 'Enter your email',
//                  //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width:2.0))
//                  ),
//                  validator: (val)=> val.isEmpty ? "Empty email" : null,
//                  onChanged: (val){
//                        setState(() {
//                          email=val;
//                        });}
//                ),
//              ),
//            ),
//            Padding(
//                padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
//                child: Container(
//                    child: TextFormField(
//                  decoration: InputDecoration(labelText: 'Enter PASSWORD'),
//                  validator: (val)=> val.length < 6 ? "pass is of 6 characters" : null,
//                  onChanged: (val){
//                        setState(() {
//                          password=val;
//                        });}
//                ))),
//            Padding(
//              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
//              child: Center(
//                child: Container(
//                    child: RaisedButton(
//                        onPressed: () async {
//                          // dynamic result =await _auth.signinanon();
//                          // print("wh");
//                          // if (result==null){
//                          //   print("error sigining in");
//                          // }
//                          // else{
//                          //   print("success");
//                          //   print(result.uid);
//                          // }
//                          if (_formkey.currentState.validate()){
//                            setState(() {
//                         loading=true;
//                       });
//                       print(email);
//                       print(password);
//                       dynamic result= await _auth.signInWithEmailAndPassword(email, password);
//                       print("my result");
//                       //print(result.user.uid);
//                       if (result==null){
//                         setState(() {
//                           loading =false;
//                           error="Could'nt sign in with this  email" ;
//                         });
//                       }
//                       }
//                        },
//                        textColor: Colors.white,
//                        padding: const EdgeInsets.all(0.0),
//                        child: Container(
//                          decoration: const BoxDecoration(
//                            gradient: LinearGradient(
//                              colors: <Color>[
//                                Color(0xFF0D47A1),
//                                Color(0xFF1976D2),
//                                Color(0xFF42A5F5),
//                              ],
//                            ),
//                          ),
//                          padding: const EdgeInsets.all(10.0),
//                          child: const Text('Gradient Button',
//                              style: TextStyle(fontSize: 20)),
//                        ))),
//              ),
//            ),
//            SizedBox(height: 10),
//                       Text(
//                         error,
//                         style: TextStyle(color: Colors.red, fontSize: 14.0),
//
//                       ),
//
//            Padding(
//              padding: const EdgeInsets.fromLTRB(20, 20, 30, 0),
//              child: Center(
//                  child: Container(child: Text("Don't have an acccount?"))),
//            ),
//            Padding(
//              padding: const EdgeInsets.fromLTRB(0, 10, 30, 0),
//              child: Center(
//                  child: Container(
//                      child: RichText(
//                text: TextSpan(
//                  children: <TextSpan>[
//                    TextSpan(
//                        text: ' Create One!',
//                        style: TextStyle(color: Colors.blue),
//
//                        recognizer: DoubleTapGestureRecognizer()
//                          ..onDoubleTap = () {
//                            print('v');
//
//                            return SignUp() ;
//                          }),
//                  ],
//                ),
//              ))),
//            ),
//          ],
//        ),),
     // ]


  }
}
