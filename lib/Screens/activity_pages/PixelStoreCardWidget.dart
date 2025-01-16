import 'package:alcheringa/Model/stall_model.dart';
import 'package:alcheringa/Screens/activity_pages/stalls_description_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class PixelStoreCard extends StatelessWidget {
  final StallModel stall;

  const PixelStoreCard({super.key, required this.stall});



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => StallsDescriptionPage(stall: stall,)));
      },
      child: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/images/foodStallCardTemplate.png',
            width: screenWidth * 0.9,
            height: screenHeight * 0.17,
            fit: BoxFit.fill,
          ),


          stall.imgurl.startsWith('http') || stall.imgurl.startsWith('https')
              ? Positioned(
            height: screenHeight * 0.115,
            width: screenWidth * 0.215,
            left: screenWidth * 0.057,
            top: screenHeight * 0.03,
            child: Image(
              image: CachedNetworkImageProvider(stall.imgurl),
              fit: BoxFit.fill,
            ),
          )
              : Positioned(
            height: screenHeight * 0.115,
            width: screenWidth * 0.215,
            left: screenWidth * 0.057,
            top: screenHeight * 0.03,
              child: Image.asset(
              'assets/images/defaultStallTemplate.png',
              fit: BoxFit.cover,
            ),
          ),

          // Stall name text
          Container(
            margin: EdgeInsets.only(top: screenHeight*.026,left: screenWidth*.31),
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
            height: screenHeight*.123,
            width: screenWidth*.55,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/food_stall_2.png"),fit: BoxFit.fill)
            ),
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final textPainter = TextPainter(
                      text: TextSpan(
                        text: stall.name,
                        style: const TextStyle(
                          color: Color(0xFFFFCCAA),
                          fontFamily: 'Game_Tape',
                          fontSize: 25,
                          shadows: [
                            Shadow(
                              offset: Offset(2.5, 2),
                              color: Colors.black,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      maxLines: 1,
                      textDirection: TextDirection.ltr,
                    )..layout(maxWidth: constraints.maxWidth);
                    final isOverflowing = textPainter.didExceedMaxLines;

                    return isOverflowing
                        ? SizedBox(
                      height: 30,
                        child: Marquee(
                        text: stall.name,
                        style: const TextStyle(
                          color: Color(0xFFFFCCAA),
                          fontFamily: 'Game_Tape',
                          fontSize: 25,
                          shadows: [
                            Shadow(
                              offset: Offset(2.5, 2),
                              color: Colors.black,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        scrollAxis: Axis.horizontal,
                        blankSpace: 30.0,
                        velocity: 20.0,
                        pauseAfterRound: const Duration(seconds: 1),
                        startPadding: 10.0,
                        accelerationDuration: const Duration(seconds: 1),
                        accelerationCurve: Curves.linear,
                        decelerationDuration: const Duration(milliseconds: 500),
                        decelerationCurve: Curves.easeOut,
                      ),
                    )
                        : Text(
                      stall.name,
                      style: const TextStyle(
                        color: Color(0xFFFFCCAA),
                        fontFamily: 'Game_Tape',
                        fontSize: 25,
                        shadows: [
                          Shadow(
                            offset: Offset(2.5, 2),
                            color: Colors.black,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
                SizedBox(height: 5,),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: stall.category.length,
                    itemBuilder: (context, index) {
                      String image = stall.category[index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          height: screenHeight*.009,
                          width: screenWidth*.1,
                          child: CachedNetworkImage(
                            imageUrl: image,
                           // placeholder: (context, url) => CircularProgressIndicator(),
                           // errorWidget: (context, url, error) => Icon(Icons.error),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}