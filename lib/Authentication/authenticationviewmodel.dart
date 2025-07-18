import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:alcheringa/common/resource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image/image.dart' as img;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../common/globals.dart';
import '../main.dart';

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

Future<void> registerUserInDatabaseCustom(String name, String email,
    [String? PhotoURL]) async {
  try {
    db.collection('USERS').doc(email).snapshots().listen((snapshot) async {
      if (!snapshot.exists) {
        Map<String, dynamic> data = {
          "Name": name,
          "Email": email,
          'PhotoURL': PhotoURL ?? ''
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

Future<void> updateUserName(String name, String email) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final doc = db.collection('USERS').doc(email);
    final data = {'Name': name};

    await doc.update(data);
    prefs.setString('userName', name ?? '');

    print("name added successfully to firestore");
  } catch (e) {
    print("Error name updating fxn: $e");
  }
}

Future<void> addIntrestToDb(List<String> intrestList, String email) async {
  try {
    final doc = db
        .collection('USERS')
        .doc(email)
        .collection("interests")
        .doc("interests");

    await doc.set({"interests": FieldValue.arrayUnion(intrestList)});

    print("interests added succesfully from fxn addInterestToDb()");
  } catch (e) {
    print("Error addInterestToDb() fxn: $e");
  }
}

Future<void> updateProfilePicture(File file, String email, String name) async {
  try {
    // Step 1: Read the file as bytes
    List<int> imageBytes = await file.readAsBytes();

    // Step 2: Decode the image
    img.Image? image = img.decodeImage(Uint8List.fromList(imageBytes));
    if (image == null) {
      throw Exception("Unable to decode the image file");
    }

    // Step 3: Compress the image
    List<int> compressedBytes = img.encodeJpg(image, quality: 60);

    // Step 4: Upload to Firebase Storage
    final ref = FirebaseStorage.instance
        .ref()
        .child('Users/$email.jpg'); // Use a unique path
    TaskSnapshot uploadSnapshot = await ref.putData(
      Uint8List.fromList(compressedBytes),
      SettableMetadata(contentType: 'image/jpeg'), // Set MIME type explicitly
    );

    if (uploadSnapshot.state != TaskState.success) {
      throw Exception("Failed to upload the image");
    }

    print(
        'Data transferred: ${uploadSnapshot.bytesTransferred / (1024 * 1024)} MB');

    // Step 5: Get the download URL
    String url = await ref.getDownloadURL();
    print("Download URL: $url");

    // Step 6: Update Firestore with the correct URL
    await FirebaseFirestore.instance.collection('USERS').doc(email).update({
      'Name': name,
      'PhotoURL': url,
    });

    // Step 7: Update SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    await prefs.setString('PhotoURL', url);

    print('Profile picture updated successfully!');
  } catch (e, stackTrace) {
    print("Error updating profile picture: $e");
    print("Stack trace: $stackTrace");
  }
}

void onUpdateProfile(
    BuildContext context, File image, String email, String name) {
  // Show progress indicator dialog
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissing the dialog
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Center(child: CircularProgressIndicator()),
      );
    },
  );

  updateProfilePicture(image, email, name).then((_) {
    Navigator.pop(context); // Close the progress dialog
    // Show success Snackbar
    print("updated pfp");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }).catchError((error) {
    Navigator.pop(context); // Close the progress dialog
    // Show error Snackbar
    print("error pfp");
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
  final prefs = await SharedPreferences.getInstance();
  try {
    final UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email.trim(), password: password);

    if (userCredential.user != null) {
      if (!auth.currentUser!.emailVerified) {
        showMessage('Please verify using Email first', context);
        onLoading(false);
        return;
      }
      final userData = await db
          .collection('USERS')
          .doc(email)
          .get()
          .then((docSnapshot) async {
        if (docSnapshot.exists) {
          final data = docSnapshot.data() as Map<String, dynamic>;
          await prefs.setString('userName', data['Name'] ?? '');
          await prefs.setString('email', data['Email']);
          await prefs.setString('PhotoURL', data['PhotoURL'] ?? '');
        } else {
          await saveSignInUserData(userCredential.user!);
        }
      });
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
      showMessage('An error occurred. Please try again', context);
    }
  }
  onLoading(false);
}

Future<void> signInWithGoogle(BuildContext context,
    {required Function(bool) isLoggedIn}) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final prefs = await SharedPreferences.getInstance();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final userCredentials = await auth.signInWithCredential(credential);

    if (userCredentials.user != null) {
      final userData = await db
          .collection('USERS')
          .doc(userCredentials.user!.email)
          .get()
          .then((docSnapshot) async {
        if (docSnapshot.exists) {
          final data = docSnapshot.data() as Map<String, dynamic>;
          await prefs.setString('userName', data['Name'] ?? '');
          await prefs.setString('email', data['Email']);
          await prefs.setString('PhotoURL', data['PhotoURL'] ?? '');
        } else {
          await registerUserInDatabaseCustom(
              userCredentials.user!.displayName ?? 'Unknown',
              userCredentials.user!.email!,
              userCredentials.user!.photoURL);
          await saveSignInUserData(userCredentials.user!);
        }
      });
      print('Sign in with google succeed');

      showMessage('Google Sign-In success', context);
      isLoggedIn(true);
    } else {
      print(
          "Sign in with google failed: UserCredential is ${userCredentials.user}");
      showMessage('Google Sign-In failed', context);
    }
  } on Exception catch (e) {
    log("Sign in with google failed $e");
    showMessage('Google Sign-In failed', context);
  }
}

Future<void> signInWithApple(BuildContext context, {required Function(bool) isLoggedIn}) async {
  try {
    final prefs = await SharedPreferences.getInstance();

    // Request the Apple ID Credential
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    // Create OAuthCredential for Firebase Auth
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    // Sign in with Firebase Auth
    final userCredentials = await auth.signInWithCredential(oauthCredential);

    if (userCredentials.user != null) {
      final user = userCredentials.user!;
      if(userCredentials.additionalUserInfo!.isNewUser){
        await registerUserInDatabaseCustom(user.displayName ?? 'Unknown', user.email!, user.photoURL);
        await saveSignInUserData(user);
      }
      final email = prefs.getString('email');
      final userData = await db.collection('USERS').doc(email).get();
      if (userData.exists) {
        final data = userData.data() as Map<String, dynamic>;
        await prefs.setString('userName', data['Name'] ?? '');
        await prefs.setString('email', data['Email']);
        await prefs.setString('PhotoURL', data['PhotoURL'] ?? '');
      }

      print('Sign in with Apple succeeded');
      showMessage('Apple Sign-In success', context);
      isLoggedIn(true);
    } else {
      print("Sign in with Apple failed: UserCredential is null");
      showMessage('Apple Sign-In failed', context);
    }
  } on Exception catch (e) {
    log("Sign in with Apple failed: $e");
    showMessage('Apple Sign-In failed', context);
  }
}

Future<void> signInWithMicrosoft(BuildContext context,
    {required Function(bool) isLoggedIn}) async {
  final prefs = await SharedPreferences.getInstance();
  try {
    final microsoftProvider = MicrosoftAuthProvider();
    microsoftProvider.setCustomParameters(
        {'tenant': '850aa78d-94e1-4bc6-9cf3-8c11b530701c'});

    final userCredentials = await auth.signInWithProvider(microsoftProvider);
    if (userCredentials.user != null) {
      final userData = await db
          .collection('USERS')
          .doc(userCredentials.user!.email)
          .get()
          .then((docSnapshot) async {
        if (docSnapshot.exists) {
          final data = docSnapshot.data() as Map<String, dynamic>;
          await prefs.setString('userName', data['Name'] ?? '');
          await prefs.setString('email', data['Email']);
          await prefs.setString('PhotoURL', data['PhotoURL'] ?? '');
        } else {
          await registerUserInDatabaseCustom(
              userCredentials.user!.displayName ?? 'Unknown',
              userCredentials.user!.email!,
              userCredentials.user!.photoURL);
          await saveSignInUserData(userCredentials.user!);
        }
      });
      isLoggedIn(true);
      showMessage('Microsoft Sign-In Success ', context);
    } else {
      showMessage('Microsoft Sign-In failed', context);
    }
  } on Exception catch (e) {
    log("Sign in with microsoft failed $e");
    showMessage('Microsoft Sign-In failed', context);
    print(e);
  }
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

// Function to delete the user's account
// Future<void> deleteUserAccount(BuildContext context) async {
//   try {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       await user.delete(); // Delete the user account
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Account deleted successfully.")),
//       );
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => SplashScreen()));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("No user is signed in.")),
//       );
//     }
//   } catch (e) {
//     // Handle reauthentication requirement or other errors
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Error deleting account: $e")),
//     );
//   }
// }

Future<void> reauthenticateAndDeleteAccount(BuildContext context, {required Function(bool) isLoggedIn}) async {
  isLoggedIn(true);
  try {
    final user = FirebaseAuth.instance.currentUser;
    final db = FirebaseFirestore.instance;

    if (user == null) return;

    final providerId = user.providerData.isNotEmpty
        ? user.providerData.first.providerId
        : null;

    if (providerId == null) {
      print('No provider found for this user.');
      return;
    }
    try {
      AuthCredential? credential;
      if(providerId == 'microsoft.com'){
        final microsoftProvider = MicrosoftAuthProvider();
        microsoftProvider.setCustomParameters(
            {'tenant': '850aa78d-94e1-4bc6-9cf3-8c11b530701c'});

        final userCredentials = await user.reauthenticateWithProvider(microsoftProvider);
      }

      if (providerId == 'google.com') {
        // Reauthenticate with Google
        print('Reauthenticating with Google...');
        final googleUser = await GoogleSignIn().signIn();
        final googleAuth = await googleUser?.authentication;
        if (googleAuth != null) {
          credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
        }
      } else if (providerId == 'apple.com') {
        // Reauthenticate with Apple
        print('Reauthenticating with Apple...');
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
        credential = OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken,
          accessToken: appleCredential.authorizationCode,
        );
      } else if (providerId == 'password') {
        // Reauthenticate with Email/Password
        print('Reauthenticating with Email/Password...');
        final email = user.email;
        final password = await promptForPassword(context);
        credential = EmailAuthProvider.credential(
          email: email!,
          password: password ?? '',
        );
      }
      if (credential != null) {
        // Reauthenticate with the generated credential
        await user.reauthenticateWithCredential(credential);
        print('Reauthentication successful!');
      } else {
        print('Failed to generate credential for provider: $providerId');
      }
    } catch (e) {
      print('Error during reauthentication: $e');
    }
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');

    print("Reauthentication successful for ${email}");
    // Delete the Firestore document
    await deleteUserAndData(email!);
    print("User document deleted successfully.");

    // Delete the Firebase account
    await user.delete();

    // Navigate to the splash screen
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SplashScreen()));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Wrong password. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.message}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }
  isLoggedIn(false);
}

Future<void> deleteUserAndData(String userEmail) async {
  try {
    // Reference to the user document
    final userDoc = db.collection('USERS').doc(userEmail);

    // Delete documents in the first collection (if it exists)
    final collection1 = userDoc.collection('ORDERS');
    final docs1 = await collection1.get();
    if (docs1.docs.isNotEmpty) {
      final batch1 = db.batch();
      for (final doc in docs1.docs) {
        batch1.delete(doc.reference);
      }
      await batch1.commit();
    }

    // Delete documents in the second collection (if it exists)
    final collection2 = userDoc.collection('interests');
    final docs2 = await collection2.get();
    if (docs2.docs.isNotEmpty) {
      final batch2 = db.batch();
      for (final doc in docs2.docs) {
        batch2.delete(doc.reference);
      }
      await batch2.commit();
    }

    // Finally delete the user document itself
    await userDoc.delete();
    final storageRef = FirebaseStorage.instance.ref().child('Users/$userEmail.jpg');

    try {
      // Attempt to delete the file
      await storageRef.delete();
      print('File deleted successfully.');
    } catch (e) {
      if (e is FirebaseException && e.code == 'object-not-found') {
        // File does not exist
        print('File does not exist, nothing to delete.');
      } else {
        // Handle other potential errors
        print('Error occurred: $e');
      }
    }
  } catch (e) {
    print('Error deleting user data: $e');
    throw e;
  }
}

Future<String?> promptForPassword(BuildContext context) async {
  String? password;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      final controller = TextEditingController();
      return AlertDialog(
        title: const Text("Re-enter Password"),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: const InputDecoration(labelText: "Password"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              password = controller.text;
              Navigator.of(context).pop();
            },
            child: const Text("Confirm"),
          ),
        ],
      );
    },
  );
  return password;
}

Future<void> deleteAccount(BuildContext context, {required Function(bool) isLoggedIn}) async {
  reauthenticateAndDeleteAccount(context, isLoggedIn: isLoggedIn);
}
