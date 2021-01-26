import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/Services/auth.dart';
import 'package:social_app/shared/loading.dart';
import 'package:social_app/widgets/HeaderWidget.dart';
import 'package:social_app/widgets/ProgressWidget.dart';
import 'package:flutter/material.dart';

import '../widgets/PostWidget.dart';
import 'HomePage.dart';

class TimeLinePage extends StatefulWidget {
  var c='';
 
  
   final String userProfileId;
  TimeLinePage({this.userProfileId});
  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
   String userIdP;
    bool loading =false;
  
    final AuthService
  _auth=AuthService();
   
   var dat;
   
   List<String> friends=[];
   List<String> name=[];
   List<String> description=[];
   List<String> photo=[];

   void initState() {
     setState(() {
       loading=true;
         getUser();
     });
 

  }

   
  getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
var c;
    userIdP = sharedPreferences.getString('id');
    print(userIdP);
    

    List<DocumentSnapshot> flist = (await FirebaseFirestore.instance
            .collection("MyFriends")
            .doc(userIdP)
            .collection(userIdP)
            .get(GetOptions()))
        .docs;
        print(flist);
         for (int x = 0; x < flist.length; x++) {
           friends.add(flist[x].data()['id']);
 print(flist[x].data()['id']);  //name 
           }
           print(friends);

   List<DocumentSnapshot> documen = (await FirebaseFirestore.instance
            .collection("UserCredentials")
            .get(GetOptions()))
        .docs;
         for (int x = 0; x < documen.length; x++) {
           if(friends.contains(documen[x].data()['id'])){
print(documen[x].data()['name']);
setState(() {
  name.add(documen[x].data()['name']);
});
}   //name 
           }

        

      
    
   
    for (int r=0; r<friends.length; r++){
      print(friends[r]);
         
    List<DocumentSnapshot> documentList = (await FirebaseFirestore.instance
            .collection("posts")
            .doc(friends[r].substring(1))
            
            .collection("usersPosts")
            // .where("ownerId", arrayContains: friend)
            .get(GetOptions()))
        .docs;
    print(documentList);
    for (int x = 0; x < documentList.length; x++) {
        c = documentList[x].data().values.toList();
      print("printing");
      print(c);
      print(c[0]); ///description
      print(c[1]);  //location
      print(c[2]); ///post id
            print(c[3]);//user id
      print(c[4]);//picture
      print(c[7]);//time
      setState(() {
         photo.add(c[4]);
      description.add(c[0]);
      });
      print(name);
      print(photo);
      print(description);
      loading=false;
     
      
      /////YAHA PAI HR RESULT KO CARD M SHOW KARANA HAI  ABHI SRF SEARCHED USER NAME AYEGA BAD M DP B LAENGAY
    }

    }
    return c;
  

  }

  
  
 
  @override
  Widget build(context) {
    return loading ? Loading():Scaffold(
       appBar: PreferredSize(
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
                 title: Text("Profile",style:TextStyle(color:Colors.white),),
            backgroundColor: Colors.green[700],
            bottomOpacity: 0,
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(50)
          ),
      body:
      
       Container(
        child: 
          GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 1,
          childAspectRatio: (100/70),
          // Generate 100 widgets that display their index in the List.
          children: 
            List.generate(name.length,(index){
              if((name.length- description.length ==0) && (description.length - photo.length==0)){
                return  Container(
        width:MediaQuery.of(context).size.width,
        height: 250,
        child: Card(child:Column(
          children:[SizedBox(height:10),
          Row(children: [
            Text(name[index])
            ,SizedBox(width:15),CircleAvatar(

            ),
          ],),
          
            
            SizedBox(height:10),
            Text(description[index]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width:MediaQuery.of(context).size.width,
        height: 120
                ,
                decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(photo[index]), fit: BoxFit.cover)),),
            ),
                 SizedBox(height:10),
                 Row(
                   children:[
                     Container(
                  width: MediaQuery.of(context).size.width/2 -9,
                  height: 30.0,
                  margin: EdgeInsets.symmetric(vertical: 3.0),
                  child: SizedBox.expand(
                      child: OutlineButton(
                          child: Text('Like',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.green)),
                          borderSide: BorderSide(
                            color: Colors.amber,
                            style: BorderStyle.solid,
                            width: 3,
                          ),
                          onPressed: () {
                            setState(() {
                              print(name);
                              print(description);
                              print(photo);
                            
                               
                              
                            });
                          
                            
                          }))),
                          Container(
                  width: MediaQuery.of(context).size.width/2,
                  height: 30.0,
                  margin: EdgeInsets.symmetric(vertical: 3.0),
                  child: SizedBox.expand(
                      child: OutlineButton(
                          child: Text('Comment',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.green)),
                          borderSide: BorderSide(
                            color: Colors.amber,
                            style: BorderStyle.solid,
                            width: 3,
                          ),
                          onPressed: () {
                            _auth.signOut();
                           
                          }))),
                         



                   ]
                 )
          ]
        ),
      )
    );

              }
              else{
                return Container(child: Text("No Posts",style: TextStyle(color: Colors.amber),),);
              }
          
      
            }))));
    
  }

}
