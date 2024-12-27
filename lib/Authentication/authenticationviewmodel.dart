import 'dart:io';

import 'package:alcheringa/common/resource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/globals.dart';

Future<void> customSignUp(String email, String password, BuildContext context,
    {required Function(bool) onLoading}) async {
  onLoading(true);
  try {
    final UserCredential userCredential =
        await auth.createUserWithEmailAndPassword(
            email: email.trim(), password: password);

    final name = auth.currentUser!.displayName ?? "Unknown";
    final currentUserEmail = auth.currentUser!.email;
    if (userCredential.user != null) {
      if (context.mounted) {
        await registerUserInDatabaseCustom(name, currentUserEmail!);
        await sendVerificationEmail(context);
        isLoggedIn = true;
      }
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

Future<void> registerUserInDatabaseCustom(String name, String email) async {
  try {
    db.collection('USERS').doc(email).snapshots().listen((snapshot) async {
      if (!snapshot.exists) {
        Map<String, dynamic> data = {
          "Name": name,
          "Email": email,
        };

        try {
          await db.collection('USERS').doc(email).set(data);
          print("Added user to database");
        } catch (e) {
          print("Error occurred while adding user to database: $e");
        }
      }
    });
  } catch (e) {
    print("Error in registering user: $e");
  }
}

Future<void> addIntrestToDb(List<String> intrestList, String email) async {
  try {
    
    final doc = db.collection('USERS').doc(email).collection("interests").doc("interests");

    await doc.set({"interests": FieldValue.arrayUnion(intrestList)});

    print("interests added succesfully from fxn addIntrestToDb()");
  } catch (e) {
    print("Error addIntrestToDb() fxn: $e");
  }
}


Future<void> updateProfilePicture(File file, String email) async {
  final ext = file.path.split('.').last;

  final ref = st.ref().child('USERS/$email.$ext');

  await ref
      .putFile(file, SettableMetadata(contentType: 'image/$ext'))
      .then((p0) {
    print('Data transfered: ${p0.bytesTransferred / (1024 * 1024)}Mb');
  });

  //updating image in database
  String url = await ref.getDownloadURL();
  await db.collection('USERS').doc(email).update({
    'PhotoURL': url,
  });
}

void onUpdateProfile(BuildContext context, File image, String email) {
  updateProfilePicture(image, email).then((_) {
    // Show success Snackbar
    print("updated pfp");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }).catchError((error) {
    // Show error Snackbar
    print("eroor pfp");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to update profile: $error'),
        backgroundColor: Colors.red,
      ),
    );
  });
}

Future<void> sendVerificationEmail(BuildContext context) async {
  try {
    User? user = auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      showMessage('An Email has been sent to you for verification', context);
    } else {
      showMessage('Error sending verification email', context);
    }
  } catch (e) {
    print("Error sending verification email: $e");
    showMessage('Error sending verification email', context);
  }
}

Future<void> customLogin(String email, String password, BuildContext context,
    {required Function(bool) onLoading,
    required Function(bool) isLoggedIn}) async {
  onLoading(true);
  try {
    final UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email.trim(), password: password);

    if (userCredential.user != null) {
      if (!auth.currentUser!.emailVerified) {
        showMessage('Please verify using Email first', context);
        onLoading(false);
        return;
      }
      print("running after link");
      await saveSignInUserData(userCredential.user!);
      isLoggedIn(true);
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
    if (context.mounted) {
      showMessage('An error occurred. Please try again.', context);
    }
  }
  onLoading(false);
}

Future<void> signInWithGoogle(BuildContext context,
    {required Function(bool) onLoading,
    required Function(bool) isLoggedIn}) async {
  onLoading(true);
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final userCredentials = await auth.signInWithCredential(credential);

    if (userCredentials.user != null) {
      await saveSignInUserData(userCredentials.user!);
      print('Sign in with google succeed');

      showMessage('Google Sign-In success', context);
      isLoggedIn(true);
    } else {
      print(
          "Sign in with google failed: UserCredential is ${userCredentials.user}");
      showMessage('Google Sign-In failed', context);
    }
  } on Exception catch (e) {
    print("Sign in with google failed $e");
    showMessage('Google Sign-In failed', context);
  }
  onLoading(false);
}

Future<void> signInWithMicrosoft(BuildContext context,
    {required Function(bool) onLoading,
    required Function(bool) isLoggedIn}) async {
  onLoading(true);

  try {
    final microsoftProvider = MicrosoftAuthProvider();
    microsoftProvider.setCustomParameters(
        {'tenant': '850aa78d-94e1-4bc6-9cf3-8c11b530701c'});

    final userCredentials = await auth.signInWithProvider(microsoftProvider);
    if (userCredentials.user != null) {
      await saveSignInUserData(userCredentials.user!);
      isLoggedIn(true);
      showMessage('Microsoft Sign-In Success ', context);
    } else {
      showMessage('Microsoft Sign-In failed', context);
    }
  } on Exception catch (e) {
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
