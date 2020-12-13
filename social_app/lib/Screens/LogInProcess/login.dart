import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Screens/LogInProcess/signup.dart';
import 'package:social_app/Services/auth.dart';
import 'package:social_app/shared/loading.dart';


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
      appBar: AppBar(
        title: Text("Social App"),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          FlatButton.icon(
            icon:Icon (Icons.person),
            label: Text("Sign up"),
            onPressed: ()async {
                       widget.toggleView();
                    
                        
                      },
          )
        ],
      ),
      backgroundColor: Colors.grey[400],
      body: Form(
        key:_formkey,
        child:Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 150, 30, 0),
            child: Container(
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Enter your email',
                //enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width:2.0))
                ),
                validator: (val)=> val.isEmpty ? "Empty email" : null,
                onChanged: (val){
                      setState(() {
                        email=val;
                      });}
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
              child: Container(
                  child: TextFormField(
                decoration: InputDecoration(labelText: 'Enter PASSWORD'),
                validator: (val)=> val.length < 6 ? "pass is of 6 characters" : null,
                onChanged: (val){
                      setState(() {
                        password=val;
                      });}
              ))),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Center(
              child: Container(
                  child: RaisedButton(
                      onPressed: () async {
                        // dynamic result =await _auth.signinanon();
                        // print("wh");
                        // if (result==null){
                        //   print("error sigining in");
                        // }
                        // else{
                        //   print("success");
                        //   print(result.uid);
                        // }
                        if (_formkey.currentState.validate()){
                          setState(() {
                       loading=true;
                     });
                     print(email);
                     print(password);
                     dynamic result= await _auth.signInWithEmailAndPassword(email, password);
                     if (result==null){
                       setState(() {
                         loading =false;
                         error="Could'nt sign in with this  email" ;
                       });
                     }
                     }
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: const Text('Gradient Button',
                            style: TextStyle(fontSize: 20)),
                      ))),
            ),
          ),
          SizedBox(height: 10),
                     Text(
                       error,
                       style: TextStyle(color: Colors.red, fontSize: 14.0),

                     ),
      
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 30, 0),
            child: Center(
                child: Container(child: Text("Don't have an acccount?"))),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 30, 0),
            child: Center(
                child: Container(
                    child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: ' Create One!',
                      style: TextStyle(color: Colors.blue),
     
                      recognizer: DoubleTapGestureRecognizer()
                        ..onDoubleTap = () {
                          print('v');
                          
                          return SignUp() ;
                        }),
                ],
              ),
            ))),
          ),
        ],
      ),)
    );
  }
}
