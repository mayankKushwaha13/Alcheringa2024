import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
bool isLoggedIn = false;
bool isLoading = false;
FirebaseFirestore db = FirebaseFirestore.instance;