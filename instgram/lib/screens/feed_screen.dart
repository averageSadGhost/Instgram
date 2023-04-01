import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instgram/services/assets_manger.dart';
import 'package:instgram/theme/colors.dart';
import 'package:instgram/widgets/post_widet.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          AssetsManger.instgramLogo,
          // ignore: deprecated_member_use
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint("chat");
            },
            icon: const Icon(
              Icons.messenger_outline,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("posts")
            .orderBy("datePublished", descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            int count = snapshot.data!.docs.length;
            return count == 0
                ? const Center(
                    child: Text(
                      "No posts to show",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.builder(
                    itemCount: count,
                    itemBuilder: (context, index) => PostWidget(
                      snap: snapshot.data!.docs[index].data(),
                    ),
                  );
          }
        },
      ),
    );
  }
}
