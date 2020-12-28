import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Screens/LogInProcess/loop.dart';
import 'package:social_app/Services/auth.dart';
import 'package:social_app/shared/loading.dart';

class checking extends StatefulWidget {
  final Function toggleView;
  checking({this.toggleView});
  @override
  _checkingState createState() => _checkingState();
}

class _checkingState extends State<checking> {
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



  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      appBar:
      PreferredSize(child: AppBar(
        actions: [FlatButton.icon(
          icon:Icon (Icons.person,size:20,),
          label: Text("Sign In"),
          onPressed: ()async {
            widget.toggleView();


          },
        )
        ],

        title:Text("SocialMediaApp"),backgroundColor:Colors.green[700],bottomOpacity: 0,elevation: 0,
      ), preferredSize: Size.fromHeight(50),
      ),
      body: Stack(
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
          ListView(
            children:[
            Center(
                //padding:EdgeInsets.fromLTRB(10, 10, 10, 10),
               // child: Text("ENTER YOUR INFORMATION")),
              child: Form(
                key:_formkey,
                child: Column(children: [
                  Container(
                    child: Row(children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
                            child: Container(
                              child: TextFormField(
                                decoration: InputDecoration(labelText: 'First Name',
                                  border:OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0),
                                    ),
                                  ),



                                ),
                                validator: (val)=> val.isEmpty ? "Empty name" : null,

                                onChanged: (val){
                                  setState(() {
                                    fname=val;
                                  });
                                },
                              ),
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 50, 30, 0),
                            child: Container(
                              child: TextFormField(
                                  decoration: InputDecoration(labelText: 'SurName',
                                    border:OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(40.0),
                                      ),
                                    ),


                                  ),
                                  validator: (val)=> val.isEmpty ? "Empty name" : null,
                                  onChanged: (val){
                                    setState(() {
                                      lname=val;
                                    });
                                  } ),
                            ),
                          )),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                    child: Container(
                      child: TextFormField(
                          decoration: InputDecoration(labelText: 'Enter Your Email',
                            border:OutlineInputBorder(
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
                        decoration: InputDecoration(labelText: 'Enter Password',
                          border:OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(40.0),
                            ),
                          ),),
                        validator: (val)=> val.length < 6 ? "pass is of 6 characters" : null,
                        obscureText: true,
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
                        decoration: InputDecoration(labelText: 'Confirm Password',
                          border:OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(40.0),
                            ),
                          ),),
                        validator: (val)=> val != password ? "wrong password" : null,
                        obscureText: true,
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
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
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
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
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
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
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
                  Container(
                      child: Row(children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                              child: Container(
                                  child: DropdownButton<String>(
                                    value: gender,
                                    icon: Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.deepPurpleAccent,
                                    ),
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
                  //        Container(
                  //     child: Row(children: [
                  //   Expanded(
                  //       child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                  //     child: Container(
                  //         child: DropdownButton<String>(
                  //       value: country,
                  //       icon: Icon(Icons.arrow_downward),
                  //       iconSize: 24,
                  //       elevation: 16,
                  //       style: TextStyle(color: Colors.deepPurple),
                  //       underline: Container(
                  //         height: 2,
                  //         color: Colors.deepPurpleAccent,
                  //       ),
                  //       onChanged: (String newValue) {
                  //         setState(() {
                  //           country = newValue;
                  //         });
                  //       },
                  //       items: Options().countries.map<DropdownMenuItem<String>>((String value) {
                  //         return DropdownMenuItem<String>(
                  //           value: value,
                  //           child: Text(value),
                  //         );
                  //       }).toList(),
                  //     )),
                  //   )),

                  // ])
                  // ),
                  Center(
                    child: RaisedButton(
                      color: Colors.lightBlue,
                      onPressed: () async{
                        if (_formkey.currentState.validate()){
                          setState(() {
                            loading=true;
                          });
                          print(monthValue );
                          String name=fname+lname;
                          String dob= dayValue.toString() +'-' +monthValue +'-'+  yearValue.toString();
                          dynamic result= await _auth.registerWithEmailAndPassword(email, password,name,gender,dob,country  );
                          if (result==null){
                            setState(() {
                              loading=false;
                              error="Please enter an valid email" ;
                            });
                          }

                        }
                      },
                      child: Text("SignUp",style: TextStyle(color: Colors.white),),
                    ),


                  ) ,SizedBox(height: 10),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),

                  )

                ]),
              ),


            )
            ],
          )

        ],
      ),













     backgroundColor:Colors.green[700],
    );
  }
}
