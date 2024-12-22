import 'package:flutter/material.dart';

Widget buildConfirmationTab() {
  return Container(
    width: 325,
    height: 400,
    child: Center(
      // Ensures the content is at the middle of the screen
      child: Column(
        mainAxisSize: MainAxisSize.min, // Centers the column vertically
        mainAxisAlignment:
            MainAxisAlignment.center, // Align children vertically centered
        crossAxisAlignment:
            CrossAxisAlignment.center, // Align children horizontally centered
        children: [
          Text(
            'Order Placed',
            style: TextStyle(
              fontFamily: 'AlcherPixel',
              color: Color.fromRGBO(0, 228, 54, 1), // Text color
              fontSize: 24.0, // Text size
              fontWeight: FontWeight.w400,
              height: 0.9, // Adjust line spacing
            ),
            textAlign: TextAlign.center, // Align text in the center
          ),
          SizedBox(height: 16.0), // Add spacing between the texts
          Text(
            'Our team will contact you regarding further details of your order',
            style: TextStyle(
              fontFamily: 'AlcherPixel',
              color: Color.fromRGBO(131, 118, 156, 1), // Text color
              fontSize: 20.0, // Text size
              fontWeight: FontWeight.w400,
              height: 1.2, // Adjust line spacing
            ),
            textAlign: TextAlign.center, // Align text in the center
          ),
        ],
      ),
    ),
  );
}
