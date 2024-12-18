import 'package:flutter/material.dart';

import 'build_confirmation_tab.dart';
import 'build_details_tab.dart';
import 'build_review_tab.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_currentIndex > 1) {
                          setState(() {
                            _currentIndex--;
                          });
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset(
                        'assets/images/back_button.png',
                        width: 54.0,
                        height: 54.0,
                      ),
                    ),
                    Text(
                      'Checkout',
                      style: TextStyle(
                        fontFamily: 'AlcherPixel',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(255, 119, 168, 1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),

              // Progress Bar Section
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 345.0,
                    height: 54,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/progress_details.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 21, bottom: 3),
                      child: Text(
                        '${_currentIndex}/3',
                        style: TextStyle(
                          fontFamily: 'AlcherPixel',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  // Tab Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTab("Details", 1),
                      SizedBox(width: 40),
                      _buildTab("Review", 2),
                      SizedBox(width: 40),
                      _buildTab("Confirmation", 3),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),

              // Content Section
              _buildContentForTab(_currentIndex),
              SizedBox(height: 16.0),

              // Next Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 55),
                child: GestureDetector(
                  onTap: () {
                    if (_currentIndex < 3) {
                      setState(() {
                        _currentIndex++;
                      });
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: _currentIndex != 3 ? 190.0 : 206,
                        height: _currentIndex != 3 ? 50.47 : 59,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _currentIndex != 3
                                ? AssetImage('assets/images/next_button.png')
                                : AssetImage(
                                    'assets/images/continue_shopping.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        _currentIndex < 3 ? 'Next' : 'Continue\nShopping',
                        style: TextStyle(
                          fontFamily: 'AlcherPixel',
                          color: Colors.white,
                          fontSize: _currentIndex != 3 ? 36.0 : 24,
                          fontWeight: FontWeight.w400,
                          height: 0.9,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Tab Builder
  Widget _buildTab(String title, int index) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'AlcherPixel',
        color: _currentIndex == index
            ? Colors.white
            : Color.fromRGBO(131, 118, 156, 1),
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  // Content Builder
  Widget _buildContentForTab(int index) {
    switch (index) {
      case 1:
        return buildDetailsTab();
      case 2:
        return buildReviewTab();
      case 3:
        return buildConfirmationTab();
      default:
        return SizedBox.shrink();
    }
  }
}

// import 'package:flutter/material.dart';
//
// import 'build_confirmation_tab.dart';
// import 'build_details_tab.dart';
// import 'build_review_tab.dart';
//
// class checkoutPage extends StatefulWidget {
//   const checkoutPage({super.key});
//
//   @override
//   State<checkoutPage> createState() => _checkoutPageState();
// }
//
// class _checkoutPageState extends State<checkoutPage> {
//   int _currentIndex = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/background.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//                 decoration: BoxDecoration(
//                   color: Colors.black
//                       .withOpacity(0.5), // Header background opacity
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Image.asset(
//                         'assets/images/back_button.png',
//                         width: 54.0,
//                         height: 54.0,
//                       ),
//                     ),
//                     Text(
//                       'Checkout',
//                       style: TextStyle(
//                         fontFamily: 'AlcherPixel',
//                         fontSize: 24,
//                         fontWeight: FontWeight.w400,
//                         color: Color.fromRGBO(255, 119, 168, 1),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     width: 345.0, // Set desired width
//                     height: 54, // Set desired height
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('assets/images/progress_details.png'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 21, bottom: 3),
//                       child: Text(
//                         '${_currentIndex}/3',
//                         style: TextStyle(
//                             fontFamily: 'AlcherPixel',
//                             fontWeight: FontWeight.w400,
//                             fontSize: 16),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _currentIndex = 1;
//                           });
//                         },
//                         child: Text(
//                           'Details', // Your text
//                           style: TextStyle(
//                             fontFamily: 'AlcherPixel',
//                             color: _currentIndex == 1
//                                 ? Colors.white
//                                 : Color.fromRGBO(
//                                     131, 118, 156, 1), // Text color
//                             fontSize: 16.0, // Text size
//                             fontWeight: FontWeight.w400, // Optional: Bold text
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 40,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _currentIndex = 2;
//                           });
//                         },
//                         child: Text(
//                           'Review', // Your text
//                           style: TextStyle(
//                             fontFamily: 'AlcherPixel',
//                             color: _currentIndex == 2
//                                 ? Colors.white
//                                 : Color.fromRGBO(
//                                     131, 118, 156, 1), // Text color
//                             fontSize: 16.0, // Text size
//                             fontWeight: FontWeight.w400, // Optional: Bold text
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 40,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             _currentIndex = 3;
//                           });
//                         },
//                         child: Text(
//                           'Confirmation', // Your text
//                           style: TextStyle(
//                             fontFamily: 'AlcherPixel',
//                             color: _currentIndex == 3
//                                 ? Colors.white
//                                 : Color.fromRGBO(
//                                     131, 118, 156, 1), // Text color
//                             fontSize: 16.0, // Text size
//                             fontWeight: FontWeight.w400, // Optional: Bold text
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//               SizedBox(height: 16.0),
//               _buildContentForTab(_currentIndex),
//               SizedBox(height: 16.0),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 55),
//                 child: GestureDetector(
//                   onTap: () {
//                     if (_currentIndex == 1) {
//                       _buildContentForTab(2);
//                     } else if (_currentIndex == 2) {
//                       _buildContentForTab(3);
//                     }
//                   },
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Container(
//                         width: 190.0, // Set desired width
//                         height: 50.47, // Set desired height
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage('assets/images/next_button.png'),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         'Next', // Your text
//                         style: TextStyle(
//                           fontFamily: 'AlcherPixel',
//                           color: Colors.white, // Text color
//                           fontSize: 36.0, // Text size
//                           fontWeight: FontWeight.w400, // Optional: Bold text
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildContentForTab(int index) {
//     switch (index) {
//       case 1:
//         return buildDetailsTab();
//       case 2:
//         return buildReviewTab();
//       case 3:
//         return buildConfirmationTab();
//       default:
//         return SizedBox.shrink();
//     }
//   }
// }
