import 'package:flutter/material.dart';
import 'package:social_app/Services/auth.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService
  _auth=AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
        child: AppBar(
          actions: [
            FlatButton.icon(onPressed:()async{await _auth.signOut();} , icon:Icon(Icons.person), label:Text("signout") )
          ],



        title: Text("Home"),
    backgroundColor: Colors.green[700],
    bottomOpacity: 0,
    elevation: 0,
    ),
    preferredSize: Size.fromHeight(50)),
    backgroundColor: Colors.green[700],
    body: Container(width: double.infinity,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
    )),
    child:Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(100, 380, 10, 5),
          child: FloatingActionButton.extended(onPressed: (){
            Navigator.pushNamed(context, "/users");
          }
          ,icon:Icon(Icons.chat) ,label:Text("view users"),backgroundColor: Colors.green[700],
          ),
        )
      ],
    ),





















    )


    );
  }
}
