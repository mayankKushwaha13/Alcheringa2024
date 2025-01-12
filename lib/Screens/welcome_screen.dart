import 'package:alcheringa/Screens/signup_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class welcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              'assets/images/background.png', // Path to your background image
              fit: BoxFit.cover, // Makes sure the image covers the screen
            ),

            // Logo on top of the background
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  // color: Colors.red,
                  // width: 390, // Adjust logo size
                  // height: 900,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.asset('assets/images/alcher_logo.png'),
                  ),
                ),
              ),
            ),

            // // First button with text
            // Positioned(
            //   bottom: 150, // Adjust as needed
            //   left: MediaQuery.of(context).size.width / 2 - 95, // Centered horizontally
            //   child: ,
            // ),

            // Second button with text and additional text below
            Positioned(
              bottom: 65,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    },
                    child: SizedBox(
                      width: 190,
                      height: 50,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/green_button.png',
                            fit: BoxFit.contain,
                          ),
                          Text(
                            'Login',
                            style: TextStyle(
                                fontFamily: 'Brick_Pixel',
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                shadows: [
                                  Shadow(
                                      offset: Offset(2.5, 2),
                                      color: Colors.black,
                                      blurRadius: 2),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  // Button with text
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ));
                    },
                    child: SizedBox(
                      width: 190,
                      height: 50,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/green_button.png',
                            fit: BoxFit.contain,
                          ),
                          Text(
                            'Sign up',
                            style: TextStyle(
                                fontFamily: 'Brick_Pixel',
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                shadows: [
                                  Shadow(
                                      offset: Offset(2.5, 2),
                                      color: Colors.black,
                                      blurRadius: 2),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Text below the button
                  SizedBox(height: 5), // Spacing between button and text
                  // Text(
                  //   'or Continue as a guest',
                  //   style: TextStyle(
                  //     fontFamily: 'Game_Tape',
                  //     color: Color(0xff2DABFF),
                  //     fontSize: 16,
                  //
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
