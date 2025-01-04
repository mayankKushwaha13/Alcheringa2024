import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Model/informal_model.dart';
import 'package:alcheringa/Model/utility_model.dart';
import 'package:alcheringa/Model/view_model_main.dart';
import 'package:alcheringa/Screens/activity_pages/Stalls.dart';
import 'package:alcheringa/Screens/activity_pages/stalls_page.dart';
import 'package:alcheringa/Screens/merch_screen.dart';
import 'package:alcheringa/Widgets/HomeScreenWidgets/explore_container_widget.dart';
import 'package:alcheringa/Widgets/HomeScreenWidgets/home_screen_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/eventdetail.dart';
import '../Widgets/HomeScreenWidgets/event_description_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<double> _getBottomNavBarHeight() async {
    await Future.delayed(Duration(milliseconds: 50));
    return bottomNavBarHeight;
  }

  @override
  Widget build(BuildContext context) {
    List<EventDetail> list = Provider.of<ViewModelMain>(context).allEvents;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Explore",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SizedBox(
                      height: 100,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          ExploreContainerWidget(
                            text: "Merch",
                            isMerchPage: true,
                            NavigatingPage: MerchScreen(),
                          ),
                          ExploreContainerWidget(
                            text: "Events",
                            NavigatingPage: MerchScreen(),
                          ),
                          ExploreContainerWidget(
                            text: "Competition",
                            NavigatingPage: MerchScreen(),
                          ),
                          ExploreContainerWidget(
                            text: "Stalls",
                            NavigatingPage: StallsPage()
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Utilities",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            FutureBuilder(
                future: ViewModelMain().getUtilities(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<UtilityModel> utilities = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: SizedBox(
                          height: 280,
                          child: ListView.builder(
                              padding: EdgeInsets.only(left: 15),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: utilities.length,
                              itemBuilder: (context, index) {
                                UtilityModel utility = utilities[index];
                                return HomeScreenContainerWidget(
                                  onTap: () {},
                                  title: utility.name,
                                  subtitle: utility.description,
                                  imgurl: utility.imgUrl,
                                );
                              })),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Informals",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            FutureBuilder(
                future: ViewModelMain().getInformals(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<InformalModel> informals = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      child: SizedBox(
                          height: 280,
                          child: ListView.builder(
                              padding: EdgeInsets.only(left: 15),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: informals.length,
                              itemBuilder: (context, index) {
                                InformalModel informal = informals[index];
                                return HomeScreenContainerWidget(
                                  onTap: () {},
                                  title: informal.name,
                                  subtitle: "Click to navigate to location",
                                  imgurl: informal.imgUrl,
                                );
                              })),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "For You",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            FutureBuilder(
              future: ViewModelMain().getAllEvents(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<EventDetail> allEvents = snapshot.data!;
                  allEvents.shuffle();
                  allEvents = allEvents.take(10).toList();
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: SizedBox(
                      height: 300,
                      child: ListView.builder(
                        padding: EdgeInsets.only(left: 15),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: allEvents.length,
                        itemBuilder: (context, index) {
                          EventDetail event = allEvents[index];
                          return HomeScreenContainerWidget(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return EventDescriptionWidget(
                                    imgurl: event.imgurl,
                                    category: event.category,
                                    title: event.artist,
                                    venue: event.venue,
                                    date: event.starttime,
                                    description: event.descriptionEvent,
                                  );
                                },
                              );
                            },
                            title: event.artist,
                            subtitle: "Click to navigate to location",
                            imgurl: event.imgurl,
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            FutureBuilder(
              future: _getBottomNavBarHeight(),
              builder: (context, snapshot) {
                if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
                  return SizedBox(
                    height: 100.0,
                  );
                }else{
                  return SizedBox(
                    height: snapshot.data,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
