import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/pages/HomePage.dart';
import 'package:social_app/pages/ProfileUser.dart';
import 'package:social_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Services/auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSignUp extends StatefulWidget {
  @override
  _ProfileSignUpState createState() => _ProfileSignUpState();
}

class _ProfileSignUpState extends State<ProfileSignUp> {
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




  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  ProfileUser currentUser;

  String bio;
  String profileName;
  bool loading = false;
  File imageFile;

  String pic;



  goToApp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  saveProfileUserInfoToFireStore() async {
    User wowcurrentUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot documentSnapshot =
        await usersReference.doc(wowcurrentUser.uid).get();
    if (!documentSnapshot.exists) {
      usersReference.doc(wowcurrentUser.uid).set({
        "id": wowcurrentUser.uid,
        "pUrl": uploadPhoto(imageFile),

        "profileName": profileName,
        "bio": bio
      });
      documentSnapshot = await usersReference.doc(wowcurrentUser.uid).get();
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    currentUser = ProfileUser.fromDocument(documentSnapshot);
  }
  void Pic(String url){
        FirebaseFirestore.instance.collection('UserCredentials').doc(userId).update({"pic":url
    }
    );


  }

  Future<String> uploadPhoto(imageFile) async {
    firebase_storage.UploadTask mStorageUploadTask =
    storageReference.child("profile_$profileName.jpg").putFile(imageFile);
    String downloadUrl = await (await mStorageUploadTask).ref.getDownloadURL();
    Pic(downloadUrl.toString());
//    FirebaseFirestore.instance.collection('UserCredentials').doc(userId).update({"pic":downloadUrl.toString()
//
//    }
//    );
    return downloadUrl.toString();

  }

  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
//        maxWidth: 1800,
//        maxHeight: 1800,
    );

    if (pickedFile != null) {
      //  if (mounted) {
      setState(() {
        imageFile = File(pickedFile.path);
        pic = imageFile.path;
        //imageFile.open(pic)
      });
      // }

    }
  }

  @override
  Widget build(BuildContext context) {
//    File imageFile;
//    _getFromGallery() async {
//      PickedFile pickedFile = await ImagePicker().getImage(
//        source: ImageSource.gallery,
////        maxWidth: 1800,
////        maxHeight: 1800,
//      );
//
//      if (pickedFile != null) {
//      //  if (mounted) {
//          setState(() {
//            imageFile = File(pickedFile.path);
//            pic = imageFile.path;
//            //imageFile.open(pic)
//          });
//       // }
//
//      }
//    }

    return loading
        ? Loading()
        : Scaffold(
      backgroundColor:Colors.green[700],
          appBar: PreferredSize(
               child: AppBar(
                      actions: [
                        IconButton(icon:Icon(Icons.search_rounded),onPressed: (){
                         // Navigator.push(context, "/fireUsers");
                          Navigator.pushNamed(context, "/users");
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
                 title: Text("Home"),
            backgroundColor: Colors.green[700],
            bottomOpacity: 0,
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(50)
          ),

            body: Stack(
              children: [
                Container(
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
                  ),
                ),
                ListView(
                  children: [
                    Stack(children: [
                      Padding(
                        padding: EdgeInsets.only(top: ScreenUtil().setSp(20)),
                        //const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircleAvatar(
                              radius: 60,
                              backgroundImage: (imageFile != null)
                                  ? FileImage(
                                      imageFile,
                                    )
                                  : AssetImage(
                                      "images/boy.png",
                                    )),
                        ),
                      ),
                      Positioned(
                          top: ScreenUtil().setSp(90),
                          left: ScreenUtil().setSp(193),
                          child: GestureDetector(
                              onTap: () {
                                //pic=imageFile;
                                _getFromGallery();
                              },
                              child: Image.asset(
                                "images/camera1.png",
                                height: 45,
                              )))
                    ]),
                    SizedBox(
                      height: ScreenUtil().setSp(20),
                    ),
                    Center(
                      //padding:EdgeInsets.fromLTRB(10, 10, 10, 10),
                      // child: Text("ENTER YOUR INFORMATION")),
                      child: Form(
                        key: _formkey,
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                            child: Container(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Enter Profile Name',
                                  isDense: true,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.green,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: HexColor("#f2f3f7"), width: 2),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0),
                                    ),
                                  ),
                                ),
                                validator: (val) =>
                                    val.isEmpty ? "enter name" : null,
                                // obscureText: true,
                                onChanged: (val) {
                                  setState(() {
                                    profileName = val;
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                            child: Container(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Enter Bio',
                                  isDense: true,
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.green,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: HexColor("#f2f3f7"), width: 2),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(40.0),
                                    ),
                                  ),
                                ),
                                validator: (val) =>
                                    val.isEmpty ? "enter" : null,
                                //  obscureText: true,
                                onChanged: (val) {
                                  setState(() {
                                    bio = val;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: SizedBox(
                              width: 300,
                              height: 50,
                              child: RaisedButton(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30),
                                ),
                                onPressed:()async{
                                  saveProfileUserInfoToFireStore();
                                 // uploadPhoto(imageFile);
                                },
                                color: Colors.green,
                                child: Text(
                                  "SAVE INFO",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: SizedBox(
                              width: 300,
                              height: 50,
                              child: RaisedButton(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30),
                                ),
                                onPressed: goToApp,
                                color: Colors.green,
                                child: Text(
                                  "GO TO APP",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
