import 'package:flutter/material.dart';

class SignUpTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final double height;
  final bool obscure;

  const SignUpTextfield({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.height,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 225 / 51 * height, // Set desired width
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/fill_login.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: TextField(
              obscureText: obscure,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Color.fromARGB(255, 179, 64, 118)),
                border: InputBorder.none, // Remove default border
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 5
                ),
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'AlcherPixel',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
