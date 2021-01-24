// import 'package:/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/pages/EditProfilePage.dart';
import 'package:social_app/pages/ProfileUser.dart';
import 'package:social_app/widgets/HeaderWidget.dart';
import 'package:social_app/widgets/PostTileWidget.dart';
import 'package:social_app/widgets/PostWidget.dart';
import 'package:social_app/widgets/ProgressWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/pages/HomePage.dart';
import 'package:social_app/pages/ProfilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/Services/databse.dart';

// import 'package:social_app/Services/databse.dart';
class ProfilePage extends StatefulWidget {
  final String userProfileId;
  ProfilePage({this.userProfileId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // amber check it
  // @override
  // void initState() {
  //   getUserId();
  //   getUserName();
  //   getCountry();
  //   getBio();
  //   super.initState();
  // }

  // String bioPro;
  // getBio() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //   bioPro = sharedPreferences.getString('bio');
  // }

  // String countryPro;
  // getCountry() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //   countryPro = sharedPreferences.getString('country');
  // }

  // String userIdPro;
  // getUserId() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //   userIdPro = sharedPreferences.getString('id');
  // }

  // String usernamePro;
  // getUserName() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //   usernamePro = sharedPreferences.getString('name');
  // }

  // final String currentOnlineUserId = userIdPro;
  User currentOnlineUserId = FirebaseAuth.instance.currentUser;
  // final String currentOnlineUserId = currentUser.uid;
  bool loading = false;
  int countPost = 0;
  //////////////////////////////////////////////////////////////////////////
  List<Post> postsList = [];
  String postOrientation = "grid";

  //khud karna hoga

  void initState() {
    getAllProfilePosts();
  }

  // void _initState() {
  //   getAllProfilePosts();
  // }

  createProfileTopView() {
    return FutureBuilder(
        future: usersReference.doc(widget.userProfileId).get(),
        builder: (context, dataSnapshot) {
          //  builder:
          // // (context)
          if (!dataSnapshot.hasData) {
            return circularProgress();
          }

          ProfileUser user = ProfileUser.fromDocument(dataSnapshot.data);
          return Padding(
              padding: EdgeInsets.all(17.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 45.0,
                        backgroundColor: Colors.grey,
                        backgroundImage: CachedNetworkImageProvider(user.pUrl),
                        // backgroundImage: AssetImage('assets/images/girl.jpeg'),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                createColumns("posts", 0),
                                createColumns("followers", 0),
                                createColumns("following", 0),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                createButton(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 13.0),
                    child: Text(
                      user.profileName,
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                  // Container(
                  //   alignment: Alignment.centerLeft,
                  //   padding: EdgeInsets.only(top: 5.0),
                  //   child: Text(
                  //     countryPro,
                  //     style: TextStyle(fontSize: 14.0, color: Colors.white),
                  //   ),
                  // ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 3.0),
                    child: Text(
                      user.bio,
                      style: TextStyle(fontSize: 14.0, color: Colors.white70),
                    ),
                  ),
                ],
              ));
        });
  }

  Column createColumns(String title, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Text(title,
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w100)),
        ),
      ],
    );
  }

  createButton() {
    bool ownProfile = currentOnlineUserId.uid == widget.userProfileId;
    if (ownProfile) {
      return createButtonTitleAndFunction(
        title: "Edit Profile",
        performFunction: editUserProfile,
      );
    }
  }

  Container createButtonTitleAndFunction(
      {String title, Function performFunction}) {
    return Container(
      padding: EdgeInsets.only(top: 3.0),
      child: FlatButton(
        onPressed: performFunction,
        child: Container(
          width: 200.0,
          height: 26.0,
          child: Text(
            title,
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
      ),
    );
  }

  editUserProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditProfilePage(currentOnlineUserId: currentOnlineUserId.uid)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(
        context,
        strTitle: "Profile",
      ),
      body: ListView(
        children: <Widget>[
          createProfileTopView(),
          Divider(),
          createListAndGridPostOrientation(),
          Divider(
            height: 0.0,
          ),
          displayProfilePost(),
        ],
      ),
    );
  }

  displayProfilePost() {
    if (loading) {
      return circularProgress();
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////
    else if (postsList.isEmpty) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Icon(
                Icons.photo_library,
                color: Colors.grey,
                size: 200.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                "No Posts",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    } else if (postOrientation == "grid") {
      List<GridTile> gridTilesList = [];
      ////////////////////////////////////////////////////////////////////////////////////////
      postsList.forEach((eachPost) {
        gridTilesList.add(GridTile(
          child: PostTile(eachPost),
        ));
      });

      return GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        mainAxisSpacing: 1.5,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: gridTilesList,
      );
    } else if (postOrientation == "list") {
      return Column(
        //////////////////////////////////////////////////////////////////////////////////////
        children: postsList,
      );
    }
  }

  getAllProfilePosts() async {
    setState(() {
      loading = true;
    });

    QuerySnapshot querySnapshot = await postsReference
        .doc(widget.userProfileId)
        .collection("usersPosts")
        .orderBy("timestamp", descending: true)
        .get();

    setState(() {
      loading = false;
      countPost = querySnapshot.docs.length;
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      postsList = querySnapshot.docs
          .map((documentSnapshot) => Post.fromDocument(documentSnapshot))
          .toList();
    });
  }

  createListAndGridPostOrientation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          onPressed: () => setOrientation("grid"),
          icon: Icon(Icons.grid_on),
          color: postOrientation == "grid"
              ? Theme.of(context).primaryColor
              : Colors.grey,
        ),
        IconButton(
          onPressed: () => setOrientation("list"),
          icon: Icon(Icons.list),
          color: postOrientation == "list"
              ? Theme.of(context).primaryColor
              : Colors.grey,
        ),
      ],
    );
  }

  setOrientation(String orientaion) {
    setState(() {
      this.postOrientation = orientaion;
    });
  }
}
