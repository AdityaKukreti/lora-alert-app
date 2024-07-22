import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatTimestamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  DateTime now = DateTime.now();
  DateTime justNow = DateTime.now().subtract(Duration(minutes: 1));
  DateTime localDateTime = dateTime.toLocal();

  if (!localDateTime.difference(justNow).isNegative) {
    return "Just now";
  }

  String roughTimeString =
      DateFormat('h:mm a').format(localDateTime); // e.g., 5:08 PM
  Duration difference = now.difference(localDateTime);

  if (difference.inDays == 0) {
    // Less than 24 hours
    return roughTimeString;
  } else if (difference.inDays == 1) {
    // Yesterday
    return "Yesterday";
  } else if (difference.inDays < 7) {
    // Days ago
    return "${difference.inDays} days ago";
  } else if (difference.inDays < 30) {
    // Weeks ago
    int weeks = (difference.inDays / 7).floor();
    return "$weeks week${weeks > 1 ? 's' : ''} ago";
  } else if (difference.inDays < 365) {
    // Months ago
    int months = (difference.inDays / 30).floor();
    return "$months month${months > 1 ? 's' : ''} ago";
  } else {
    // Years ago
    int years = (difference.inDays / 365).floor();
    return "$years year${years > 1 ? 's' : ''} ago";
  }
}
