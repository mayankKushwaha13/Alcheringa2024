import 'package:alcheringa/Model/stall_model.dart';
import 'package:alcheringa/Screens/activity_pages/stalls_description_page.dart';
import 'package:flutter/material.dart';

class PixelStoreCard extends StatelessWidget {
  final StallModel stall;

  const PixelStoreCard({super.key, required this.stall});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => StallsDescriptionPage(stall: stall,)));
      },
      child: Stack(
        children: [
          Image.asset('assets/images/foodStallCardTemplate.png'),

          stall.imgurl.startsWith('http') || stall.imgurl.startsWith('https') ?
          Positioned(
            height: 100,
            width: 100,
            left: 22.5,
            top: 22.5,
            child: Image(image: NetworkImage(stall.imgurl!))

          ) :
          Image.asset('assets/images/defaultStallTemplate.png'),

          Positioned(
            left: 150,
            top: 30,
            child: Text(
              stall.name,
              style: const TextStyle(
                color: Color(0xFFFFCCAA),
                fontFamily: 'Game_Tape',
                fontSize: 25,
                  shadows: [
                    Shadow(
                        offset: Offset(2.5, 2),
                        color: Colors.black,
                        blurRadius: 2),
                  ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}