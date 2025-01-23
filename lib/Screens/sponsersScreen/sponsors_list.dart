import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Model/sponsors_model.dart';
import 'package:alcheringa/Model/view_model_main.dart';
import 'package:alcheringa/utils/styles/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class sponsors_list extends StatefulWidget {
  @override
  State<sponsors_list> createState() => _sponsors_listState();
}

class _sponsors_listState extends State<sponsors_list> {
  List<sponsorModel> allsponsors = [];
  List<sponsorModel> listSponsors = [];
  List<sponsorModel> gridSponsors = [];

  @override
  void initState() {
    allsponsors = viewModelMain.allsponsors;
    listSponsors = allsponsors.where((sponsor) {
      return sponsor.heading;
    }).toList();

    gridSponsors = allsponsors.where((sponsor) {
      return !sponsor.heading;
    }).toList();
    super.initState();
    print('list: ${listSponsors.length}');
    print('list: ${gridSponsors.length}');
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final sponsor = listSponsors[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sponsor.title,
                          style: TextStyle(
                            color: AppColors.Palewhite,
                            fontSize: 20,
                            fontFamily: "Game_Tape",
                          ),
                        ),
                        Container(
                          // width: MediaQuery.of(context).size.width * 0.85,
                          // height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.Darkpink,
                              width: 3,
                            ),
                          ),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.85, // optional maximum width
                            maxHeight: 130, // optional maximum height
                          ),
                          child: CachedNetworkImage(
                            imageUrl: sponsor.imageurl,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ],
                ),
              );
            },
            childCount: listSponsors.length,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(top: 8), // Adjust spacing
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: MediaQuery.of(context).size.width * 0.01,
              mainAxisSpacing: 8,
              childAspectRatio: 0.9,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final sponsor = gridSponsors[index];
                return Container(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: SizedBox(
                          height: 40,
                          child: Marquee(
                            text: sponsor.title.isEmpty ? "No Title" : sponsor.title,
                            style: TextStyle(
                              color: AppColors.Palewhite,
                              fontSize: 16,
                              fontFamily: "Game_Tape",
                            ),
                            scrollAxis: Axis.horizontal,
                            blankSpace: 40.0,
                            velocity: 50.0,
                            pauseAfterRound: Duration(seconds: 1),
                            startPadding: 10.0,
                            accelerationDuration: Duration(seconds: 1),
                            decelerationDuration: Duration(seconds: 1),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        // width: MediaQuery.of(context).size.width * 0.4,
                        // height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.Darkpink,
                            width: 3,
                          ),
                        ),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.4, // optional maximum width
                          maxHeight: 130, // optional maximum height
                        ),
                        child: CachedNetworkImage(
                          imageUrl: sponsor.imageurl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: gridSponsors.length,
            ),
          ),
        ),
      ],
    );
  }
}
