

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
      appBar:PreferredSize(
          child: AppBar(title:Text("SocialApp"),backgroundColor:Colors.green[700],bottomOpacity: 0,elevation: 0,), preferredSize: Size.fromHeight(50)

      ),
      backgroundColor:Colors.green[700],
        body:
         Container(
                    decoration: BoxDecoration(
             color:Colors.white,
             borderRadius:BorderRadius.only(
               topLeft: Radius.circular(20),topRight: Radius.circular(20)
               ,        )
         ),
           child: StreamBuilder<QuerySnapshot>(
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
        ),
         )


    );
  }

   buildItem(obj1) {
   if (userId!=obj1['id']){
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
       child: Card(
         //color:Colors.blueGrey[200],
         child:Column(
           crossAxisAlignment:CrossAxisAlignment.start,
           children: [
             Row(
               children: [
                 Text("Username=",style:TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
                 Text(obj1["name"],
                 style:TextStyle(color:Colors.green[700],fontSize:15),
                 )
               ],
             ),
             Row(
               children: [
                 Text("Gender=",style:TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
                 Text(obj1["gender"],
                   style:TextStyle(color:Colors.green[700],fontSize:15),
                 )
               ],
             ),




           ],
         ),

       ),
     );

  }
//   else{
//     Text("ERROR");
//   }

  }
}
