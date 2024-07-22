import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  User? user = FirebaseAuth.instance.currentUser;

  Map<String, dynamic> userData = {};

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('posts');

  Future<void> addUser(
      String name, String username, String gender, String state, DateTime dob) {
    return users.add({
      'email': user!.email,
      'name': name,
      'userid': username,
      'gender': gender,
      'state': state,
      'dob': dob,
      'timeStamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getPostStream() {
    final postStream = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('time', descending: true)
        .snapshots();
    return postStream;
  }

  Stream<QuerySnapshot> getCommentStream(String docId) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(docId)
        .collection('comments')
        .orderBy('time', descending: true)
        .snapshots();
  }

// Stream<QuerySnapshot> getPostStream() {
  //   final postStream = FirebaseFirestore.instance
  //       .collection('Posts')
  //       .orderBy('TimeStamp', descending: true)
  //       .snapshots();
  //   return postStream;
  // }
}

FirestoreDatabase userdb = FirestoreDatabase();
