import 'package:flutter/material.dart';
import 'package:social_app/Services/auth.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social App"),
        backgroundColor: Colors.black45,
        actions: <Widget>[
          FlatButton.icon(
            icon:Icon (Icons.person),
            label: Text("Sign out"),
            onPressed: ()async {
                        await _auth.signOut();
                    
                        
                      },
          )
        ],
      ),
      backgroundColor: Colors.grey[400],
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Center(
              child: Container(
                  child: RaisedButton(
                      onPressed: () {},
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
          RaisedButton.icon(onPressed: (){
            Navigator.pushNamed(context, "/users");
           // Navigator.push(context, "/users");
          }, icon: Icon(Icons.search), label: Text("chat with users"))
         
        ],
      ),
    );
  }
}