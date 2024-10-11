import 'package:alcheringa/Authentication/reset_password.dart';
import 'package:alcheringa/common/resource.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.chevron_left),
                ),
              ),
              Text(
                'Enter your email here',
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                controller: _emailController,
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      String email = _emailController.text.trim();
                      RegExp emailRegex = RegExp(r'^[A-Za-z0-9._+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
                      if (email.isNotEmpty && emailRegex.hasMatch(email)) {
                        resetPassword(email, context);
                      } else {
                        showMessage('Please enter valid email address', context);
                      }
                    },
                    child: Text('Reset Password'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
