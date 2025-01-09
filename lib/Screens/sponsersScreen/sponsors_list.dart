import 'package:alcheringa/Model/sponsors_model.dart';
import 'package:alcheringa/Model/view_model_main.dart';
import 'package:alcheringa/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

class sponsors_list extends StatefulWidget {
  @override
  State<sponsors_list> createState() => _sponsors_listState();
}

class _sponsors_listState extends State<sponsors_list> {
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

          List<sponsorModel> gridSponsors = allsponsors.where((sponsor) {
            return sponsor.title != "In Association with" &&
                sponsor.title != "Connected By";
          }).toList();

          return SingleChildScrollView(
            child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: listSponsors.length,
                      itemBuilder: (context, index) {
                        final sponsor = listSponsors[index];
                        return Container(
                          //margin: EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${sponsor.title}' ?? "",
                                      style: TextStyle(
                                          color: AppColors.Palewhite,
                                          fontSize: 20,
                                          fontFamily: "Game_Tape"),

                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.85,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.Darkpink, width: 3),
                                    ),
                                    child: Image.network(
                                      "${sponsor.imageurl}",
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: MediaQuery.of(context).size.width * 0.01,
                crossAxisCount: 2,
                childAspectRatio: 0.9,
              ),
              itemCount: gridSponsors.length,
              itemBuilder: (context, index) {
                final sponsor = gridSponsors[index];
                String title ="";
                if (sponsor.title.isEmpty){
                  title = "no title";
                } // todo
                else title = sponsor.title;
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
                            text: title,
                            style: TextStyle(
                              color: AppColors.Palewhite,
                              fontSize: 16,
                              fontFamily: "Game_Tape",
                            ),
                            scrollAxis: Axis.horizontal, // Scroll horizontally
                            crossAxisAlignment: CrossAxisAlignment.center,
                            blankSpace: 40.0, // Space between repetitions
                            velocity: 50.0, // Speed of the scrolling text
                            pauseAfterRound: Duration(seconds: 1), // Pause between loops
                            startPadding: 10.0, // Padding before the text starts
                            accelerationDuration: Duration(seconds: 1), // Acceleration effect
                            decelerationDuration: Duration(seconds: 1), // Deceleration effect
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.Darkpink, width: 3),
                        ),
                        child: Image.network(
                          "${sponsor.imageurl}", // Scale the image appropriately
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
                  ],
                ),
          );
        } else {
          return Center(
            child: Text(
              "No sponsors available",
              style: TextStyle(color: AppColors.Palewhite, fontSize: 18),
            ),
          );
        }
      },
    );
  }
}
