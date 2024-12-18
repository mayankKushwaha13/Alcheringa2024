import 'package:alcheringa/widgets/custom_image_text_field.dart';
import 'package:flutter/material.dart';

Widget buildDetailsTab() {
  return Padding(
    padding: EdgeInsets.only(left: 45),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Information',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'AlcherPixel',
              color: Colors.white),
        ),
        SizedBox(
          height: 2,
        ),
        CustomImageTextField(
            hintText: 'Enter your name', controller: TextEditingController()),
        SizedBox(
          height: 10,
        ),
        CustomImageTextField(
            hintText: 'Phone Number', controller: TextEditingController()),
        SizedBox(
          height: 97,
        ),
        Text(
          'Address Details',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'AlcherPixel',
              color: Colors.white),
        ),
        SizedBox(
          height: 2,
        ),
        CustomImageTextField(
            hintText: 'Address Line 1', controller: TextEditingController()),
        SizedBox(
          height: 10,
        ),
        CustomImageTextField(
            hintText: 'Address Line 2', controller: TextEditingController()),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 162.0, // Set desired width
                  height: 54, // Set desired height
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/images/checkout_textField2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextField(
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                        hintText: 'City',
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
                        fontFamily: 'AlcherPixel',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 6,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 162.0, // Set desired width
                  height: 54, // Set desired height
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/images/checkout_textField2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextField(
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                        hintText: 'State',
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
                        fontFamily: 'AlcherPixel',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        CustomImageTextField(
            hintText: 'Pincode', controller: TextEditingController()),
        SizedBox(
          height: 19,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 55),
          child: GestureDetector(
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => checkoutPage()));
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 190.0, // Set desired width
                  height: 50.47, // Set desired height
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/sign_in.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  'Next', // Your text
                  style: TextStyle(
                    fontFamily: 'AlcherPixel',
                    color: Colors.white, // Text color
                    fontSize: 36.0, // Text size
                    fontWeight: FontWeight.w400, // Optional: Bold text
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
