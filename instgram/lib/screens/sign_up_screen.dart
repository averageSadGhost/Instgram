import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instgram/screens/login_screen.dart';
import 'package:instgram/services/assets_manger.dart';
import 'package:instgram/services/image_picker.dart';
import 'package:instgram/services/show_snack_bar.dart';
import 'package:instgram/theme/colors.dart';
import 'package:instgram/widgets/custom_button.dart';
import 'package:instgram/widgets/custom_text_field.dart';
import '../services/auth_methods.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _selectedImage;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
  }

  void _selectImage() async {
    Uint8List image = await imagePicker(ImageSource.gallery);
    setState(() {
      _selectedImage = image;
    });
  }

  void _signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _userNameController.text,
      bio: _bioController.text,
      file: _selectedImage!,
    );

    setState(() {
      _isLoading = false;
    });

    if (res != "success") {
      // ignore: use_build_context_synchronously
      showSnackBar(res, context, true);
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(
          "Account created successfully, please login", context, false);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LogInScreen(),
        ),
      );
      // ignore: use_build_context_synchronously
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const ResponsiveLayout(
      //       webScreenLayout: WebScreenLayout(),
      //       mobileScreenLayout: MobileScreenLayout(),
      //     ),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),
              SvgPicture.asset(
                AssetsManger.instgramLogo,
                colorFilter: const ColorFilter.mode(
                  primaryColor,
                  BlendMode.srcIn,
                ),
                semanticsLabel: 'Instgram logo',
                height: 64,
              ),
              const SizedBox(height: 24),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  _selectedImage != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_selectedImage!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage:
                              AssetImage(AssetsManger.defaultPersonImage),
                        ),
                  InkWell(
                    onTap: () => _selectImage(),
                    child: const Icon(Icons.add_a_photo),
                  )
                ],
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: _userNameController,
                hintText: "Enter your username",
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: _emailController,
                hintText: "Enter your email",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: _passwordController,
                hintText: "Enter your password",
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: _bioController,
                hintText: "Enter your bio",
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      text: "Sign up",
                      onTap: () {
                        if (_emailController.text.isNotEmpty ||
                            _userNameController.text.isNotEmpty ||
                            _passwordController.text.isNotEmpty ||
                            _bioController.text.isNotEmpty) {
                          _signUpUser();
                        } else {
                          showSnackBar(
                            "All fields are required",
                            context,
                            true,
                          );
                        }
                      },
                    ),
              Flexible(flex: 3, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
