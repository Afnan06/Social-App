import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
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
 bool showpassword=true;
 bool obscure=false;

  @override
  Widget build(BuildContext context) {
   return loading ? Loading(): Scaffold(

        body:
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
                  Align(
                    alignment:Alignment.center,

                      child:
                      Padding(
                        padding:EdgeInsets.only(
                          top:ScreenUtil().setSp(130)
                        ),
                        //top:30,
                           child: SizedBox(height:ScreenUtil().setHeight(90),width:ScreenUtil().setWidth(100),child: Image.asset("images/app_icon.jpeg",))
                      )),
                  Center(child:Text("CHAT APP",style:TextStyle(color:Colors.blue[900],fontSize:ScreenUtil().setSp(14)),),),
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
                  Padding(
                    padding:EdgeInsets.only(
                      right:ScreenUtil().setSp(25),
                      left:ScreenUtil().setSp(25),
                    ),
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
                                        borderSide: BorderSide(
                                            color: HexColor("#f2f3f7"),
                                            width: 2),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(40.0),
                                        ),
                                      ),
                                      labelText:"Enter Your Email",

                                      fillColor:HexColor("#f2f3f7"),
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
                                  obscureText: obscure,
                                  decoration:InputDecoration(
                                    isDense: true,
                                      border:OutlineInputBorder(
                                            borderSide: BorderSide(
                                             color: HexColor("#f2f3f7"),
                                                       width: 2),
                                       // borderSide: HexColor("#f2f3f7"),
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(40.0),
                                        ),
                                      ),
                                      labelText:"Password",

                                      fillColor:HexColor("#f2f3f7"),
                                      suffixIcon:showpassword?IconButton(icon: Icon(Icons.visibility), onPressed: (){
                                              setState(() {
                                                showpassword=false;
                                                obscure=true;

                                              });
                                           }):IconButton(icon:Icon(Icons.visibility_off),onPressed: (){
                                             setState(() {
                                               showpassword=true;
                                               obscure=false;
                                             });
                                             },)
        ,

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
                                Padding(
                                  padding: EdgeInsets.only(
                               // left:ScreenUtil().setSp(16),right:ScreenUtil().setSp(16),

                                ),
                                  child: SizedBox(height:ScreenUtil().setHeight(48),width:double.infinity,



                                    child:RaisedButton(
                                      shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(40),
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
                                ),

                                SizedBox(
                                  height:10,
                                ),
                                   Text(error,style:TextStyle(color:Colors.red[700]),),
                                   SizedBox(height: 10,),



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

  }
}
