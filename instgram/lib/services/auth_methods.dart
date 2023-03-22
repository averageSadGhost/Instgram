import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instgram/services/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String photoUrl = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);
        await _fireStore.collection("users").doc(cred.user!.uid).set(
          {
            "username": username,
            "uid": cred.user!.uid,
            "email": email,
            "bio": bio,
            "followers": [],
            "following": [],
            "profilePicUrl": photoUrl,
          },
        );
        debugPrint(cred.toString());
        res = "success";
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }
}
