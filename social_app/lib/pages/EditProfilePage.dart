import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/pages/HomePage.dart';
import 'package:social_app/pages/ProfileUser.dart';
import 'package:social_app/pages/SearchPage.dart';
import 'package:social_app/widgets/ProgressWidget.dart';
import 'package:social_app/Services/databse.dart';

class EditProfilePage extends StatefulWidget {
  final String currentOnlineUserId;

  EditProfilePage({this.currentOnlineUserId});
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // User currentUser = FirebaseAuth.instance.currentUser;
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController countryTextEditingController = TextEditingController();
  TextEditingController bioTextEditingController = TextEditingController();
  final _scaffoldGlobalKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  ProfileUser user;
  bool _bioValid = true;
  bool _countryValid = true;
  bool _profileNameValid = true;

  void initState() {
    super.initState();

    getAndDisplayUserInformation();
  }

  getAndDisplayUserInformation() async {
    setState(() {
      loading = true;
    });

    DocumentSnapshot documentSnapshot =
        await usersReference.doc(widget.currentOnlineUserId).get();
    ProfileUser user = ProfileUser.fromDocument(documentSnapshot);

    userNameTextEditingController.text = user.profileName;
    bioTextEditingController.text = user.bio;

    setState(() {
      loading = false;
    });
  }

  updateUserdata() {
    setState(() {
      userNameTextEditingController.text.trim().length < 3 ||
              userNameTextEditingController.text.isEmpty
          ? _profileNameValid = false
          : _profileNameValid = true;

      bioTextEditingController.text.trim().length > 110
          ? _bioValid = false
          : _bioValid = true;
    });

    if (_bioValid && _profileNameValid) {
      // print(_bioValid && _profileNameValid);
      // userC.doc(widget.currentOnlineUserId).update()
      usersReference.doc(widget.currentOnlineUserId).update({
        "profileName": userNameTextEditingController.text,
        "bio": bioTextEditingController.text,
      });

      SnackBar successSnackBar =
          SnackBar(content: Text("Profile has been updated successfully."));
      _scaffoldGlobalKey.currentState.showSnackBar(successSnackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldGlobalKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: loading
          ? circularProgress()
          : ListView(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 7.0),
                        child: CircleAvatar(
                          radius: 52.0,
                          // backgroundImage: CachedNetworkImageProvider(currentUser.photoURL),
                          backgroundImage:
                              AssetImage('assets/images/girl.jpeg'),
                          // CachedNetworkImageProvider(user.pUrl)
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            createProfileNmaeTextFormFeild(),
                            createBioTextFormFeild()
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 29.0, left: 50.0, right: 50.0),
                        child: RaisedButton(
                          onPressed: updateUserdata,
                          child: Text(
                            "          Update          ",
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),
                        child: RaisedButton(
                          onPressed: logoutUser,
                          color: Colors.red,
                          child: Text(
                            "LogoutUser",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  logoutUser() async {
    // await
    // try {
    //   SharedPreferences sharedPreferences =
    //       await SharedPreferences.getInstance();
    //   sharedPreferences.clear();

    //   return await _auth.signOut();
    // } catch (e) {
    //   print(e.toString());
    //   return null;
    // }

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  Column createProfileNmaeTextFormFeild() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 13.0),
          child: Text(
            "Profile Name",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          style: TextStyle(color: Colors.white),
          controller: userNameTextEditingController,
          decoration: InputDecoration(
            hintText: " Write profile name here...",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            hintStyle: TextStyle(color: Colors.grey),
            errorText: _profileNameValid ? null : "Profile name is very short",
          ),
        ),
      ],
    );
  }

  Column createBioTextFormFeild() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 13.0),
          child: Text(
            "Bio",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          style: TextStyle(color: Colors.white),
          // controller: userNameTextEditingController,
          controller: bioTextEditingController,
          decoration: InputDecoration(
            hintText: " Write Bio here...",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            hintStyle: TextStyle(color: Colors.grey),
            errorText: _bioValid ? null : "Bio is very long",
          ),
        ),
      ],
    );
  }
}
