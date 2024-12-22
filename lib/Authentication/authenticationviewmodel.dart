import 'package:alcheringa/common/resource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/globals.dart';

Future<void> customSignUp(String email, String password, BuildContext context,
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
    if (context.mounted)
      showMessage('An error occurred. Please try again.', context);
  }
  onLoading(false);
}

Future<void> customLogin(String email, String password, BuildContext context,
    {required Function(bool) onLoading}) async {
  onLoading(true);
  try {
    final UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email.trim(), password: password);

    if(userCredential.user !=null) {
      await saveSignInUserData(userCredential.user!);
      isLoggedIn = true;
      if (context.mounted) showMessage('Login Successful', context);
    }
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
    if (context.mounted)
      showMessage('An error occurred. Please try again.', context);
  }
  onLoading(false);
}


Future<void> signInWithGoogle(BuildContext context, {required Function(bool) onLoading}) async {
  onLoading(true);
  try{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final userCredentials = await auth.signInWithCredential(credential);

    if(userCredentials.user != null) {
      await saveSignInUserData(userCredentials.user!);
      print('Sign in with google succeed');

      showMessage('Google Sign-In success', context);
      isLoggedIn = true;
    } else {
      print("Sign in with google failed: UserCredential is ${userCredentials.user}");
      showMessage('Google Sign-In failed', context);
    }
  } on Exception catch(e) {
    print("Sign in with google failed $e");
    showMessage('Google Sign-In failed', context);
  }
  onLoading(false);
}

Future<void> signInWithMicrosoft(BuildContext context, {required Function(bool) onLoading}) async {
  onLoading(true);

  try{
    final microsoftProvider = MicrosoftAuthProvider();
    microsoftProvider.setCustomParameters({'tenant': '850aa78d-94e1-4bc6-9cf3-8c11b530701c'});

    final userCredentials = await auth.signInWithProvider(microsoftProvider);
    if(userCredentials.user != null) {
      await saveSignInUserData(userCredentials.user!);
      isLoggedIn = true;
      showMessage('Microsoft Sign-In Success ', context);
    }else{
      showMessage('Microsoft Sign-In failed', context);
    }
  } on Exception catch(e) {
    showMessage('Microsoft Sign-In failed', context);
    print(e);
  }
  onLoading(false);
}

Future<void> saveSignInUserData(User user) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userName', user.displayName ?? "Unknown");
  await prefs.setString('email', user.email!);
  await prefs.setString('PhotoURL', user.photoURL ?? "");
}

Future<void> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    isLoggedIn = false;
  } on Exception catch (e) {
    print(e);
  }
}