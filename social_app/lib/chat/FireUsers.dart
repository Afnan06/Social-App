import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/chat/ChatPage.dart';
import 'package:social_app/Services/auth.dart';


class fireUsersS extends StatefulWidget {
  @override
  _fireUsersSState createState() => _fireUsersSState();
}

class _fireUsersSState extends State<fireUsersS> {
 String userId;
 @override
 void initState() {
   getUserId();
   super.initState();
 }
   getUserId() async {
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

   userId = sharedPreferences.getString('id');
 }


 @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('UserCredentials').snapshots(),
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
        )


    );
  }

   buildItem(doc) {
   if (userId!=doc['id']){
     return
       //  userId!=doc['id']?
       Column(
         children: [
           Text(userId),
           Text(doc['id'],style:TextStyle(color:Colors.red,fontWeight:FontWeight.bold),),
           // Text("viewwwwwwwwwwwwwwwwwwwwwwwwwwwww users"),

        GestureDetector(
          onTap:(){
            print("ok");
            Navigator.pushNamed(context, "/chat");
//           Navigator.push(context,
//         MaterialPageRoute(builder: (context) => ChatPage(docu: doc)));

        },child:

               Padding
             (padding:EdgeInsets.all(6),
               child: Card(
                   child: Text(doc["name"],style:TextStyle(color:Colors.green,fontSize: 23),))),
            ),



         ],
       );
   }
   else{
     Text("ERROR");
   }
//   return
// //  userId!=doc['id']?
//    Column(
//      children: [
//        Text(userId),
//       Text(doc['id'],style:TextStyle(color:Colors.red,fontWeight:FontWeight.bold),),
//       // Text("viewwwwwwwwwwwwwwwwwwwwwwwwwwwww users"),
//
////        GestureDetector(
////          onTap:(){
////            Navigator.push(context,
////         MaterialPageRoute(builder: (context) => ChatPage(docs: doc)));
////
////        },
//
//           Padding
//            (padding:EdgeInsets.all(6),
//             child: Card(
//                 child: Text(doc["name"],style:TextStyle(color:Colors.green,fontSize: 23),))),
//      //  ),
//
//
//
//      ],
//    );
       // :Container(
     //child:Text("ERRROR IN "),



//    return
//   (userId != doc['id'])
//    ?
//       GestureDetector(
//     onTap: () {
//      Navigator.push(context,
//          MaterialPageRoute(builder: (context) => chatpage(docs: doc)));
//    },
 // child:
//      Card(
//        color: Colors.lightBlue,
//        child: Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: Container(
//            child: Center(
//              child: Text(doc['name']),
//            ),
//          ),
//        ));


     //  : Container();
  }
}
