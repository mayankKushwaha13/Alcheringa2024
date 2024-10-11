import 'package:alcheringa/Common/resource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void resetPassword(String email, BuildContext context){
  FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((_) {
    showMessage('Password Reset Mail has been sent to $email', context);
  }).catchError((error) {
    showMessage('Your account does not exist', context);
  });
}
