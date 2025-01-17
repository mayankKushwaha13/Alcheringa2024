import 'dart:math';

import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';
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
  String DATA = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  // Function to validate fields
  bool areFieldsValid() {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressLine1Controller.text.isEmpty ||
        addressLine2Controller.text.isEmpty ||
        cityController.text.isEmpty ||
        stateController.text.isEmpty ||
        pincodeController.text.isEmpty) {
      showValidationError('Please fill in all fields before proceeding.');
      return false;
    }

    if (phoneController.text.length != 10 || !RegExp(r'^\d{10}$').hasMatch(phoneController.text)) {
      showValidationError('Phone number must be of 10 digits.');
      return false;
    }

    if (pincodeController.text.length != 6 || !RegExp(r'^\d{6}$').hasMatch(pincodeController.text)) {
      showValidationError('Pincode must be of 6 digits.');
      return false;
    }

    return true;
  }

  String randomString(int len) {
    final Random random = Random();
    final StringBuffer sb = StringBuffer();
    for (int i = 0; i < len; i++) {
      sb.write(DATA[random.nextInt(DATA.length)]);
    }
    return sb.toString();
  }

  // Show a snackbar if validation fails
  void showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider =
    Provider.of<CartProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: kToolbarHeight + 20,
          backgroundColor: Color(0xFF0f162a),
          automaticallyImplyLeading: false,
          title: Container(
            padding: EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/back_button.png',
                    width: 50.0,
                    height: 50.0,
                  ),
                ),
                Text(
                  "Check Out",
                  style: TextStyle(
                    fontFamily: 'Game_Tape',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFFFF1E8),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: isLoading
          ? Center(
            child: CircularProgressIndicator(),
          )
          : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /* // Header Section
                Container(
                  width: double.infinity,
                  height: 84,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Image.asset(
                            'assets/images/back_button.png',
                            width: 54.0,
                            height: 54.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                 */
                SizedBox(height: 20.0),
                // Progress Bar Section (Conditional)
                if (_currentIndex != 3) // Only show this in Details and Review tabs
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 54,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/progress_details.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      // Tab Text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTab("Details", 1),
                          _buildTab("Review", 2),
                        ],
                      ),
                    ],
                  ),
                SizedBox(height: 16.0),

                // Content Section
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: _buildContentForTab(_currentIndex)),
                SizedBox(height: 16.0),

                // Next Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: GestureDetector(
                    onTap: () {
                      if (_currentIndex == 1 && areFieldsValid()) {
                        setState(() {
                          _currentIndex++;
                        });
                      } else if (_currentIndex > 1 && _currentIndex < 3) {
                        setState(() {
                          _currentIndex++;
                        });
                        viewModelMain.addOrderToFirebase(cartProvider.cartItems, randomString(20), nameController.text, phoneController.text, '${addressLine1Controller.text}, ${addressLine2Controller.text}', stateController.text, cityController.text, pincodeController.text, context);
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 206,
                            height: 59,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: _currentIndex != 3
                                    ? AssetImage('assets/images/next_button.png')
                                    : AssetImage('assets/images/continue_shopping.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if(_currentIndex == 3) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
                            }
                          },
                          child: Text(
                            _currentIndex < 3 ? 'Next' : 'Continue\nShopping',
                            style: TextStyle(
                              fontFamily: 'Brick_Pixel',
                              color: Colors.white,
                              fontSize: _currentIndex != 3 ? 20.0 : 24,
                              fontWeight: FontWeight.w400,
                              height: 0.9,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
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
        color: _currentIndex == index ? Colors.white : Color.fromRGBO(131, 118, 156, 1),
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
        return BuildReviewTab(
          name: nameController.text,
          phone: phoneController.text,
          addressLine1: addressLine1Controller.text,
          addressLine2: addressLine2Controller.text,
          city: cityController.text,
          state: stateController.text,
          pincode: pincodeController.text, /* context: context */
        );
      case 3:
        return buildConfirmationTab();
      default:
        return SizedBox.shrink();
    }
  }
}
