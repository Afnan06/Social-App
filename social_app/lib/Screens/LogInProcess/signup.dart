import 'package:flutter/material.dart';
import 'package:social_app/Screens/LogInProcess/loop.dart';
import 'package:social_app/Services/auth.dart';
import 'package:social_app/shared/loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();

}

class _SignUpState extends State<SignUp> {
//  File imageFile;
//  _getFromGallery() async {
//    PickedFile pickedFile = await ImagePicker().getImage(
//      source: ImageSource.gallery,
////        maxWidth: 1800,
////        maxHeight: 1800,
//    );
//    if (pickedFile != null) {
//      setState(() {
//        imageFile = File(pickedFile.path);
//      });
//    }
//  }

  final AuthService _auth= AuthService();
  final _formkey= GlobalKey<FormState>();
  int dayValue = 1;
  String monthValue = 'January';
  int yearValue = 1981;
  String gender = "Male";
  String country = "Pakistan";

  //text field state
  String fname;
  String lname;
  String email;
  String password;
  String error='';
  String confirmpassword;
  bool loading =false;
  bool showpassword=true;
  bool obscure=false;
  bool showpassword1=true;
  bool obscure1=false;
  File imageFile;
  String pic;
  //File pic;

  @override
  void initState() {
    super.initState();
    //foo_bar(); // first call super constructor then foo_bar that contains setState() call
  }


  @override
  Widget build(BuildContext context) {
//    File imageFile;
    _getFromGallery() async {
      PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
//        maxWidth: 1800,
//        maxHeight: 1800,
      );
      if (pickedFile != null) {
        if (mounted){
                  setState(() {
          imageFile = File(pickedFile.path);
          pic=imageFile.path;
          //imageFile.open(pic)
        });

        }
//        setState(() {
//          imageFile = File(pickedFile.path);
//        });
      }
    }

//    File imageFile;
//    _getFromGallery() async {
//      PickedFile pickedFile = await ImagePicker().getImage(
//        source: ImageSource.gallery,
////        maxWidth: 1800,
////        maxHeight: 1800,
//      );
//      if (pickedFile != null) {
//        setState(() {
//          imageFile = File(pickedFile.path);
//        });
//      }
//    }



    return loading ? Loading(): Scaffold(
//      appBar:
//      PreferredSize(child: AppBar(
//        actions: [FlatButton.icon(
//            icon:Icon (Icons.person,size:20,),
//            label: Text("Sign In"),
//            onPressed: ()async {
//                       widget.toggleView();
//
//
//                      },
//          )
//        ],
//
//        title:Text("SocialApp"),backgroundColor:Colors.green[700],bottomOpacity: 0,elevation: 0,
//      ), preferredSize: Size.fromHeight(50),
//      ),
//      backgroundColor: Colors.green[700],
      body:
      Stack(
        children: [
          Container(
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
//          Positioned(
//            top:ScreenUtil().setSp(87),left:ScreenUtil().setSp(100),
//            child: Image.asset("images/camera1.png",height: 50,),
//          ),
          ListView(
            children:[
              Stack(
                children:[
                  Padding(
                    padding: EdgeInsets.only(top:ScreenUtil().setSp(20)),
                    //const EdgeInsets.all(8.0),
                    child: Center(
                      child: CircleAvatar(
                      radius: 60,
                        backgroundImage:

                (imageFile!=null)?

                      FileImage(imageFile,)
                            :
                AssetImage("images/boy.png",)
                ),
                    ),
                  ),
                  Positioned(
                      top:ScreenUtil().setSp(90),
                      left:ScreenUtil().setSp(193),
                      child:
                      GestureDetector(
                        onTap: (){
                           //pic=imageFile;
                          _getFromGallery();
                        },

                          child: Image.asset("images/camera1.png",height: 45,)))

                 ] ),
              SizedBox(height: ScreenUtil().setSp(20),),

              Center(child:Text("CHAT APP",style:TextStyle(color:Colors.blue[900],fontSize: 12),),),
              SizedBox(
                height:ScreenUtil().setSp(10),
              ),
              Center(child:
               Column(children: [
                Text("SIGN UP",style:TextStyle(fontSize:20,fontWeight:FontWeight.bold),),

                Text("_____",style:TextStyle(color:Colors.green[700]),),
//                 RaisedButton(
//                     onPressed:(){
//                       _getFromGallery();
//                     }
//                   //_imgFromGallery
//                 ),

              ]),


              ),
              Center(
                //padding:EdgeInsets.fromLTRB(10, 10, 10, 10),
                // child: Text("ENTER YOUR INFORMATION")),
                child: Form(
                  key:_formkey,
                  child: Column(children: [

                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                      child: Container(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Enter Your name',isDense: true,prefixIcon:Icon(Icons.person,color:Colors.green,),
                            border:OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: HexColor("#f2f3f7"),
                                  width: 2),

                              borderRadius: const BorderRadius.all(
                                const Radius.circular(40.0),
                              ),
                            ),),
                          validator: (val)=> val.isEmpty? "enter name" : null,
                         // obscureText: true,
                          onChanged: (val){
                            setState(() {
                              fname=val;
                            });

                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                      child: Container(
                        child: TextFormField(

                          decoration: InputDecoration(labelText: 'Enter Last Name',isDense: true,prefixIcon:Icon(Icons.person
                          ,color:Colors.green,
                          ) ,
                            border:OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: HexColor("#f2f3f7"),
                                  width: 2),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(40.0),
                              ),
                            ),),
                          validator: (val)=> val.isEmpty? "enter" : null,
                        //  obscureText: true,
                          onChanged: (val){
                            setState(() {
                              lname=val;
                            });

                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                      child: Container(
                        child: TextFormField(
                            decoration: InputDecoration(labelText: 'Enter Your Email',isDense: true,prefixIcon:Icon(Icons.email
                            ,color:Colors.green,),
                              border:OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: HexColor("#f2f3f7"),
                                    width: 2),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(40.0),
                                ),
                              ),


                            ),
                            validator: (val)=> val.isEmpty ? "Empty email" : null,
                            onChanged: (val){
                              setState(() {
                                email=val;
                              });
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                      child: Container(
                        child: TextFormField(
                          obscureText: obscure,

                          decoration: InputDecoration(labelText: 'Enter Password',isDense: true,
                            prefixIcon:Icon(Icons.lock,color:Colors.green,),
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
                                     },),

                            border:OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: HexColor("#f2f3f7"),
                                  width: 2),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(40.0),
                              ),
                            ),),
                          validator: (val)=> val.length < 6 ? "pass is of 6 characters" : null,
                          //obscureText: obscure,
                          onChanged: (val){
                            setState(() {
                              password=val;
                            });

                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                      child: Container(
                        child: TextFormField(

                          decoration: InputDecoration(labelText: 'Confirm Password',isDense: true,
                            prefixIcon:Icon(Icons.lock,color:Colors.green,),
    suffixIcon:showpassword1?IconButton(icon: Icon(Icons.visibility), onPressed: (){
    setState(() {
    showpassword1=false;
    obscure1=true;

    });
    }):IconButton(icon:Icon(Icons.visibility_off),onPressed: (){
    setState(() {
    showpassword1=true;
    obscure1=false;
    });
    },),


                            border:OutlineInputBorder(

                              borderSide: BorderSide(
                                  color: HexColor("#f2f3f7"),
                                  width: 2),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(40.0),
                              ),
                            ),),
                          validator: (val)=> val != password ? "Wrong password" : null,
                          obscureText: obscure1,
                          onChanged: (val){
                            setState(() {
                              confirmpassword=val;
                            });

                          },
                        ),
                      ),
                    ),
                    Container(
                        child: Row(children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 20, 10, 0),
                              child: Container(
                                  child: DropdownButton<int>(
                                    value: dayValue,
                                    icon: Icon(Icons.arrow_drop_down_outlined),
                                    iconSize: 20,
                                   // elevation: 16,
                                    //style: TextStyle(color: Colors.deepPurple),
//                                    underline: Container(
//                                      height: 2,
//                                      color: Colors.grey,
//                                    ),
                                    onChanged: (int newValue) {
                                      setState(() {
                                        dayValue = newValue;
                                      });
                                    },
                                    items: DayLoop().days().map<DropdownMenuItem<int>>((int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(value.toString()),
                                      );
                                    }).toList(),
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                              child: Container(
                                  child: DropdownButton<String>(
                                    value: monthValue,
                                    icon: Icon(Icons.arrow_drop_down_outlined),
                                    iconSize: 20,

                                    onChanged: (String newValue) {
                                      setState(() {
                                        monthValue = newValue;
                                      });
                                    },
                                    items: DayLoop()
                                        .month
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 30, 0),
                              child: Container(
                                  child: DropdownButton<int>(
                                    value: yearValue,
                                    icon: Icon(Icons.arrow_drop_down_outlined),
                                    iconSize: 24,
                                    //elevation: 16,
                                    //style: TextStyle(color: Colors.deepPurple),
//                                    underline: Container(
//                                      height: 2,
//                                      color: Colors.deepPurpleAccent,
//                                    ),
                                    onChanged: (int newValue) {
                                      setState(() {
                                        yearValue = newValue;
                                      });
                                    },
                                    items:
                                    DayLoop().years().map<DropdownMenuItem<int>>((int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(value.toString()),
                                      );
                                    }).toList(),
                                  )),
                            ),
                          )
                        ])),

                        SizedBox(height: 10,),
                    Container(
                        child: Row(children: [
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                                child: Container(
                                  decoration:BoxDecoration(
                                    borderRadius:BorderRadius.circular(10),

                                  ),
                                    child: DropdownButton<String>(
                                      value: gender,
                                      icon: Icon(Icons.arrow_drop_down_outlined),
                                      iconSize: 20,
                                      elevation: 16,

                                      onChanged: (String newValue) {
                                        setState(() {
                                          gender = newValue;
                                        });
                                      },
                                      items: Options().gender.map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    )),
                              )),

                        ])
                    ),
                    Center(child:
                      SizedBox(width:320,height:48,
                        child:RaisedButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30),
                          ),
                          onPressed: ()async{
                                                      if (_formkey.currentState.validate()){
                            setState(() {
                              loading=true;
                            });
                            print(monthValue );
                            String name=fname+lname;
                            //pic=imageFile;
                            String dob= dayValue.toString() +'-' +monthValue +'-'+  yearValue.toString();
                            dynamic result= await _auth.registerWithEmailAndPassword(email, password,name,gender,dob,country ,pic );
                            if (result==null){
                              setState(() {
                                loading=false;
                                error="Please enter an valid email" ;
                              });
                            }
                          }
                          },
                          color:Colors.green,
                          child:Text("SIGN UP",
                            style:TextStyle(color:Colors.white),
                          ),)
                        ,),

                    ) ,SizedBox(height: 10),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red[700], fontSize: 14.0),

                    ),
                    Text(
                      "if you have an account?"
                    ),
                    GestureDetector(
                      onTap: ()async{
                        widget.toggleView();
                      },
                        child: Text("SIGN IN",style:TextStyle(color:Colors.green[700]),)),

                  ]),

                ),


              ),
             // Text("if you have ?")
            ],
          ),

        ],
      ),



    );
  }
}
