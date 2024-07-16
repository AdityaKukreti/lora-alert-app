import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference posts =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(
      String name, String username, String gender, String state, DateTime dob) {
    return posts.add({
      'email': user!.email,
      'name': name,
      'userid': username,
      'gender': gender,
      'state': state,
      'dob': dob,
      'timeStamp': Timestamp.now(),
    });
  }

  // Stream<QuerySnapshot> getPostStream() {
  //   final postStream = FirebaseFirestore.instance
  //       .collection('Posts')
  //       .orderBy('TimeStamp', descending: true)
  //       .snapshots();
  //   return postStream;
  // }
}
