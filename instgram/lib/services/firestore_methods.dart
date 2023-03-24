import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instgram/models/post_model.dart';
import 'package:instgram/services/storage_methods.dart';
import 'package:uuid/uuid.dart';

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
}
