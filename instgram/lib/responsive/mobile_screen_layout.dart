import 'package:flutter/material.dart';
import 'package:instgram/models/user_model.dart';
import 'package:instgram/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = "";
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(child: Text(user.userName)),
    );
  }
}
