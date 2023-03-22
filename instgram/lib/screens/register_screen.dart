import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instgram/services/assets_manger.dart';
import 'package:instgram/services/image_picker.dart';
import 'package:instgram/theme/colors.dart';
import 'package:instgram/widgets/custom_button.dart';
import 'package:instgram/widgets/custom_text_field.dart';

import '../services/auth_methods.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _selectedImage;

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
              CustomButton(
                  text: "Sign up",
                  onTap: () async {
                    String res = await AuthMethods().signUpUser(
                      email: _emailController.text,
                      password: _passwordController.text,
                      username: _userNameController.text,
                      bio: _bioController.text,
                      file: _selectedImage!,
                    );
                    debugPrint(res);
                  }),
              Flexible(flex: 3, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
