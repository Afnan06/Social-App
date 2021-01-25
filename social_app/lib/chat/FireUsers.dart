import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/chat/ChatPage.dart';
import 'package:social_app/Services/auth.dart';
import 'package:social_app/pages/NotificationsPage.dart';
import 'package:social_app/pages/ProfilePage.dart';
import 'package:social_app/pages/SearchPage.dart';
import 'package:social_app/pages/TimeLinePage.dart';
import 'package:social_app/pages/UploadPage.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../pages/ProfilePage.dart';

class fireUsersS extends StatefulWidget {
 // final query;

 // const fireUsersS({Key key, this.query}) : super(key: key);

  @override
  _fireUsersSState createState() => _fireUsersSState();
}

class _fireUsersSState extends State<fireUsersS> {

 // dynamic query;
  @override
  void initState() {
    //fireUsersS (query);
    getUserId();
    super.initState();
  }

  String userId;
  User currentUser = FirebaseAuth.instance.currentUser;
  getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    userId = sharedPreferences.getString('id');
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              title: Text("HOME"),
              backgroundColor: Colors.green[700],
              bottomOpacity: 0,
              elevation: 0,
            ),
            preferredSize: Size.fromHeight(50)),
        backgroundColor: Colors.green[700],
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('UserCredentials')
            //.where("name",isEqualTo:query)
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
    //  print(obj1["pic"]);
      return Padding(padding:EdgeInsets.fromLTRB(10, 10, 10,  8),
          child:Card(
            color:Colors.white,
            elevation:7.0,
            //margin:EdgeInsets.fromLTRB(0, 15, 0, 0),

            child:Padding(padding:EdgeInsets.only(top: 10,bottom: 10),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap:(){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                              ProfilePage(userProfileId: currentUser.uid,)));
                                          //ChatPage(docu: obj1)));
                              //Navigator.pushNamed(context, "/profilepage");
                                   },
                            child: CircleAvatar(
                                radius:25,
                               backgroundImage: obj1["pic"]!=null?
                               NetworkImage(obj1["pic"]):
                               AssetImage("images/boy.png")

                                //backgroundImage:AssetImage(obj1["pic"])
                            ),
                          )
                          ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      //mainAxisAlignment:MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text(obj1["name"],style:TextStyle(fontWeight:FontWeight.bold),),
                           // Text("",style:TextStyle(color:Colors.grey,fontWeight:FontWeight.bold),),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0,5),
                          child: Text(obj1["gender"],style:TextStyle(fontSize: 12,fontWeight:FontWeight.bold,color:Colors.grey),),
                        ),
                        Row(
                          children: [
                           // Icon(Icons.calendar_today_sharp,size:10,color:Colors.grey,),SizedBox(width:3,),Text("",style:TextStyle(fontSize:10,color:Colors.grey),),
                          ],
                        )
                      ],
                    )
                    ,
                    Spacer(),
                     IconButton
                       (
                       icon:Image.asset("images/MSG.png",height: 27,),
                       onPressed: (){
                         Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChatPage(docu: obj1)));

                       },
                     ),
                     SizedBox(
                       width: 20,
                     )

//                    Icon(
//                      Icons.more_vert,color:Colors.grey,
//                    )
                  ],
                )
            ),
          ));
//          Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Container(
//                height: 94,
//                child: Card(
//                  elevation: 3.0,
//                  //color:Colors.blueGrey[200],
//                  child: Padding(
//                    padding: EdgeInsets.fromLTRB(7, 7, 3, 0),
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: [
//                        Row(
//                          children: [
//                            Text(
//                              "Username:",
//                              style: TextStyle(
//                                  fontWeight: FontWeight.bold, fontSize: 17),
//                            ),
//                            Text(
//                              obj1["name"],
//                              style: TextStyle(
//                                  color: Colors.green[700], fontSize: 15),
//                            )
//                          ],
//                        ),
//                        Row(
//                          children: [
//                            Text(
//                              "Gender:",
//                              style: TextStyle(
//                                  fontWeight: FontWeight.bold, fontSize: 14),
//                            ),
//                            Text(
//                              obj1["gender"],
//                              style: TextStyle(
//                                  color: Colors.green[700], fontSize: 15),
//                            ),
//                            Spacer(),
//                            RaisedButton(
//                              onPressed: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) =>
//                                            ChatPage(docu: obj1)));
//                              },
//                              color: Colors.white,
//                              child: Row(
//                                children: [
//                                  Text(
//                                    "CHAT NOW",
//                                    style: TextStyle(
//                                        color: Colors.green,
//                                        fontSize: 10,
//                                        fontWeight: FontWeight.bold),
//                                  ),
//                                  // SizedBox(width: 2,),
//                                  Text(" "),
//
//                                  Image.asset(
//                                    "images/MSG.png",
//                                    width: 17,
//                                    height: 22,
//                                  ),
//                                  //Image.asset("home/MSG.png",height: 20,width: 20,),
//                                ],
//                              ),
//
//                              //Text("CHAT NOW",style:TextStyle(color:Colors.green,fontSize: 13),),
//                              shape: new RoundedRectangleBorder(
//                                side: BorderSide(color: Colors.green, width: 2),
//                                borderRadius: new BorderRadius.circular(20),
//                              ),
//                            )
//                          ],
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ));
    } else {
      return Container();
    }
  }
}
