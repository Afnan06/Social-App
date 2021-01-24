import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection refernce
  //each user has its own document
  //every user has unique id
  //document id

  final CollectionReference userCredentials =
      FirebaseFirestore.instance.collection('UserCredentials');

  //meri karni
  // final  usersReference =
  //     FirebaseFirestore.instance.collection('UserCredentials');
  setSearchParam(String name) {
    List<String> caseSearchList = List();
    String temp = "";
    for (int i = 0; i < name.length; i++) {
      temp = temp + name[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }

  //1st signup and second when updating
  Future useUpdateData(String name, String email, String password, String dob,
      String gender, String country, String imageFile, String bio) async {
    //find id
    return await userCredentials.doc(uid).set({
      "caseSearch": setSearchParam(name),
      'name': name,
      'email': email,
      'password': password,
      'dob': dob,
      'gender': gender,
      'country': country,
      'pic': imageFile,
      'bio': bio,
    });
  }

  // change
//   Future usingUpdateData(String name, String email, String password, String dob,
//       String gender, String country, String imageFile, String bio) async {
//     //find id
//     return await usersReference.doc(uid).set({
//       "caseSearch": setSearchParam(name),
//       'name': name,
//       'email': email,
//       'password': password,
//       'dob': dob,
//       'gender': gender,
//       'country': country,
//       'pic': imageFile,
//       'bio': bio,
//     });

//   }
}
