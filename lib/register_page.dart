import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_login_ui/widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({required this.showLoginPage, Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future _register() async {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    }
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
            "Hello there",
            style: GoogleFonts.bebasNeue(
              fontSize: 36,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Register below with your details",
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
            height: 15,
          ),
          // confirm password text field
          CustomTextField(
            controller: _confirmPasswordController,
            hintText: "confirm your password",
            isPassword: true,
          ),
          const SizedBox(
            height: 20,
          ),
          // sign in button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: GestureDetector(
              onTap: _register,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          // not a memeber register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "already have an account ?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: widget.showLoginPage,
                child: const Text(
                  "  Login now",
                  style: TextStyle(
                    color: Colors.blue,
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
