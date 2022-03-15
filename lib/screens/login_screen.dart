import 'package:clickbay_flutter/resources/auth_method.dart';
import 'package:clickbay_flutter/screens/signup_screen.dart';
import 'package:clickbay_flutter/utils/colors.dart';
import 'package:clickbay_flutter/utils/global_variables.dart';
import 'package:clickbay_flutter/utils/utils.dart';
import 'package:clickbay_flutter/widget/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isloading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isloading = true;
    });

    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res == "success") {
      //
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      //
      showSnackBar(res, context);
    }
    setState(() {
      _isloading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupScreen()
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: MediaQuery.of(context).size.width>webScreenSize?
        EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/3)
        : 
        const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(
            child: Container(),
            flex: 1,
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
          // button login
          InkWell(
            onTap: loginUser,
            child: _isloading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  )
                : Container(
                    child: const Text("Log in"),
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
            flex: 1,
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
                onTap: navigateToSignUp,
                child: Container(
                  child: const Text(
                    "Sign Up.",
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
