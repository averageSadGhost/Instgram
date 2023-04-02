import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instgram/screens/add_post_screen.dart';
import 'package:instgram/screens/feed_screen.dart';
import 'package:instgram/screens/profile_screen.dart';
import 'package:instgram/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Center(child: Text("Notifications")),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
