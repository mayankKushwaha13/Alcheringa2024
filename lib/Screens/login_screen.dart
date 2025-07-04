import 'dart:io';

import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Common/resource.dart';
import 'package:alcheringa/Screens/loading%20screen.dart';
import 'package:alcheringa/Screens/main_screen.dart';
import 'package:alcheringa/Screens/profile_setup/setup_profile.dart';
import 'package:alcheringa/Screens/textscreens/privacy_policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:alcheringa/Screens/reset_password_screen.dart';
import '../Authentication/authenticationviewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false; // Track password visibility

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void _setLoggedIn(bool isLoggedin) {
    setState(() {
      isLoggedIn = isLoggedin;
    });
  }

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
            if(_isLoading)
              Center(
                child: CircularProgressIndicator(),
              )
            else
              Center(
                child: SingleChildScrollView(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: screenWidth * 0.9,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/loginborder1.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
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
                              SizedBox(height: screenHeight * 0.02),
                              const Text(
                                'Welcome back\nyour event journey\nstarts here',
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
                              SizedBox(height: screenHeight * 0.03),
                              _buildTextField(
                                  hint: 'Email',
                                  backgroundImage:
                                  'assets/images/emailbackground.png',
                                  controller: _emailController
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              _buildPasswordField(), // Use custom password field
                              SizedBox(height: screenHeight * 0.01),
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResetPasswordScreen(),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: screenWidth * 0.02,
                                    ),
                                    child: const Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        fontFamily: 'Game_Tape',
                                        color: Color(0xFFFF77A8),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.05),
                              GestureDetector(
                                onTap: _isLoading
                                    ? null
                                    : () async {

                                  if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                                    _setLoading(true);
                                    await customLogin(
                                      _emailController.text,
                                      _passwordController.text,
                                      context,
                                      onLoading: _setLoading,
                                      isLoggedIn: _setLoggedIn,
                                    );
                                    _setLoading(false);
                                  } else {
                                    showMessage('Email or password is empty', context);
                                  }

                                  if (auth.currentUser != null) {
                                    if (isLoggedIn && context.mounted && auth.currentUser!.emailVerified) {
                                      if (auth.currentUser!.metadata.creationTime ==
                                          auth.currentUser!.metadata.lastSignInTime) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (_) => ProfileSetup()),
                                        );
                                      } else {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const MainScreen()),
                                              (Route<dynamic> route) => false,
                                        );
                                      }
                                    }
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/signin.png', // Blue background image
                                      width: screenWidth * 0.5,
                                      height: screenHeight * 0.06,
                                      fit: BoxFit.fill,
                                    ),
                                    const Text(
                                      'Login',
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
                              SizedBox(height: screenHeight * 0.025),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Google Button
                                  _buildSocialButton(
                                      backgroundPath: 'assets/images/google.png',
                                      logoPath: 'assets/images/googlelogo.png',
                                      buttonSize: MediaQuery.of(context).size.width *
                                          0.18, // Background size
                                      logoSize: MediaQuery.of(context).size.width *
                                          0.09, // Logo size
                                      onPressed: () async {
                                        // _setLoading(true);
                                        await signInWithGoogle(context, isLoggedIn: _setLoggedIn);
                                        // _setLoading(false);
                                        if (isLoggedIn && context.mounted) {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const MainScreen()),
                                                (Route<dynamic> route) => false,
                                          );
                                        }
                                      }
                                  ),
                                  // Spacing between buttons
                                  SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * 0.05),

                                  // Apple Button

                                  if (Platform.isIOS)
                                    _buildSocialButton(
                                      backgroundPath: 'assets/images/google.png',
                                      logoPath: 'assets/images/applelogo.png',
                                      buttonSize: MediaQuery.of(context).size.width *
                                          0.18, // Background size
                                      logoSize: MediaQuery.of(context).size.width *
                                          0.09, // Logo size
                                      onPressed: () async {
                                        // _setLoading(true);
                                        await signInWithApple(context, isLoggedIn: _setLoggedIn);
                                        // _setLoading(false);
                                        if (isLoggedIn && context.mounted) {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const MainScreen()),
                                                (Route<dynamic> route) => false,
                                          );
                                        }
                                      }
                                  ),
                                  // Spacing between buttons
                                  SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * 0.05),

                                  // Outlook Button
                                  _buildSocialButton(
                                      backgroundPath: 'assets/images/outlook.png',
                                      logoPath: 'assets/images/outlooklogo.png',
                                      buttonSize:
                                      MediaQuery.of(context).size.width * 0.18,
                                      logoSize:
                                      MediaQuery.of(context).size.width * 0.09,
                                      onPressed: () async {
                                        _setLoading(true);
                                        await signInWithMicrosoft(context, isLoggedIn: _setLoggedIn);
                                        _setLoading(false);
                                        if (isLoggedIn && context.mounted) {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const MainScreen()),
                                                (Route<dynamic> route) => false,
                                          );
                                        }
                                      }
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.03),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()));
                                },
                                child: const Text(
                                  'Privacy policy',
                                  style: TextStyle(
                                    fontFamily: 'Game_Tape',
                                    color: Color(0xFFFF77A8),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
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

  Widget _buildTextField({
    required String hint,
    bool isPassword = false,
    required String backgroundImage,
    required TextEditingController controller,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.7,
      height: screenHeight * 0.07,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.fill,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(
          fontFamily: 'Game_Tape',
          fontSize: 20,
          color: Color(0xFFFF77A8),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Game_Tape',
            fontSize: 20,
            color: Color(0xFFFF77A8),
          ),
          border: InputBorder.none,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  // Custom Password Field with Show/Hide functionality
  Widget _buildPasswordField() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.7,
      height: screenHeight * 0.07,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/emailbackground.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: TextField(
        controller: _passwordController,
        obscureText: !_isPasswordVisible, // Toggle visibility
        style: TextStyle(
          fontFamily: 'Game_Tape',
          fontSize: 20,
          color: Color(0xFFFF77A8),
        ),
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: const TextStyle(
            fontFamily: 'Game_Tape',
            fontSize: 20,
            color: Color(0xFFFF77A8),
          ),
          border: InputBorder.none,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Color(0xFFFF77A8),
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible; // Toggle visibility
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String backgroundPath,
    required String logoPath,
    required double buttonSize,
    required double logoSize,
    required Future<void> Function() onPressed
  }) {
    return GestureDetector(
      onTap: () async {
        await onPressed();
      },
      child: SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background of the button
            Image.asset(
              backgroundPath,
              width: buttonSize,
              height: buttonSize,
              fit: BoxFit.cover,
            ),
            // Centered logo inside the button
            Image.asset(
              logoPath,
              width: logoSize,
              height: logoSize,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
