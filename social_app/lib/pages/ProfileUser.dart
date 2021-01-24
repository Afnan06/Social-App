import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileUser {
  final String id;

  final String pUrl;

  final String profileName;

  final String bio;

  ProfileUser({
    this.id,
    this.pUrl,
    this.profileName,
    this.bio,
  });

  factory ProfileUser.fromDocument(DocumentSnapshot doc) {
    return ProfileUser(
      id: doc.id,
      pUrl: doc['pUrl'],
      profileName: doc['profileName'],
      bio: doc['bio'],
    );
  }
}
