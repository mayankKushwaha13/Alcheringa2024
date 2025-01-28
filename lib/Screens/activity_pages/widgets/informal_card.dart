import 'dart:io';

import 'package:alcheringa/Model/eventdetail.dart';
import 'package:alcheringa/Model/informal_model.dart';
import 'package:alcheringa/Screens/event_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';

class InformalCard extends StatefulWidget {
  final InformalModel informal;

  const InformalCard({required this.informal, super.key});

  @override
  State<InformalCard> createState() => _InformalCardState();
}

class _InformalCardState extends State<InformalCard> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: GestureDetector(
        onTap: () async {
          final Uri appleMapsUrl = Uri.parse(
              'https://maps.apple.com/?daddr=${widget.informal.location.latitude},${widget.informal.location.longitude}&dirflg=w');
          final Uri googleMapsUrl = Uri.parse(
              'https://www.google.com/maps/dir/?api=1&destination=${widget.informal.location.latitude},${widget.informal.location.longitude}');

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
        child: Stack(
          children: [
            Image.asset(
              "assets/images/event_card_bg.png",
              fit: BoxFit.fill,
              width: mq.width,
              height: mq.width * 0.4,
            ),
            Container(
              width: mq.width,
              height: mq.width * 0.4,
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CachedNetworkImage(
                      height: mq.width * 0.25,
                      imageUrl: widget.informal.imgUrl,
                      errorWidget: (context, url, error) => Image.asset('assets/images/basketball.png'),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.informal.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.15,
                                fontFamily: 'Brick_Pixel'),
                          ),
                          Text(
                            "Click here to navigate",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white60,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.15,
                                fontFamily: 'Game_Tape'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
