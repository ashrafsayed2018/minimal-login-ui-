import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_login_ui/constants/colors.dart';
import 'package:minimal_login_ui/pages/forget_password_page.dart';
import 'package:minimal_login_ui/widgets/custom_button.dart';
import 'package:minimal_login_ui/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({required this.showRegisterPage, Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future _signIn() async {
    try {
      // loading circle

      showDialog(
          context: context,
          builder: ((context) {
            return const Center(child: CircularProgressIndicator());
          }));
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("error"),
              content: Text(e.message!),
            );
          });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 50,
          ),
          const Icon(
            Icons.android_sharp,
            size: 100,
            color: Colors.deepPurple,
          ),
          const SizedBox(
            height: 50,
          ),
          // hello text
          Text(
            "Hello Again",
            style: GoogleFonts.bebasNeue(
              fontSize: 36,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Welcome back you have been missed",
            style: GoogleFonts.bebasNeue(
              fontSize: 18,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 50),
          // email text field

          CustomTextField(
              controller: _emailController, hintText: "Enter your Email"),
          const SizedBox(
            height: 15,
          ),
          // password text field

          CustomTextField(
            controller: _passwordController,
            hintText: "Enter your password",
            isPassword: true,
          ),

          const SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ForgetPasswordPage();
                    }));
                  },
                  child: const Text(
                    "forget password ?",
                    style: TextStyle(
                      color: AppColor.kLinkColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // sign in button
          CustomButton(
            text: "Sign In",
            action: _signIn,
          ),
          const SizedBox(
            height: 25,
          ),
          // not a memeber register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Not a memeber ?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: widget.showRegisterPage,
                child: const Text(
                  "  Register now",
                  style: TextStyle(
                    color: AppColor.kLinkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
