import 'package:cloud_firestore/cloud_firestore.dart';

class CommentStructure {
  String userid;
  String comment;
  DateTime time;

  CommentStructure(this.userid, this.comment, this.time);
}

class PostStructure {
  String username;
  String userid;
  String title;
  String content;
  DateTime time;
  String state;
  int commentCount;
  String type;

  PostStructure(this.username, this.userid, this.title, this.content, this.time,
      this.state, this.commentCount, this.type);
}

List<PostStructure> posts = [
  PostStructure(
      "Community Alert System",
      "User001",
      "Flood Warning in Assam",
      "A severe flood is expected along the Brahmaputra river. Residents are advised to secure their homes and prepare for possible evacuations.",
      DateTime(2024, 7, 20, 14, 00),
      "Assam",
      3,
      "Weather"),
  PostStructure(
      "Urban Traffic Updates",
      "User002",
      "Metro Construction Update",
      "Due to metro construction, several roads in the downtown area of Bengaluru will be closed from 10 AM to 5 PM today. Please plan alternate routes.",
      DateTime(2024, 7, 20, 8, 00),
      "Karnataka",
      2,
      "Traffic"),
  PostStructure(
      "Wildlife Department",
      "User003",
      "Leopard Sighting in Sanjay Gandhi National Park",
      "Recent leopard sightings have been reported in the Sanjay Gandhi National Park. Visitors are advised to be cautious and follow park guidelines.",
      DateTime(2024, 7, 19, 16, 30),
      "Maharashtra",
      4,
      "Wildlife"),
  PostStructure(
      "City Health Updates",
      "User004",
      "Vaccination Drive in Delhi",
      "A special vaccination drive will be held at local health centers in Delhi this weekend to manage the recent flu outbreak. No appointment is necessary.",
      DateTime(2024, 7, 18, 9, 00),
      "Delhi",
      1,
      "Health"),
  PostStructure(
      "School District Alerts",
      "User005",
      "Schools Closure Due to Heat Wave",
      "All schools in Jaipur will be closed for the next two days due to an intense heat wave. Please check the district website for updates.",
      DateTime(2024, 7, 21, 15, 30),
      "Rajasthan",
      5,
      "Weather")
];

List<List<CommentStructure>> allComments = [
  [
    CommentStructure("Commenter1", "Is the evacuation mandatory?",
        DateTime(2024, 7, 20, 14, 30)),
    CommentStructure(
        "Commenter2", "What about pets?", DateTime(2024, 7, 20, 14, 35)),
    CommentStructure(
        "Commenter3", "Thanks for the update!", DateTime(2024, 7, 20, 14, 40)),
  ],
  [
    CommentStructure("Commenter4", "Which roads are affected?",
        DateTime(2024, 7, 20, 8, 15)),
    CommentStructure(
        "Commenter5", "This helps, thanks!", DateTime(2024, 7, 20, 8, 25)),
  ],
  [
    CommentStructure("Commenter6", "Saw the leopard yesterday!",
        DateTime(2024, 7, 19, 17, 00)),
    CommentStructure("Commenter7", "Are the trails still open?",
        DateTime(2024, 7, 19, 17, 15)),
    CommentStructure(
        "Commenter8", "Thanks for the warning!", DateTime(2024, 7, 19, 17, 25)),
    CommentStructure("Commenter9", "Very helpful, stay safe everyone.",
        DateTime(2024, 7, 19, 17, 35)),
  ],
  [
    CommentStructure("Commenter10", "What times are the clinics open?",
        DateTime(2024, 7, 18, 9, 10)),
  ],
  [
    CommentStructure("Commenter11", "Will the schools have online classes?",
        DateTime(2024, 7, 21, 15, 45)),
    CommentStructure("Commenter12", "Thank you for the heads up.",
        DateTime(2024, 7, 21, 15, 50)),
    CommentStructure("Commenter13", "Any idea when they will reopen?",
        DateTime(2024, 7, 21, 15, 55)),
    CommentStructure(
        "Commenter14", "Stay cool everyone!", DateTime(2024, 7, 21, 16, 00)),
    CommentStructure("Commenter15", "Thanks for keeping us informed.",
        DateTime(2024, 7, 21, 16, 05)),
  ]
];

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> uploadPosts() async {
    for (int i = 0; i < posts.length; i++) {
      var post = posts[i];
      var comments = allComments[i];

      // Create a new document for the post in the 'posts' collection
      DocumentReference postRef = _db.collection('posts').doc();

      await _db.runTransaction((transaction) async {
        // Set the post data
        transaction.set(postRef, {
          'username': post.username,
          'userid': post.userid,
          'title': post.title,
          'content': post.content,
          'time': Timestamp.fromDate(post.time),
          'state': post.state,
          'commentCount': comments.length,
          'type': post.type,
        });

        // Add each comment to the 'comments' subcollection
        for (var comment in comments) {
          DocumentReference commentRef = postRef.collection('comments').doc();
          transaction.set(commentRef, {
            'userid': comment.userid,
            'comment': comment.comment,
            'time': Timestamp.fromDate(comment.time),
          });
        }
      });
    }
  }
}
