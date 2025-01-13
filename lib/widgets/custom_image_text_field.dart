import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomImageTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isNumber;

  const CustomImageTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.isNumber = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 330.0, // Set desired width
          height: 54, // Set desired height
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/checkout_textField.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: TextField(
              keyboardType: isNumber? TextInputType.number : null,
              inputFormatters: isNumber?[FilteringTextInputFormatter.digitsOnly]:null,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none, // Remove default border
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 7,
                ),
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Game_Tape',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
