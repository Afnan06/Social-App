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

class ProfileSignUp extends StatefulWidget {
  @override
  _ProfileSignUpState createState() => _ProfileSignUpState();
}

class _ProfileSignUpState extends State<ProfileSignUp> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  ProfileUser currentUser;

  String bio;
  String profileName;
  bool loading = false;
  File imageFile;

  String pic;

  @override
  void initState() {
    super.initState();
    //foo_bar(); // first call super constructor then foo_bar that contains setState() call
  }

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
        "pUrl": pic,
        "profileName": profileName,
        "bio": bio
      });
      documentSnapshot = await usersReference.doc(wowcurrentUser.uid).get();
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    currentUser = ProfileUser.fromDocument(documentSnapshot);
  }

  @override
  Widget build(BuildContext context) {
//    File imageFile;
    _getFromGallery() async {
      PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
//        maxWidth: 1800,
//        maxHeight: 1800,
      );

      if (pickedFile != null) {
        if (mounted) {
          setState(() {
            imageFile = File(pickedFile.path);
            pic = imageFile.path;
            //imageFile.open(pic)
          });
        }
        // imageFile = File(
        //     "https://www.kindpng.com/picc/m/78-785827_user-profile-avatar-login-account-male-user-icon.png");
        // pic = imageFile.path;

//        setState(() {
//          imageFile = File(pickedFile.path);
//        });
      }
    }

    return loading
        ? Loading()
        : Scaffold(
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
                                onPressed: saveProfileUserInfoToFireStore,
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
