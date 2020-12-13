import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});


  //collection refernce 
  //each user has its own document
  //every user has unique id
  //document id

  final CollectionReference userCredentials= Firestore.instance.collection('UserCredentials');

  //1st signup and second when updating
  Future useUpdateData(String name,String email,String password,String dob,String gender,String country)async{
    //find id
    return await userCredentials.doc(uid).set(
      {
        'name':name,
        'email':email,
        'password':password,
        'dob':dob,
        'gender':gender,
        'country':country


      }
    );
  }
}