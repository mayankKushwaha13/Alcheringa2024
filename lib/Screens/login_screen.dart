import 'package:alcheringa/authentication/authenticationviewmodel.dart';
import 'package:alcheringa/screens/home_screen.dart';
import 'package:alcheringa/screens/signup_screen.dart';
import 'package:flutter/gestures.dart';
import '../common/globals.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _setLoading(bool isLoading){
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _isLoading ? 
            const Center( child: CircularProgressIndicator())
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Email"),
                TextField(controller: _emailController),
                const SizedBox(height: 16),
                const Text("Password"),
                TextField(controller: _passwordController, obscureText: true),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                    await login(_emailController.text, _passwordController.text, context, onLoading: _setLoading);
                    if(isLoggedIn && context.mounted){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    }
                  },
                  child: const Text("Login"),
                ),
                const SizedBox(height: 30.0,),
                RichText(
                  text: TextSpan(
                    text: "Signup page",
                    style: const TextStyle(
                      color: Colors.black
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const SignupScreen(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;

                            final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 500), // Adjust the duration as needed
                        ),
                      );
                    }
                  ),
                )
              ],
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
