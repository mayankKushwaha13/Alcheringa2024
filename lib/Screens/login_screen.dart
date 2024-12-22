import 'package:flutter/material.dart';
import 'package:alcheringa/Screens/reset_password_screen.dart';
import 'package:alcheringa/screens/home_screen.dart';
import 'package:alcheringa/authentication/authenticationviewmodel.dart';
import '../common/globals.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
                          SizedBox(height: screenHeight * 0.02),
                          const Text(
                            'Welcome back\nyour event journey\nstarts here',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Alcherpixel',
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
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          _buildTextField(
                            hint: 'Password',
                            isPassword: true,
                            backgroundImage:
                                'assets/images/emailbackground.png',
                          ),
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
                                  right: screenWidth * 0.1,
                                ),
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontFamily: 'Alcherpixel',
                                    color: Color(0xFFFF77A8),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
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
                                    await login(_emailController.text,
                                        _passwordController.text, context,
                                        onLoading: _setLoading);
                                    if (isLoggedIn && context.mounted) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()),
                                      );
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
                                    fontFamily: 'Alcherpixel',
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black45,
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
                              ),
                              // Spacing between buttons
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05),

                              // Apple Button
                              _buildSocialButton(
                                backgroundPath: 'assets/images/google.png',
                                logoPath: 'assets/images/applelogo.png',
                                buttonSize:
                                    MediaQuery.of(context).size.width * 0.18,
                                logoSize:
                                    MediaQuery.of(context).size.width * 0.09,
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
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          const Text(
                            'Privacy policy',
                            style: TextStyle(
                              fontFamily: 'Alcherpixel',
                              color: Color(0xFFFF77A8),
                              fontSize: 16,
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
    );
  }

  Widget _buildTextField({
    required String hint,
    bool isPassword = false,
    required String backgroundImage,
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
        obscureText: isPassword,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Alcherpixel',
            fontSize: 26,
            color: Color(0xFFFF77A8),
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String backgroundPath,
    required String logoPath,
    required double buttonSize,
    required double logoSize,
  }) {
    return SizedBox(
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
    );
  }
}
