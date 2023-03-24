import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String description;
  final String uid;
  final String userName;
  final String postId;
  final String datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  PostModel({
    required this.description,
    required this.uid,
    required this.userName,
    required this.datePublished,
    required this.postUrl,
    required this.profileImage,
    required this.postId,
    this.likes,
  });

  Map<String, dynamic> toJson() => {
        "username": userName,
        "uid": uid,
        "description": description,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "profileImage": profileImage,
      };
  static PostModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;
    return PostModel(
      postId: snapshot["postId"],
      description: snapshot["description"],
      uid: snapshot["uid"],
      userName: snapshot["username"],
      datePublished: snapshot["datePublished"],
      postUrl: snapshot["postUrl"],
      profileImage: snapshot["profileImage"],
    );
  }
}
