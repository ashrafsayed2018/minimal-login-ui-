import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  const CustomTextField({
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          obscureText: isPassword,
          controller: controller,
          decoration: InputDecoration(
            fillColor: Colors.grey.shade200,
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 10),
          ),
        ),
      ),
    );
  }
}
