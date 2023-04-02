import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instgram/models/post_model.dart';
import 'package:instgram/services/storage_methods.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String userName,
    String profileImage,
  ) async {
    String res = "some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage("posts", file, true);
      String postId = const Uuid().v1();
      PostModel post = PostModel(
        description: description,
        uid: uid,
        userName: userName,
        datePublished: DateTime.now().toString(),
        postUrl: photoUrl,
        profileImage: profileImage,
        postId: postId,
        likes: [],
      );
      _firestore.collection("posts").doc(postId).set(post.toJson());
      res = "success";
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<void> likePost(String posdId, String uId, List likes) async {
    try {
      if (likes.contains(uId)) {
        await _firestore.collection("posts").doc(posdId).update({
          "likes": FieldValue.arrayRemove([uId]),
        });
      } else {
        await _firestore.collection("posts").doc(posdId).update({
          "likes": FieldValue.arrayUnion([uId]),
        });
      }
    } catch (error) {
      debugPrint("error on likePost ${error.toString()}");
    }
  }

  Future<void> likeComment(
      String commentId, String posttId, String uId, List likes) async {
    try {
      if (likes.contains(uId)) {
        await _firestore
            .collection("posts")
            .doc(posttId)
            .collection("comments")
            .doc(commentId)
            .update({
          "likes": FieldValue.arrayRemove([uId])
        });
      } else {
        await _firestore
            .collection("posts")
            .doc(posttId)
            .collection("comments")
            .doc(commentId)
            .update({
          "likes": FieldValue.arrayUnion([uId])
        });
      }
    } catch (error) {
      debugPrint("error on likePost ${error.toString()}");
    }
  }

  Future<void> postComment(String postId, String text, String uId, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection("posts")
            .doc(postId)
            .collection("comments")
            .doc(commentId)
            .set({
          "profilePic": profilePic,
          "name": name,
          "uid": uId,
          "text": text,
          "commentId": commentId,
          "datePublished": DateTime.now(),
          "likes": [],
        });
      } else {
        debugPrint("Text is empty");
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      _firestore.collection("posts").doc(postId).delete();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> followUser(
    String uid,
    String followId,
  ) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection("users").doc(uid).get();
      List following = (snap.data() as dynamic)["following"];
      if (following.contains(followId)) {
        await _firestore.collection("users").doc(followId).update({
          "followers": FieldValue.arrayRemove([uid])
        });
        await _firestore.collection("users").doc(uid).update({
          "following": FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection("users").doc(followId).update({
          "followers": FieldValue.arrayUnion([uid])
        });
        await _firestore.collection("users").doc(uid).update({
          "following": FieldValue.arrayUnion([followId])
        });
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
