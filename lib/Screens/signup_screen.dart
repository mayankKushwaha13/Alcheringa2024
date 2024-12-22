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
  bool _isLoading = false;

  final _emailRegex = RegExp(r"^(?=.{1,64}@)[A-Za-z0-9_-]+(\.[A-Za-z0-9_-]+)*@"
      r"[^-][A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*(\.[A-Za-z]{2,})$");

  void _setLoading(bool isLoading) {
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
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      const Text("Email"),
                      TextField(controller: _emailController),
                      const SizedBox(height: 16),
                      const Text("Password"),
                      TextField(
                          controller: _passwordController, obscureText: true),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                await customSignUp(_emailController.text,
                                    _passwordController.text, context,
                                    onLoading: _setLoading);
                                if (isLoggedIn) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                  );
                                }
                              },
                        child: const Text("Sign Up"),
                      ),
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
