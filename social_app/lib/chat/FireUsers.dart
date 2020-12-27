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

   buildItem(obj1) {
  // if (userId!=obj1['id']){
     return
       Column(
         children: [
           Text(userId),
           Text(obj1['id'],style:TextStyle(color:Colors.red,fontWeight:FontWeight.bold),),

        GestureDetector(
          onTap:(){
            print("ok");

           Navigator.push(context,
         MaterialPageRoute(builder: (context) => ChatPage(docu: obj1)));

        },child:

               Padding
             (padding:EdgeInsets.all(6),
               child: Card(
                   child: Text(obj1["name"],style:TextStyle(color:Colors.green,fontSize: 23),))),
            ),



         ],
       );
 //  }
//   else{
//     Text("ERROR");
//   }

  }
}
