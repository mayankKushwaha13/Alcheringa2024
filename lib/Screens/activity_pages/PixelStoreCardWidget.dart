import 'package:flutter/material.dart';

class PixelStoreCard extends StatelessWidget {
  final String name;
  final String image;
  final String ref;

  const PixelStoreCard({required this.name, super.key, required this.image ,required this.ref});



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/foodStallCardTemplate.png'),

        image!.startsWith('http') || image!.startsWith('https') ?
        Positioned(
          height: 100,
          width: 100,
          left: 22.5,
          top: 22.5,
          child: Image(image: NetworkImage(image!))

        ) :
        Image.asset('assets/images/defaultStallTemplate.png'),

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