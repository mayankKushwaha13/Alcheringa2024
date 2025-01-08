import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PixelTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final double horizontalPdding;
  final double height;

  const PixelTextField({
    super.key,
    this.controller,
    this.hintText = 'Search Food',
    this.onChanged,
    this.keyboardType,
    this.horizontalPdding= 20.0,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - (horizontalPdding * 2),
      height: height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/textField.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontFamily: 'AlcherpixelBold'
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
                color: Color(0xff83769c),
                fontFamily: 'AlcherpixelBold',
                fontSize: 22
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 8,
            ),
          ),
        ),
      ),
    );
  }
}