import 'package:flutter/material.dart';

import 'build_confirmation_tab.dart';
import 'build_details_tab.dart';
import 'build_review_tab.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _currentIndex = 1;

  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressLine1Controller = TextEditingController();
  final TextEditingController addressLine2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  // Function to validate fields
  bool areFieldsValid() {
    return nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        addressLine1Controller.text.isNotEmpty &&
        addressLine2Controller.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        stateController.text.isNotEmpty &&
        pincodeController.text.isNotEmpty;
  }

  // Show a snackbar if validation fails
  void showValidationError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please fill in all fields before proceeding.'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                height: 84,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              SizedBox(height: 20.0),

              // Progress Bar Section (Conditional)
              if (_currentIndex !=
                  3) // Only show this in Details and Review tabs
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 345.0,
                      height: 54,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/progress_details.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Tab Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTab("Details", 1),
                        SizedBox(width: 99),
                        _buildTab("Review", 2),
                      ],
                    ),
                  ],
                ),
              SizedBox(height: 16.0),

              // Content Section
              _buildContentForTab(_currentIndex),
              SizedBox(height: 16.0),

              // Next Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 55),
                child: GestureDetector(
                  onTap: () {
                    if ((areFieldsValid() && _currentIndex == 1)) {
                      setState(() {
                        _currentIndex++;
                      });
                    } else if ((!areFieldsValid() && _currentIndex == 1)) {
                      showValidationError();
                    } else if (_currentIndex < 3) {
                      setState(() {
                        _currentIndex++;
                      });
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 206,
                        height: 59,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _currentIndex != 3
                                ? AssetImage('assets/images/next_button.png')
                                : AssetImage(
                                    'assets/images/continue_shopping.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        _currentIndex < 3 ? 'Next' : 'Continue\nShopping',
                        style: TextStyle(
                          fontFamily: 'Brick_Pixel',
                          color: Colors.white,
                          fontSize: _currentIndex != 3 ? 20.0 : 24,
                          fontWeight: FontWeight.w400,
                          height: 0.9,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Tab Builder
  Widget _buildTab(String title, int index) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Game_Tape',
        color: _currentIndex == index
            ? Colors.white
            : Color.fromRGBO(131, 118, 156, 1),
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  // Content Builder
  Widget _buildContentForTab(int index) {
    switch (index) {
      case 1:
        return buildDetailsTab(
          nameController: nameController,
          phoneController: phoneController,
          addressLine1Controller: addressLine1Controller,
          addressLine2Controller: addressLine2Controller,
          cityController: cityController,
          stateController: stateController,
          pincodeController: pincodeController,
        );
      case 2:
        return buildReviewTab(
            name: nameController.text,
            phone: phoneController.text,
            addressLine1: addressLine1Controller.text,
            addressLine2: addressLine2Controller.text,
            city: cityController.text,
            state: stateController.text,
            pincode: pincodeController.text,
            context: context);
      case 3:
        return buildConfirmationTab();
      default:
        return SizedBox.shrink();
    }
  }
}
