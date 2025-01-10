import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Database/liked_events.dart';
import 'package:alcheringa/Model/eventdetail.dart';
import 'package:alcheringa/Model/view_model_main.dart';
import 'package:alcheringa/Screens/event_detail_page.dart';
import 'package:flutter/material.dart';

class ActivityEventsScreen extends StatefulWidget {
  const ActivityEventsScreen({super.key});

  @override
  State<ActivityEventsScreen> createState() => _ActivityEventsScreenState();
}

List<EventDetail> proniteslist = [];
List<EventDetail> proshowslist = [];
List<EventDetail> creatorscamplist = [];
List<EventDetail> alllist = [];

class _ActivityEventsScreenState extends State<ActivityEventsScreen> {
  void getEvents() async {
    alllist = await ViewModelMain().getAllEvents();
    proniteslist = await getPronites();
    proshowslist = await getProshows();
    creatorscamplist = await getCreatorsCamp();
    setState(() {});
  }

  Future<List<EventDetail>> getPronites() async {
    proniteslist = alllist
        .where((element) =>
            element.type.replaceAll("\\s", "").toUpperCase() == "Pronites".replaceAll("\\s", "").toUpperCase())
        .toList();
    return proniteslist;
  }

  Future<List<EventDetail>> getProshows() async {
    proshowslist = alllist
        .where((element) =>
            element.type.replaceAll("\\s", "").toUpperCase() == "Proshows".replaceAll("\\s", "").toUpperCase())
        .toList();
    return proshowslist;
  }

  Future<List<EventDetail>> getCreatorsCamp() async {
    creatorscamplist = alllist
        .where((element) =>
            element.type.replaceAll("\\s", "").toUpperCase() == "Creators' Camp".replaceAll("\\s", "").toUpperCase())
        .toList();
    return creatorscamplist;
  }

  @override
  void initState() {
    super.initState();
    getEvents();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/pattern.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pronites
                  _buildHeading(
                    text: "Pronites",
                    backgroundImage: "assets/images/heading.png",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                    future: Future.wait([getPronites(), LikedEventsDatabase().readData()]),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: screenHeight * 0.63,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: proniteslist.length,
                            itemBuilder: (context, index) {
                              EventDetail pronite = proniteslist[index];
                              return _buildCard(
                                event: pronite,
                                isLiked:
                                    snapshot.data![1].indexWhere((element) => element.artist == pronite.artist) != -1
                                        ? true
                                        : false,
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),

                  //Proshows
                  _buildHeading(
                    text: "Proshows",
                    backgroundImage: "assets/images/heading.png",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                    future: Future.wait([getProshows(), LikedEventsDatabase().readData()]),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: screenHeight * 0.63,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: proshowslist.length,
                            itemBuilder: (context, index) {
                              EventDetail proshow = proshowslist[index];
                              return _buildCard(
                                event: proshow,
                                isLiked:
                                    snapshot.data![1].indexWhere((element) => element.artist == proshow.artist) != -1
                                        ? true
                                        : false,
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //Creators' Camp
                  _buildHeading(
                    text: "Creators' Camp",
                    backgroundImage: "assets/images/heading.png",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                    future: Future.wait([getCreatorsCamp(), LikedEventsDatabase().readData()]),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: screenHeight * 0.63,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: creatorscamplist.length,
                            itemBuilder: (context, index) {
                              EventDetail creatorCamp = creatorscamplist[index];
                              return _buildCard(
                                event: creatorCamp,
                                headingSize: 18,
                                isLiked:
                                    snapshot.data![1].indexWhere((element) => element.artist == creatorCamp.artist) !=
                                            -1
                                        ? true
                                        : false,
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: bottomNavBarHeight,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeading({
    required String text,
    required String backgroundImage,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: screenWidth * 65 / 375,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontFamily: 'Game_Tape', fontSize: 30, color: Colors.white, shadows: [
            Shadow(offset: Offset(2.5, 2), color: Colors.black, blurRadius: 2),
          ]),
        ),
      ),
    );
  }

  Widget _buildCard({
    required EventDetail event,
    required bool isLiked,
    double headingSize = 20
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final widgetHeight = screenHeight * 0.6;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventDetailPage(event: event)));
        },
        child: Column(
          children: [
            Stack(
              children: [
                Positioned.fill(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    event.imgurl,
                    fit: BoxFit.cover,
                  ),
                )),
                Container(
                  height: widgetHeight,
                  width: 186 * widgetHeight / 480,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/card.png'), fit: BoxFit.cover)),
                ),
                Positioned(
                    top: 250 * widgetHeight / 480,
                    left: 105 * widgetHeight / 480,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        print("Tapped");
                        if (isLiked) {
                          await LikedEventsDatabase().deleteData(event.artist);
                        } else {
                          await LikedEventsDatabase().insertData(event);
                        }
                        setState(() {});
                      },
                      child: Image(
                        height: 65 * widgetHeight / 480,
                        image: isLiked ? AssetImage('assets/images/bell1.png') : AssetImage('assets/images/bell.png'),
                        // fit: BoxFit.cover,
                      ),
                    )),
                // Heading
                Positioned.fill(
                  left: 25 * widgetHeight / 480,
                  top: 336 * widgetHeight / 480,
                  child: Text(
                    event.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontFamily: "Brick_Pixel", fontSize: headingSize, color: Colors.white),
                  ),
                ),
                // Description
                Positioned.fill(
                  left: 25,
                  top: 380 * widgetHeight / 480,
                  right: 25,
                  child: Text(
                    event.descriptionEvent,
                    maxLines: 3,
                    overflow: TextOverflow.clip,
                    style: TextStyle(fontFamily: "Game_Tape", fontSize: 12, color: Colors.orange),
                  ),
                ),
                // Venue
                Positioned.fill(
                  left: 25,
                  top: 441 * widgetHeight / 480,
                  right: 25,
                  child: Text(
                    event.starttime.date > 5
                        ? event.starttime.date.toString() +
                            " Jan " +
                            event.starttime.hours.toString() +
                            " PM | " +
                            event.venue
                        : event.starttime.date.toString() +
                            " Feb " +
                            event.starttime.hours.toString() +
                            " PM | " +
                            event.venue,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(fontFamily: "Game_Tape", fontSize: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
