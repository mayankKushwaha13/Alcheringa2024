import 'dart:async';

import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Model/view_model_main.dart';
import 'package:alcheringa/Screens/merch_screen.dart';
import 'package:alcheringa/Screens/welcome_screen.dart';
import 'package:alcheringa/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../Database/DBHandler.dart';
import '../Notification/notification_services.dart';
import '../firebase_options.dart';
import '../provider/cart_provider.dart';

@pragma('vm:entry-poiny')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DBHandler dbHandler = DBHandler();
  await dbHandler.database;
  final cartProvider = CartProvider();
  await cartProvider.loadCartFromDatabase();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ViewModelMain()),
      ChangeNotifierProvider(create: (_) => cartProvider),
      // ChangeNotifierProvider(
      //   create: (_) => ScheduleViewModel(),
      //   child: Schedule(),
      // )
    ],
    child: MyApp(),
  ));
  // runApp(ChangeNotifierProvider<ViewModelMain>(
  //   create: (context) => ViewModelMain(),
  //   child: MyApp(),
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ViewModelMain>(context, listen: false).getAllEvents();

    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
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
  NotificationServices notificationSerivces = NotificationServices();

  Future<void> _requestPermission() async {
    await ViewModelMain().requestNotificationPermission();
    await ViewModelMain().requestLocationPermission();
  }

  @override
  void initState() {
    super.initState();
    isLoggedIn = auth.currentUser != null;
    isVerified = isLoggedIn && auth.currentUser!.emailVerified ?? false;
    // notificationSerivces.requestNotificationPermission();
    notificationSerivces.forgroundMessage();
    notificationSerivces.firebaseInit(context);
    _requestPermission();
    notificationSerivces.isTokenRefresh();
    // notificationSerivces.getDeviceToken().then((value) {
    //   print(value);
    // });

    _controller = VideoPlayerController.asset("assets/SplashMovie/splash_screen.mp4")
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          isUserLoggedIn = isLoggedIn;
        });
      });

    Timer(
      const Duration(seconds: 3),
      () {
        // checking signup screen, change it to main screen after done
        final nextScreen = isUserLoggedIn && isVerified ? const MainScreen() : welcomeScreen();
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
