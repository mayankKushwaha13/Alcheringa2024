import 'package:alcheringa/Authentication/reset_password.dart';
import 'package:alcheringa/Screens/login_screen.dart';
import 'package:alcheringa/common/resource.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/pattern.png',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.9,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/loginborder1.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: screenHeight * 0.044,
                            ),
                            SizedBox(
                              height: screenHeight * 0.18,
                              child: Image.asset(
                                'assets/images/mainlogo.png',
                                fit: BoxFit.contain, // Larger logo
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            const Text(
                              'Forgot your password ?\n No worries, we got you\n covered !',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Game_Tape',
                                fontSize: 27,
                                height: 1.05,
                                color: Color(0xFF2DABFF),
                                shadows: [
                                  Shadow(
                                    color: Color(0xFF212F54),
                                    offset: Offset(2.0, 1.0),
                                    blurRadius: 0.0,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.06),
                            Container(
                              width: screenWidth * 0.7,
                              height: screenHeight * 0.07,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/emailbackground.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: TextField(
                                controller: _emailController,
                                style: TextStyle(
                                  fontFamily: 'Game_Tape',
                                  fontSize: 20,
                                  color: Color(0xFFFF77A8),
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: const TextStyle(
                                    fontFamily: 'Game_Tape',
                                    fontSize: 20,
                                    color: Color(0xFFFF77A8),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 14),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.05),
                            GestureDetector(
                              onTap: () {
                                String email = _emailController.text.trim();

                                RegExp emailRegex = RegExp(
                                    r'^[A-Za-z0-9._+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
                                if (email.isNotEmpty &&
                                    emailRegex.hasMatch(email)) {
                                  resetPassword(email, context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                                } else {
                                  showMessage(
                                      'Please enter valid email address',
                                      context);
                                }


                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/signin.png', // Blue background image
                                    width: screenWidth * 0.45,
                                    height: screenHeight * 0.06,
                                    fit: BoxFit.fill,
                                  ),
                                  const Text(
                                    'Reset',
                                    style: TextStyle(
                                      fontFamily: 'Brick_Pixel',
                                      fontSize: 26,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black,
                                          offset: Offset(2, 2),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.05),
                            SizedBox(height: screenHeight * 0.025),
                            SizedBox(height: screenHeight * 0.03),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -screenHeight * 0.025,
                      right: -screenWidth * 0.05,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/images/backbackground.png',
                              width: screenWidth * 0.2,
                              fit: BoxFit.fill,
                            ),
                            Image.asset(
                              'assets/images/backbutton.png',
                              width: screenWidth * 0.16,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
