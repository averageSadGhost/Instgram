import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String uid;
  final String photoUrl;
  final String userName;
  final String bio;
  final List followers;
  final List following;

  UserModel({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.userName,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "username": userName,
        "uid": uid,
        "email": email,
        "bio": bio,
        "followers": followers,
        "following": following,
        "profilePicUrl": photoUrl,
      };
  static UserModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;
    return UserModel(
      email: snapshot["email"],
      uid: snapshot["uid"],
      photoUrl: snapshot["profilePicUrl"],
      userName: snapshot["username"],
      bio: snapshot["bio"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }
}
