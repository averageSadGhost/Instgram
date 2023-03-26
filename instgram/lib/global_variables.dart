import 'package:flutter/material.dart';
import 'package:instgram/screens/add_post_screen.dart';
import 'package:instgram/screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  Center(child: Text("Search")),
  AddPostScreen(),
  Center(child: Text("Notifications")),
  Center(child: Text("Profile")),
];
