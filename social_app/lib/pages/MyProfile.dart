import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/auth.dart';
class MyProfile extends StatefulWidget {
  final friend;
  MyProfile({Key key,this.friend}) : super(key: key);

  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  //SharedPreferences sharedPreferences =  SharedPreferences.getInstance();
 // userId = sharedPreferences.getString('id');
  //String userId;
  String myfriendname;
  String myfriendid;
  buildItem(obj1){
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child:
        Row(
          children:[
            CircleAvatar(
              radius: 40,
              backgroundImage:obj1["pic"]!=null?
                  NetworkImage(obj1["pic"])

              :AssetImage("images/boy.png")

            ),

          SizedBox(width: 20,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(obj1["name"],style: TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
            //SizedBox(height: 4,),
            RaisedButton.icon(

              shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(10),
              ),
              color:Colors.green[700],
            label: Text("Addme",style:TextStyle(color:Colors.white),),
            icon:Icon(
            Icons.person_add_alt_1_sharp,color:Colors.white,),
            //  child: IconButton(icon: Icon(Icons.person_add_alt_1_sharp),
            onPressed: (){
                setState(() async{
//            await Friends.doc(userId).set({
//              "id":userId
//            });

                  await Friends.doc(userId).collection(userId).doc(myfriendname).set({
                    "name":myfriendname,
                    "id":myfriendid
                  });
                  //friendscollection.doc(userId).collection(userId).doc(widget.friend["id"]);

                });
                //friendscollection.doc(userId).collection(userId).doc(widget.friend["id"]);

              }),


          ],
    ),
        ]),
      );

  }




  @override
  void initState() {
    getUserId();
    super.initState();
  }

//  String userId;
//  String myfriendname;
//  String myfriendid;
 // String myfriend=widget.friend[];
   CollectionReference Friends =
  FirebaseFirestore.instance.collection('MyFriends');
  String userId;
//   final Future<SharedPreferences> sharedPreferences=SharedPreferences.getInstance();
//   String userId=sharedPreferences.getSting("id");
  //User currentUser = FirebaseAuth.instance.currentUser;
  getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userId = sharedPreferences.getString('id');
     myfriendname=
     widget.friend["name"];
     myfriendid=widget.friend["id"];
  }
  final AuthService _auth = AuthService();
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

              title: Text("MYPROFILE"),
    backgroundColor: Colors.green[700],
    bottomOpacity: 0,
    elevation: 0,
    ),
    preferredSize: Size.fromHeight(50)),
    backgroundColor: Colors.green[700],
     body: Container(
      width: double.infinity,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
    )),
      child:
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('UserCredentials')
            .where("id",isEqualTo:widget.friend["id"])
            .snapshots(),
        builder: (context, snapshot) {
          print(myfriendid);
          if (snapshot.hasData && snapshot.data != null) {
            // ob=snapshot.data.docs
            //buildItem(snapshot.data.docs[myfriendid]);
            return ListView.builder(
              itemBuilder: (listContext, index) {
                dynamic ob=snapshot.data.docs[index];
                String id=ob["id"];
                return buildItem(ob);
//                  if (id==myfriendid){
//                    return buildItem(ob);
//                  }
//                  else{
//                    return Container();
//                  }
                  //buildItem(snapshot.data.docs[index]);
              },
              itemCount: snapshot.data.docs.length,
              //itemCount: documentList.length,
            );
          }
          return Text("empty");
        },
      ),
//      Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: [
//          Text("  $myfriendname"),
//          IconButton(icon: Icon(Icons.add), onPressed: (){
////            final CollectionReference userCredentials =
////            FirebaseFirestore.instance.collection('Friendsof$userId');
//          })
//        ],
//      ):
//      Center(
//          child: SizedBox(
//            height: 36,
//            width: 36,
//            child: CircularProgressIndicator(
//              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//            ),
//          ))


    ));
  }
}
