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
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16), // Consistent padding
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Game_Tape',
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 2),
          CustomImageTextField(
            hintText: 'Enter your name',
            controller: nameController,
            maxChar: 15,
          ),
          SizedBox(height: 10),
          CustomImageTextField(
            hintText: 'Phone Number',
            controller: phoneController,
            isNumber: true,
            maxChar: 10,
          ),
          SizedBox(height: 40),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Address Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Game_Tape',
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 2),
          CustomImageTextField(
            hintText: 'Address Line 1',
            controller: addressLine1Controller,
            maxChar: 30,
          ),
          SizedBox(height: 10),
          CustomImageTextField(
            hintText: 'Address Line 2',
            controller: addressLine2Controller,
            maxChar: 30,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Flexible(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity, // Adjust width
                      height: 54,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/checkout_textField2.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
                          controller: cityController,
                          maxLength: 15,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: 'City',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
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
              ),
              SizedBox(width: 8),
              Flexible(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity, // Adjust width
                      height: 54,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/checkout_textField2.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
                          controller: stateController,
                          // maxLength: 15,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: 'State',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 7,
                            ),
                          ),
                          maxLines: 1,
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
              ),
            ],
          ),
          SizedBox(height: 10),
          CustomImageTextField(
            hintText: 'Pincode',
            controller: pincodeController,
            isNumber: true,
            maxChar: 6,
          ),
          SizedBox(height: 19),
        ],
      ),
    ),
  );
}
