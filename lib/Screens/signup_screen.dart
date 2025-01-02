import 'package:alcheringa/Screens/home_screen.dart';
import 'package:alcheringa/Screens/main_screen.dart';
import 'package:alcheringa/authentication/AuthenticationViewModel.dart';
import 'package:alcheringa/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '../common/globals.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;
  bool isButtonPressed = false;

  final _emailRegex = RegExp(r"^(?=.{1,64}@)[A-Za-z0-9_-]+(\.[A-Za-z0-9_-]+)*@"
      r"[^-][A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*(\.[A-Za-z]{2,})$");

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  void _setIsLoggedIn(bool status){
    setState(() {
      isLoggedIn = status;
    });
  }

  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    // Validation checks
    if (email.isEmpty) {
      _showError("Please fill your email address");
      return;
    }

    if (!_emailRegex.hasMatch(email)) {
      _showError("Please enter a valid email address");
      return;
    }

    if (password.isEmpty) {
      _showError("Please enter a password");
      return;
    }

    if (password.length <= 7) {
      _showError("Password length must be greater than 7");
      return;
    }

    if (confirmPassword != password) {
      _showError("Passwords do not match");
      return;
    }

    _setLoading(true);
    await customSignUp(email, password, context, onLoading: _setLoading);
    _setLoading(false);

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                            image: AssetImage(
                              "assets/images/loginborder1.png",
                            ),
                            fit: BoxFit.fill)),
                    child: Container(
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Padding(
                              padding: EdgeInsets.all(screenWidth * 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: screenHeight * 0.14,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(height: screenHeight * 0.03),
                                      _buildTextField(
                                          hint: 'Email',
                                          backgroundImage:
                                              'assets/images/emailbackground.png',
                                          controller: _emailController),
                                      SizedBox(height: screenHeight * 0.02),
                                      _buildTextField(
                                          hint: 'Password',
                                          isPassword: true,
                                          backgroundImage:
                                              'assets/images/emailbackground.png',
                                          controller: _passwordController),
                                      SizedBox(height: screenHeight * 0.02),
                                      _buildTextField(
                                          hint: 'Confirm Password',
                                          isPassword: true,
                                          backgroundImage:
                                              'assets/images/emailbackground.png',
                                          controller: _confirmPasswordController),
                                      SizedBox(height: screenHeight * 0.01),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Ink(
                                    child: InkWell(
                                        onTap: _isLoading
                                            ? null
                                            : () async {
                                                await _signUp();
                                                if (isLoggedIn) {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LoginScreen()),
                                                  );
                                                }
                                              },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image(
                                              width: screenWidth * 0.5,
                                              height: screenHeight * 0.06,
                                              image: AssetImage(
                                                  "assets/images/sign_in.png"),
                                            ),
                                            Text(
                                              "Sign up",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontFamily: 'AlcherPixel',
                                                  fontWeight: FontWeight.w400,
                                                  shadows: [
                                                    Shadow(
                                                        offset: Offset(2.5, 2),
                                                        color: Colors.black,
                                                        blurRadius: 2),
                                                  ]),
                                            ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    "Or",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 179, 64, 118),
                                      fontSize: 18,
                                      fontFamily: 'AlcherPixel',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Google Button
                                      _buildSocialButton(
                                          backgroundPath:
                                              'assets/images/google.png',
                                          logoPath:
                                              'assets/images/googlelogo.png',
                                          buttonSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.18, // Background size
                                          logoSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.09, // Logo size
                                          onPressed: () async {
                                            await signInWithGoogle(context,
                                                onLoading: _setLoading, isLoggedIn: _setIsLoggedIn);
                                            if (isLoggedIn && context.mounted) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MainScreen()),
                                              );
                                            }
                                          }),
                                      // Spacing between buttons
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05),

                                      // Apple Button
                                      _buildSocialButton(
                                        backgroundPath:
                                            'assets/images/google.png',
                                        logoPath: 'assets/images/applelogo.png',
                                        buttonSize:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        logoSize:
                                            MediaQuery.of(context).size.width *
                                                0.09,
                                        onPressed: () async {
                                          await signInWithGoogle(context,
                                              onLoading: _setLoading, isLoggedIn: _setIsLoggedIn);
                                          if (isLoggedIn && context.mounted) {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MainScreen()),
                                            );
                                          }
                                        },
                                      ),
                                      // Spacing between buttons
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05),

                                      // Outlook Button
                                      _buildSocialButton(
                                          backgroundPath:
                                              'assets/images/outlook.png',
                                          logoPath:
                                              'assets/images/outlooklogo.png',
                                          buttonSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.18,
                                          logoSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.09,
                                          onPressed: () async {
                                            await signInWithMicrosoft(context,
                                                onLoading: _setLoading, isLoggedIn: _setIsLoggedIn);
                                            if (isLoggedIn && context.mounted) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MainScreen()),
                                              );
                                            }
                                          }),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.01,
                                  ),
                                  Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 179, 64, 118),
                                      fontSize: 18,
                                      fontFamily: 'AlcherPixel',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.025,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Go to Login Page
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image(
                                            width: screenWidth * 0.5,
                                            height: screenHeight * 0.06,
                                            image: AssetImage(
                                                "assets/images/login.png")),
                                        Text(
                                          "Login",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontFamily: 'AlcherPixel',
                                              fontWeight: FontWeight.w400,
                                              shadows: [
                                                Shadow(
                                                    offset: Offset(2.5, 2),
                                                    color: Colors.black),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
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
          fontFamily: 'Alcherpixel',
          fontSize: 20,
          color: Color(0xFFFF77A8),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Alcherpixel',
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

  Widget _buildSocialButton(
      {required String backgroundPath,
      required String logoPath,
      required double buttonSize,
      required double logoSize,
      required Future<void> Function() onPressed}) {
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
