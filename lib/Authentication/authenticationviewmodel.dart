import 'package:alcheringa/common/resource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../common/globals.dart';

Future<void> signUp(String email, String password, BuildContext context,
    {required Function(bool) onLoading}) async {
  onLoading(true);
  try {
    isLoading = true;
    final UserCredential userCredential =
        await auth.createUserWithEmailAndPassword(
            email: email.trim(), password: password);
    isLoggedIn = true;
    if (context.mounted) {
      showMessage('Registration Successful', context);
      isLoading = false;
    }
  } on FirebaseAuthException catch (e) {
    String message;
    if (e.code == 'weak-password') {
      message = 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      message = 'The account already exists for that email.';
    } else {
      message = 'Registration failed. Please try again.';
    }
    if (context.mounted) showMessage(message, context);
  } catch (e) {
    if (context.mounted) {
      showMessage('An error occurred. Please try again.', context);
    }
  }
  onLoading(false);
}

Future<void> login(String email, String password, BuildContext context,
    {required Function(bool) onLoading}) async {
  onLoading(true);
  try {
    final UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email.trim(), password: password);
    isLoggedIn = true;
    if (context.mounted) showMessage('Login Successful', context);
  } on FirebaseAuthException catch (e) {
    String message;
    if (e.code == 'user-not-found') {
      message = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      message = 'Wrong password provided.';
    } else {
      message = 'Login failed. Please try again.';
    }
    if (context.mounted) showMessage(message, context);
  } catch (e) {
    if (context.mounted) {
      showMessage('An error occurred. Please try again.', context);
    }
  }
  onLoading(false);
}
