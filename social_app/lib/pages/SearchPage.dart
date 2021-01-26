import 'package:flutter/material.dart';
import 'package:social_app/Services/auth.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
   final AuthService
  _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: PreferredSize(
               child: AppBar(
                      actions: [
                        IconButton(icon:Icon(Icons.mail_outline,color:Colors.white,), onPressed: (){
                          Navigator.pushNamed(context, "/search");
                        }


                        ),
                        IconButton(icon:Icon(Icons.search_rounded,color:Colors.white,),onPressed: (){
                         // Navigator.push(context, "/fireUsers");
                          Navigator.pushNamed(context, "/search");
                        },),
                            GestureDetector(
                                   onTap: ()async{
                                        await _auth.signOut();
                                              },
                child:
                             Padding(
                  padding: EdgeInsets.fromLTRB(8, 15, 15, 8),
                  //const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Logout",style:TextStyle(
                                               color:Colors.white
                                             ),
                                                     ),
                                                    ),
                                                            )
                                                               ],
                 title: Text("Search",style:TextStyle(color:Colors.white),),
            backgroundColor: Colors.green[700],
            bottomOpacity: 0,
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(50)
          ),
      body:   Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("images/back.png"),
            ),
          ),),
      backgroundColor: Colors.green[700],
    );
    return Text('Search Page goes here.');
  }
}

class UserResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("User Result here.");
  }
}
