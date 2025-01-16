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
  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ViewModelMain().getsponsors(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData) {
          List<sponsorModel> allsponsors = snapshot.data!;
          List<sponsorModel> listSponsors = allsponsors.where((sponsor) {
            return sponsor.title == "In Association with" ||
                sponsor.title == "Connected By";
          }).toList();

          // Sort "In Association with" first
          listSponsors.sort((a, b) {
            if (a.title == "In Association with" && b.title == "Connected By") {
              return -1;
            } else if (a.title == "Connected By" && b.title == "In Association with") {
              return 1;
            } else {
              return 0;
            }
          });

          List<sponsorModel> gridSponsors = allsponsors.where((sponsor) {
            return sponsor.title != "In Association with" &&
                sponsor.title != "Connected By";
          }).toList();

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
                                width: MediaQuery.of(context).size.width * 0.85,
                                height: 130,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.Darkpink,
                                    width: 3,
                                  ),
                                ),
                                child: CachedNetworkImage(imageUrl:sponsor.imageurl,
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
                                  text: sponsor.title.isEmpty
                                      ? "No Title"
                                      : sponsor.title,
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
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 130,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.Darkpink,
                                  width: 3,
                                ),
                              ),
                              child: CachedNetworkImage(imageUrl:sponsor.imageurl,
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
        } else {
          return Center(
            child: Text(
              "No sponsors available",
              style: TextStyle(
                color: AppColors.Palewhite,
                fontSize: 18,
              ),
            ),
          );
        }
      },
    );
  }
}
