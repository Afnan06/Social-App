import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/chat/ChatPage.dart';
import 'package:social_app/Services/auth.dart';





class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService
  _auth=AuthService();
  @override
  void initState() {
    getUserId();
    super.initState();
  }

  String userId;
  getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    userId = sharedPreferences.getString('id');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
        child: AppBar(
          actions: [
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
            //FlatButton.icon(onPressed:()async{await _auth.signOut();} , icon:Image.asset("images/logout.png"),label:Text(""),
              //  label:Text("signout",style:TextStyle(color:Colors.white),)
            //)
          ],



        title: Text("Home"),
    backgroundColor: Colors.green[700],
    bottomOpacity: 0,
    elevation: 0,
    ),
    preferredSize: Size.fromHeight(50)),
    backgroundColor: Colors.green[700],
//    body: Container(width: double.infinity,
//    decoration: BoxDecoration(
//    color: Colors.white,
//    borderRadius: BorderRadius.only(
//    topLeft: Radius.circular(20),
//    topRight: Radius.circular(20),
//    )),
//    child:Column(
//      children: [
//        Padding(
//          padding: const EdgeInsets.fromLTRB(100, 380, 10, 5),
//          child: FloatingActionButton.extended(onPressed: (){
//            Navigator.pushNamed(context, "/users");
//          }
//          ,icon:Icon(Icons.chat) ,label:Text("view users"),backgroundColor: Colors.green[700],
//          ),
//        )
//      ],
//    ),
//    )
        body: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(246, 246,246, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
          ),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('UserCredentials')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return ListView.builder(
                  itemBuilder: (listContext, index) =>
                      buildItem(snapshot.data.docs[index]),
                  itemCount: snapshot.data.docs.length,
                );
              }

              return Container();
            },
          ),
        ));
  }

  buildItem(obj1) {
    if (userId != obj1['id']) {
      return
//       Container(
//         height: double.infinity,width: double.infinity,
//         decoration: BoxDecoration(
//             color:Colors.white,
//             borderRadius:BorderRadius.only(
//               topLeft: Radius.circular(20),topRight: Radius.circular(20)
//               ,        )
//         ),
//         child:
        //  Column(
        //  children: [

//           Text(userId),
//           Text(obj1['id'],style:TextStyle(color:Colors.red,fontWeight:FontWeight.bold),),

//          GestureDetector(onTap:(){print("ok");Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(docu: obj1)));},
//            child:
//            Padding(padding:EdgeInsets.all(6), child: Card(
//                child: Text(obj1["name"],style:TextStyle(color:Colors.green,fontSize: 23),))),
//          ),

        //    ],
        // );
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              child: Card(
                elevation: 3.0,
                child:Row(
                  children: [

                       Padding(
                         padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                         child: Column(
                           crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Username:",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                SizedBox(width: 5,),
                                Text(obj1["name"].toUpperCase(),style:TextStyle(fontSize: 15,color:Colors.green),),
                              ],
                            ),SizedBox(height: 7,),
                            Row(
                              children: [
                                Text("Gender:",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                SizedBox(width: 5,),

                                Text(obj1["gender"].toUpperCase(),style:TextStyle(fontSize: 15,color:Colors.green),),
                              ],
                            ),
                          ],
                      ),
                       ),
                    ///yha chat now button ayega//
                                              Spacer(),
                          SizedBox(
                           // width: 40,
                           // width: 60,
                            height: 25,
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(docu: obj1)));



                              },
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Text(
                                    "CHAT NOW",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // SizedBox(width: 2,),
                                  Text(" "),

                                  Image.asset(
                                    "images/MSG.png",
                                    width: 16,
                                    height: 20,
                                  ),
                                  //Image.asset("home/MSG.png",height: 20,width: 20,),
                                ],
                              ),

                              //Text("CHAT NOW",style:TextStyle(color:Colors.green,fontSize: 13),),
                              shape: new RoundedRectangleBorder(
                                side: BorderSide(color: Colors.green, width: 1),
                                borderRadius: new BorderRadius.circular(20),
                              ),

                            ),
                          ),
                         SizedBox(width: 20,),

                  ],
                ),
                //color:Colors.blueGrey[200],
//                child: Padding(
//                  padding: EdgeInsets.fromLTRB(7, 7, 3, 0),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      Row(
//                        children: [
//                          Text(
//                            "Username:",
//                            style: TextStyle(
//                                fontWeight: FontWeight.bold, fontSize: 17),
//                          ),
//                          Text(
//                            obj1["name"],
//                            style: TextStyle(
//                                color: Colors.green[700], fontSize: 15),
//                          )
//                        ],
//                      ),
//                      Row(
//                        children: [
//                          Text(
//                            "Gender:",
//                            style: TextStyle(
//                                fontWeight: FontWeight.bold, fontSize: 14),
//                          ),
//                          Text(
//                            obj1["gender"],
//                            style: TextStyle(
//                                color: Colors.green[700], fontSize: 15),
//                          ),
//                          Spacer(),
//                          RaisedButton(
//                            onPressed: () {
//                              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(docu: obj1)));
//
//
//
//                            },
//                            color: Colors.white,
//                            child: Row(
//                              children: [
//                                Text(
//                                  "CHAT NOW",
//                                  style: TextStyle(
//                                      color: Colors.green,
//                                      fontSize: 10,
//                                      fontWeight: FontWeight.bold),
//                                ),
//                                // SizedBox(width: 2,),
//                                Text(" "),
//
//                                Image.asset(
//                                  "images/MSG.png",
//                                  width: 16,
//                                  height: 22,
//                                ),
//                                //Image.asset("home/MSG.png",height: 20,width: 20,),
//                              ],
//                            ),
//
//                            //Text("CHAT NOW",style:TextStyle(color:Colors.green,fontSize: 13),),
//                            shape: new RoundedRectangleBorder(
//                              side: BorderSide(color: Colors.green, width: 2),
//                              borderRadius: new BorderRadius.circular(20),
//                            ),
//                          ),
//
//                        ],
//                      ),
//                    ],
//                  ),
//
//
//
//                ),
              ),
            ));
    } else {
      return  Container();
    }
























  }
}
