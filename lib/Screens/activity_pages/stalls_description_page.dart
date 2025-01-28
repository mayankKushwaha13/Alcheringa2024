import 'dart:io';

import 'package:alcheringa/Model/stall_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StallsDescriptionPage extends StatefulWidget {
  const StallsDescriptionPage({super.key, required this.stall});

  final StallModel stall;

  @override
  State<StallsDescriptionPage> createState() => _StallsDescriptionPageState();
}

class _StallsDescriptionPageState extends State<StallsDescriptionPage> {
  @override
  Widget build(BuildContext context) {
    final stall = widget.stall;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Color.fromRGBO(63, 19, 42, 1),
          automaticallyImplyLeading: false,
          title: Container(
            padding: EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/images/back_button.png',
                    width: 50.0,
                    height: 50.0,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      stall.name,
                      style: TextStyle(
                        fontFamily: 'Game_Tape',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFFFF1E8),
                      ),
                    ),
                    Text(
                      'Stalls',
                      style: TextStyle(
                        fontFamily: 'Game_Tape',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFFF77A8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/stalls_page_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFFF77A8), // Border color
                          width: 4.0, // Border width
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: stall.imgurl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stall.name,
                          style: TextStyle(
                            fontFamily: 'Brick_Pixel',
                            fontSize: 32,
                            color: Color(0xFFFFF1E8),
                          ),
                        ),
                        Text(
                          'Location: Cricket Ground',
                          style: TextStyle(
                            fontFamily: 'Game_Tape',
                            fontSize: 24,
                            color: Color(0xFFFFF1E8),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          stall.description,
                          style: TextStyle(
                            fontFamily: 'Game_Tape',
                            fontSize: 16,
                            color: Color(0xFFFFF1E8),
                          ),
                          softWrap: true,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Divider(
                              color: Color(0xFFFFF1E8),
                              thickness: 4,
                            ),
                            Positioned(
                              child: GestureDetector(
                                onTap: () async {
                                  final Uri appleMapsUrl = Uri.parse(
                                      'https://maps.apple.com/?daddr=26.190917,26.190917&dirflg=w');
                                  final Uri googleMapsUrl = Uri.parse(
                                      'https://www.google.com/maps/dir/?api=1&destination=26.190917,26.190917');

                                  if (Platform.isIOS) {
                                    if (await canLaunchUrl(appleMapsUrl)) {
                                      await launchUrl(appleMapsUrl);
                                    } else {
                                      throw 'Could not open Apple Maps';
                                    }
                                  } else if (Platform.isAndroid) {
                                    if (await canLaunchUrl(googleMapsUrl)) {
                                      await launchUrl(googleMapsUrl);
                                    } else {
                                      throw 'Could not open Google Maps';
                                    }
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/direction_box.png',
                                        ),
                                        fit: BoxFit.fill),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                                    child: Text(
                                      'Find on Map',
                                      style: TextStyle(fontSize: 20.0, fontFamily: 'Brick_pixel', color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Menu',
                          style: TextStyle(
                            fontFamily: 'Game_Tape',
                            fontSize: 16,
                            color: Color(0xFFFF77A8),
                          ),
                        ),
                        ...stall.menu.map((item) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  item.name,
                                  style: TextStyle(
                                    fontFamily: 'Game_Tape',
                                    fontSize: 16,
                                    color: Color(0xFFFFF1E8),
                                  ),
                                ),
                              ),
                              Text(
                                item.price.toString(),
                                style: TextStyle(
                                  fontFamily: 'Game_Tape',
                                  fontSize: 16,
                                  color: Color(0xFFFFF1E8),
                                ),
                              ),
                            ],
                          );
                        }),
                        SizedBox(
                          height: 40.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
