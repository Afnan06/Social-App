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

final firebase_storage.Reference storageReference =
    firebase_storage.FirebaseStorage.instance.ref().child("Post Pictures");
// final StorageReference storageReference =
//     FirebaseStorage.instance.ref().child("Post Pictures");
final postsReference = FirebaseFirestore.instance.collection("posts");
final usersReference = FirebaseFirestore.instance.collection("Profile Users");
final DateTime timestamp = DateTime.now();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User currentUser = FirebaseAuth.instance.currentUser;
  // final uid = user.uid;

  // final FirebaseAuth auth = FirebaseAuth.instance;

  // final User currentUser =  auth.currentUser;

  // final uid = user.uid;
  // here you write the codes to input the data into firestore

  PageController pageController;
  int getPageIndex = 0;

  void initState() {
    super.initState();
    pageController = PageController();
  }

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  whenPageChanges(int pageIndex) {
    setState(() {
      this.getPageIndex = pageIndex;
    });
  }

  onTapChangePage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 400),
      curve: Curves.bounceInOut,
    );
  }

  Scaffold buildHomeScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          TimeLinePage(),
          SearchPage(),
          UploadPage(),
          NotificationsPage(),
          // ProfilePage(),
          ProfilePage(
            userProfileId: currentUser.uid,
          ),
        ],
        controller: pageController,
        onPageChanged: whenPageChanges,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: getPageIndex,
        onTap: onTapChangePage,
        backgroundColor: Theme.of(context).accentColor,
        activeColor: Colors.white,
        inactiveColor: Colors.blueGrey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.photo_camera, size: 37.0)),
          BottomNavigationBarItem(icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // pageController = PageController();
    return buildHomeScreen();
  }
}
