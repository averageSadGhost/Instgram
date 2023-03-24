import 'package:flutter/material.dart';
import 'package:instgram/screens/add_post_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  Center(child: Text("Feed")),
  Center(child: Text("Search")),
  AddPostScreen(),
  Center(child: Text("Notifications")),
  Center(child: Text("Profile")),
];
