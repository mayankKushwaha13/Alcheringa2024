import 'package:alcheringa/widgets/custom_image_text_field.dart';
import 'package:flutter/material.dart';

Widget buildDetailsTab({
  required TextEditingController nameController,
  required TextEditingController phoneController,
  required TextEditingController addressLine1Controller,
  required TextEditingController addressLine2Controller,
  required TextEditingController cityController,
  required TextEditingController stateController,
  required TextEditingController pincodeController,
}) {
  return Padding(
    padding: EdgeInsets.only(left: 45),
    child: SingleChildScrollView(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Game_Tape',
                  color: Colors.white),
            ),
            SizedBox(
              height: 2,
            ),
            CustomImageTextField(
                hintText: 'Enter your name', controller: nameController),
            SizedBox(
              height: 10,
            ),
            CustomImageTextField(
                hintText: 'Phone Number', controller: phoneController),
            SizedBox(
              height: 97,
            ),
            Text(
              'Address Details',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Game_Tape',
                  color: Colors.white),
            ),
            SizedBox(
              height: 2,
            ),
            CustomImageTextField(
                hintText: 'Address Line 1', controller: addressLine1Controller),
            SizedBox(
              height: 10,
            ),
            CustomImageTextField(
                hintText: 'Address Line 2', controller: addressLine2Controller),
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
                          image: AssetImage(
                              'assets/images/checkout_textField2.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
                          controller: cityController,
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
                            fontFamily: 'Game_Tape',
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
                          image: AssetImage(
                              'assets/images/checkout_textField2.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
                          controller: stateController,
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
                            fontFamily: 'Game_Tape',
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
                hintText: 'Pincode', controller: pincodeController),
            SizedBox(
              height: 19,
            ),
          ],
        ),
      ),
    ),
  );
}
