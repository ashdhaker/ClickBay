import 'dart:typed_data';

import 'package:clickbay_flutter/resources/auth_method.dart';
import 'package:clickbay_flutter/screens/login_screen.dart';
import 'package:clickbay_flutter/utils/colors.dart';
import 'package:clickbay_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive.dart';
import '../responsive/web_screen_layout.dart';
import '../widget/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isloading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    // print(res);

    setState(() {
      _isloading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      //
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  void navigateToLogIn() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          // svg image
          SvgPicture.asset(
            'assets/image2vector.svg',
            color: primaryColor,
            height: 64,
          ),
          const SizedBox(
            height: 64,
          ),

          //circular widget to accept and show selected file
          Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    )
                  : const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                      backgroundColor: Colors.red,
                    ),
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                  onPressed: selectImage,
                  icon: const Icon(
                    Icons.add_a_photo,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          // text field input for username
          TextFieldInput(
              hintText: "Enter your username",
              textEditingController: _usernameController,
              textInputType: TextInputType.text),
          const SizedBox(
            height: 24,
          ),
          // text field input for email
          TextFieldInput(
              hintText: "Enter your Email",
              textEditingController: _emailController,
              textInputType: TextInputType.emailAddress),
          const SizedBox(
            height: 24,
          ),
          // text field input for password
          TextFieldInput(
            hintText: "Enter your Password",
            textEditingController: _passwordController,
            textInputType: TextInputType.emailAddress,
            isPass: true,
          ),
          const SizedBox(
            height: 24,
          ),
          // text field input for bio
          TextFieldInput(
              hintText: "Enter your Bio",
              textEditingController: _bioController,
              textInputType: TextInputType.text),
          const SizedBox(
            height: 24,
          ),
          // button login
          InkWell(
            onTap: signUpUser,
            child: Container(
              child: _isloading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : const Text("Sign Up"),
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                color: blueColor,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Flexible(
            child: Container(),
            flex: 2,
          ),

          //Transitioning to signing up
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: const Text("Don't have an Account?"),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
              ),
              GestureDetector(
                onTap: navigateToLogIn,
                child: Container(
                  child: const Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
        ]),
      )),
    );
  }
}
