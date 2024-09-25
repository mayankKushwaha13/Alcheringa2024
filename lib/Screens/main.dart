import 'dart:async';
import 'package:alcheringa/Model/eventdetail.dart';
import 'package:alcheringa/Model/view_model_main.dart';
import 'package:alcheringa/screens/login_screen.dart';
import 'package:alcheringa/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../common/globals.dart';
import '../firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider<ViewModelMain>(
      create: (context) => ViewModelMain(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ViewModelMain>(context, listen: false).getAllEvents();
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  late bool isUserLoggedIn;

  @override
  void initState() {
    super.initState();
    isLoggedIn = auth.currentUser != null;

    ViewModelMain().getAllEvents();
    _controller = VideoPlayerController.asset("assets/SplashMovie/splash_screen.mp4")..initialize().then((_) {
        setState(() {
          _controller.play();
          isUserLoggedIn = isLoggedIn;
        });
      });

    Timer(
      const Duration(seconds: 3),
          () {
        final nextScreen = isUserLoggedIn ? const MainScreen() : const LoginScreen();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => nextScreen),
        );
      },
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(child: VideoPlayer(_controller)),
    );
  }
}
