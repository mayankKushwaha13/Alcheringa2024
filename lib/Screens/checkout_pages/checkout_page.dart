import 'package:flutter/material.dart';

import 'build_details_tab.dart';

class checkoutPage extends StatefulWidget {
  const checkoutPage({super.key});

  @override
  State<checkoutPage> createState() => _checkoutPageState();
}

class _checkoutPageState extends State<checkoutPage> {
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
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              decoration: BoxDecoration(
                color:
                    Colors.black.withOpacity(0.5), // Header background opacity
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 345.0, // Set desired width
                  height: 54, // Set desired height
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
                          fontSize: 16),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = 1;
                        });
                      },
                      child: Text(
                        'Details', // Your text
                        style: TextStyle(
                          fontFamily: 'AlcherPixel',
                          color: _currentIndex == 1
                              ? Colors.white
                              : Color.fromRGBO(131, 118, 156, 1), // Text color
                          fontSize: 16.0, // Text size
                          fontWeight: FontWeight.w400, // Optional: Bold text
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = 2;
                        });
                      },
                      child: Text(
                        'Review', // Your text
                        style: TextStyle(
                          fontFamily: 'AlcherPixel',
                          color: _currentIndex == 2
                              ? Colors.white
                              : Color.fromRGBO(131, 118, 156, 1), // Text color
                          fontSize: 16.0, // Text size
                          fontWeight: FontWeight.w400, // Optional: Bold text
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = 3;
                        });
                      },
                      child: Text(
                        'Confirmation', // Your text
                        style: TextStyle(
                          fontFamily: 'AlcherPixel',
                          color: _currentIndex == 3
                              ? Colors.white
                              : Color.fromRGBO(131, 118, 156, 1), // Text color
                          fontSize: 16.0, // Text size
                          fontWeight: FontWeight.w400, // Optional: Bold text
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 16.0),
            _buildContentForTab(_currentIndex),
          ],
        ),
      ),
    );
  }

  Widget _buildContentForTab(int index) {
    switch (index) {
      case 1:
        return buildDetailsTab();
      // case 2:
      //   return _buildReviewTab();
      // case 3:
      //   return _buildConfirmationTab();
      default:
        return SizedBox.shrink();
    }
  }
}
