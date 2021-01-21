import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Services/auth.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final AuthService _auth = AuthService();
  getCasesDetailList(query) async {
    List<DocumentSnapshot> documentList = (await FirebaseFirestore.instance
            .collection("UserCredentials")
            .where("caseSearch", arrayContains: query)
            .get(GetOptions()))
        .docs;
    for (int x = 0; x < documentList.length; x++) {
      var c = documentList[x].data().values.toList();
      print(c[5]);
      /////YAHA PAI HR RESULT KO CARD M SHOW KARANA HAI  ABHI SRF SEARCHED USER NAME AYEGA BAD M DP B LAENGAY
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () async {
                await _auth.signOut();
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 15, 15, 8),
                //const EdgeInsets.all(8.0),
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        body: Container(
            child: TextFormField(
                decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(40.0),
                      ),
                    ),
                    labelText: "Search Here",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.green,
                    )),
                onChanged: (String query) {
                  getCasesDetailList(query);
                })));
  }
}
