import 'package:flutter/material.dart';

class PixelStoreCard extends StatelessWidget {
  final String name;
  final String ref;

  const PixelStoreCard({required this.name, super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/mainCard.png'),
        // Positioned(
        //   left: 30,
        //   child: Container(
        //     width: 100,
        //     height: 100,
        //     child: Image.asset('assets/images/storeIcon.png'),
        //
        //
        //   ),
        // ),
        Positioned(
          left: 150,
          top: 30,
          child: Text(
            name,
            style: const TextStyle(
              color: Color(0xFFFFCCAA),
              fontFamily: 'AlcherpixelBold',
              fontSize: 25,
            ),
          ),
        ),
      ],
    );
  }
}