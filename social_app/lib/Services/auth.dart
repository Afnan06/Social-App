import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/Models/user.dart';
import 'package:social_app/Services/databse.dart';

class AuthService{
   final FirebaseAuth _auth= FirebaseAuth.instance;

   //user object based on firebase result of user 
   USER _userFromFirebaseUser( user){
     return user != null ? USER(uid: user.uid) :null;
   }
   //auth change user stream, pass to main.dart
   Stream<USER> get user{
     //.map((User user) => _userFromFirebase(user))
     return _auth.authStateChanges().map(_userFromFirebaseUser);
   }

  //signin anonoumously
  Future signinanon() async{
    try{
      UserCredential result =await _auth.signInAnonymously();
      return _userFromFirebaseUser( result.user);

    }catch(e){
      print(e.toString());
      return null;

    }
  }


  //stream send either null or user data to provider and provider will choose to show home or loginpage

 











  //sign  with email

   Future signInWithEmailAndPassword(String email, String password)async {
    try{
      UserCredential result =await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser( result.user);

    }catch(e){
      print(e.toString());
      return null;

    }
  }

  //register with email

  Future registerWithEmailAndPassword(String email, String password,String name, String gender, String dob,String country)async {
    try{
      UserCredential result =await _auth.createUserWithEmailAndPassword(email: email, password: password);

      //create a new id with used uid
      await DatabaseService(uid: result.user.uid).useUpdateData(name, email, password, dob,gender, country);

      return _userFromFirebaseUser( result.user);

    }catch(e){
      print(e.toString());
      return null;

    }
  }
  //signout
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }


}