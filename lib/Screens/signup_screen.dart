import 'package:alcheringa/Authentication/authenticationviewmodel.dart';
import 'package:alcheringa/Widgets/sign_up_textfield.dart';
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
    EdgeInsets padding = MediaQuery.of(context).padding;
    double safeAreaHeight = (padding.top) + (padding.bottom);
    return SafeArea(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.constrainHeight();
        height -= height / 639 * safeAreaHeight;
        double width = constraints.constrainWidth();
        double hRatio = height / 639;
        double wRatio = width / 364;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Container(
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/background.png",
                    ),
                    fit: BoxFit.cover)),
            child: Stack(
              // alignment: Alignment.center,
              children: [
                // Login Container
                Padding(
                  padding: EdgeInsets.only(
                      left: 26 * wRatio,
                      top: (height - 561 * hRatio) * hRatio / 2 + 23,
                      right: 26 * wRatio),
                  child: Image(
                    image: AssetImage('assets/images/login_container.png'),
                    height: 561 * hRatio,
                  ),
                ),
                // Back Button
                AnimatedPadding(
                  padding: EdgeInsets.only(
                      left: 295 * wRatio,
                      top: isButtonPressed
                          ? (height - 561 * hRatio) * hRatio / 2 + 25
                          : (height - 561 * hRatio) * hRatio / 2 + 15),
                  duration: Duration(milliseconds: 200),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isButtonPressed = !isButtonPressed;
                        Future.delayed(const Duration(milliseconds: 200), () {
                          setState(() {
                            isButtonPressed = !isButtonPressed;
                          });
                          // Pop to welcome screen
                          // Navigator.pop(context);
                        });
                      });
                    },
                    splashColor: Color.fromARGB(255, 179, 64, 118),
                    child: Image(
                      image: AssetImage('assets/images/back_button.png'),
                      height: 54 * hRatio,
                    ),
                  ),
                ),
                Container(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Padding(
                          padding: EdgeInsets.only(
                              left: 68, right: 68, top: 80 * hRatio),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  SignUpTextfield(
                                    hintText: "Email",
                                    controller: _emailController,
                                    height: 51 * hRatio,
                                  ),
                                  SizedBox(
                                    height: 10 * hRatio,
                                  ),
                                  SignUpTextfield(
                                    hintText: "Password",
                                    controller: _passwordController,
                                    height: 51 * hRatio,
                                    obscure: true,
                                  ),
                                  SizedBox(
                                    height: 10 * hRatio,
                                  ),
                                  SignUpTextfield(
                                    hintText: "Confirm Password",
                                    controller: _confirmPasswordController,
                                    height: 51 * hRatio,
                                    obscure: true,
                                  ),
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
                                          width: 132.48 * wRatio,
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
                                                    color: Colors.black),
                                              ]),
                                        ),
                                      ],
                                    )),
                              ),
                              Text(
                                "Or",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 179, 64, 118),
                                  fontSize: 18,
                                  fontFamily: 'AlcherPixel',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Image(
                                        width: 60 * wRatio,
                                        image: AssetImage(
                                            "assets/images/google_button.png")),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Image(
                                        width: 60 * wRatio,
                                        image: AssetImage(
                                            "assets/images/apple_button.png")),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Image(
                                        width: 60 * wRatio,
                                        image: AssetImage(
                                            "assets/images/outlook_button.png")),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
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
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Go to Login Page
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image(
                                        width: 150.59 * wRatio,
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
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Privacy Policy",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 179, 64, 118),
                                  fontSize: 18,
                                  fontFamily: 'AlcherPixel',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
