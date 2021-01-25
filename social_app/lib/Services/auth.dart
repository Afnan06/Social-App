import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/Models/user.dart';
import 'package:social_app/Services/databse.dart';
import 'package:social_app/chat/FireUsers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String current = "";
  //SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

  //user object based on firebase result of user
  USER _userFromFirebaseUser(user) {
    return user != null ? USER(uid: user.uid) : null;
  }

  //auth change user stream, pass to main.dart
  Stream<USER> get user {
    //.map((User user) => _userFromFirebase(user))
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //signin anonoumously
  Future signinanon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //stream send either null or user data to provider and provider will choose to show home or loginpage

  //sign  with email
//   String current="";

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("checking");
      //current=result.user.uid;
      // print(current);
      sharedPreferences.setString("id", result.user.uid);

      //print(result.user["name"])
      // print(SocialAppUsers[0]);
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email
  List SocialAppUsers = [
    "0rE5EcadZkf5hQ9rV9LmST5DnV22",
    "fE2MZteZe3fzf8XR2zzzWG7iG7B3",
    "he69hmzVgwglREt5mq2mO7rG0sN2",
    "rnT9BsKPemSOd4Ay8vko5ZGmgRL2",
    "tXyfZLf0OoN0Wb84SGHeleA3OZ12",
  ];

  Future registerWithEmailAndPassword(
      String email,
      String password,
      String name,
      String gender,
      String dob,
      String country,
      String pic,
      String bio) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      //create a new id with used uid
      await DatabaseService(uid: result.user.uid)
          .useUpdateData(name, email, password, dob, gender, country,  bio);
      //change
      // await DatabaseService(uid: result.user.uid)
      //     .usingUpdateData(name, email, password, dob, gender, country, pic, bio);
      SocialAppUsers.add(result);
      sharedPreferences.setString("id", result.user.uid);


      print(result);

      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signout
  Future signOut() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.clear();

      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
