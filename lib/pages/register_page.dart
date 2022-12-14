import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_login_ui/constants/colors.dart';
import 'package:minimal_login_ui/widgets/custom_button.dart';
import 'package:minimal_login_ui/widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({required this.showLoginPage, Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future _register() async {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      try {
        // create user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());

        // add user to users table in firbase database

        addUserToDatabse(
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            int.parse(_ageController.text.trim()),
            _emailController.text.trim(),
            _passwordController.text.trim());
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
  }

  Future addUserToDatabse(String firstName, String lastName, int age,
      String email, String password) async {
    await FirebaseFirestore.instance.collection("users").add({
      "first_name": firstName,
      "last_name": lastName,
      "age": age,
      "email": email,
      "password": password,
    });
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
          const SizedBox(height: 30),

          // firstname text field

          CustomTextField(
              controller: _firstNameController,
              hintText: "Enter your first name"),
          const SizedBox(
            height: 10,
          ),

          // lastname text field

          CustomTextField(
              controller: _lastNameController,
              hintText: "Enter your last name"),
          const SizedBox(
            height: 10,
          ),

          // age text field

          CustomTextField(
              controller: _ageController, hintText: "Enter your age"),
          const SizedBox(
            height: 10,
          ),
          // email text field

          CustomTextField(
              controller: _emailController, hintText: "Enter your Email"),
          const SizedBox(
            height: 10,
          ),
          // password text field
          CustomTextField(
            controller: _passwordController,
            hintText: "Enter your password",
            isPassword: true,
          ),
          const SizedBox(
            height: 10,
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
          CustomButton(text: "Sign Up", action: _register),
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
