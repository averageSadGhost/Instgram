// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:instgram/screens/login_screen.dart';
import 'package:instgram/theme/colors.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../services/assets_manger.dart';

class SplashPage extends StatefulWidget {
  final bool isLogin;
  const SplashPage({
    Key? key,
    required this.isLogin,
  }) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image(
        image: AssetImage(AssetsManger.instgramLogoPng),
        color: Colors.white,
      ),
      backgroundColor: mobileBackgroundColor,
      showLoader: false,
      navigator: widget.isLogin
          ? const LogInScreen()
          : const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
      durationInSeconds: 5,
    );
  }
}
