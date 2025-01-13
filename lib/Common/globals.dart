import 'package:alcheringa/Database/DBHandler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Model/pass_model.dart';

FirebaseAuth auth = FirebaseAuth.instance;
bool isLoggedIn = false;
bool isVerified = false;
bool isLoading = false;
FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseStorage st = FirebaseStorage.instance;
double bottomNavBarHeight = 0;
List<PassModel> pass = [];
DBHandler dbHandler = DBHandler();
