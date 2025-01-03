import 'package:flutter/material.dart';

class EventsButton extends StatelessWidget {
  const EventsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background for contrast
      body: Center(
        child: Container(
          width: 150, // Width of the button
          height: 60, // Height of the button
          decoration: BoxDecoration(
            color: const Color(0xFFC4C4C4), // Gray color for the background
            borderRadius: BorderRadius.circular(8), // Rounded corners
            border: Border.all(
              color: Colors.black, // Black border
              width: 4, // Border thickness
            ),
          ),
          child: Stack(
            children: [
              // Bottom shadow part
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 10, // Shadow height
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B3B3B), // Darker shadow color
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                ),
              ),
              // Text part
              Center(
                child: Text(
                  "Events",
                  style: TextStyle(
                    fontSize: 16, // Adjust font size
                    color: Colors.black, // Text color
                    fontFamily: 'Alcherpixel', // Use a pixelated font
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}