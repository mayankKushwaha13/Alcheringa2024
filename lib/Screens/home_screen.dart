import 'dart:convert';
import 'dart:developer';

import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Model/pass_model.dart';
import 'package:alcheringa/Model/view_model_main.dart';
import 'package:alcheringa/Services/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/eventdetail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  void _startScrolling() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController
            .animateTo(
          _scrollController.offset + 100, // Scroll offset
          duration: Duration(milliseconds: 1000),
          curve: Curves.linear,
        )
            .then((_) {
          if (_scrollController.offset >= _scrollController.position.maxScrollExtent) {
            // Reset scroll when reaching the end
            _scrollController.jumpTo(0);
          }
          _startScrolling();
        });
      }
    });
  }

  Future<double> _getBottomNavBarHeight() async {
    await Future.delayed(Duration(milliseconds: 50));
    return bottomNavBarHeight;
  }

  void getPass() async {
    final client =
        RetrofitService(Dio(BaseOptions(contentType: "application/json")), baseUrl: "https://card.alcheringa.in/api/");
    try {
      final response = await client.getData(""); // pass email
      final json = jsonDecode(response);
      pass.add(PassModel.fromJson(json));
      log(pass.length.toString());
      log(response);
    } catch (e) {
      log(e.toString());
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   List<EventDetail> list = Provider.of<ViewModelMain>(context).allEvents;
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 15),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   "Explore",
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(vertical: 20),
  //                   child: SizedBox(
  //                     height: 100,
  //                     child: ListView(
  //                       shrinkWrap: true,
  //                       scrollDirection: Axis.horizontal,
  //                       children: [
  //                         ExploreContainerWidget(
  //                           text: "Merch",
  //                           // isMerchPage: true,
  //                           NavigatingPage: MerchScreen(),
  //                         ),
  //                         ExploreContainerWidget(
  //                           text: "Events",
  //                           NavigatingPage: MerchScreen(),
  //                         ),
  //                         ExploreContainerWidget(
  //                           text: "Competition",
  //                           NavigatingPage: MerchScreen(),
  //                         ),
  //                         ExploreContainerWidget(
  //                             text: "Stalls", NavigatingPage: StallsPage())
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 15),
  //             child: Text(
  //               "Utilities",
  //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
  //             ),
  //           ),
  //           FutureBuilder(
  //               future: ViewModelMain().getUtilities(),
  //               builder: (context, snapshot) {
  //                 if (snapshot.hasData) {
  //                   List<UtilityModel> utilities = snapshot.data!;
  //                   return Padding(
  //                     padding: const EdgeInsets.symmetric(
  //                       vertical: 20,
  //                     ),
  //                     child: SizedBox(
  //                         height: 280,
  //                         child: ListView.builder(
  //                             padding: EdgeInsets.only(left: 15),
  //                             shrinkWrap: true,
  //                             scrollDirection: Axis.horizontal,
  //                             itemCount: utilities.length,
  //                             itemBuilder: (context, index) {
  //                               UtilityModel utility = utilities[index];
  //                               return HomeScreenContainerWidget(
  //                                 onTap: () {},
  //                                 title: utility.name,
  //                                 subtitle: utility.description,
  //                                 imgurl: utility.imgUrl,
  //                               );
  //                             })),
  //                   );
  //                 } else {
  //                   return Center(
  //                     child: CircularProgressIndicator(),
  //                   );
  //                 }
  //               }),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 15),
  //             child: Text(
  //               "Informals",
  //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
  //             ),
  //           ),
  //           FutureBuilder(
  //               future: ViewModelMain().getInformals(),
  //               builder: (context, snapshot) {
  //                 if (snapshot.hasData) {
  //                   List<InformalModel> informals = snapshot.data!;
  //                   return Padding(
  //                     padding: const EdgeInsets.symmetric(
  //                       vertical: 20,
  //                     ),
  //                     child: SizedBox(
  //                         height: 280,
  //                         child: ListView.builder(
  //                             padding: EdgeInsets.only(left: 15),
  //                             shrinkWrap: true,
  //                             scrollDirection: Axis.horizontal,
  //                             itemCount: informals.length,
  //                             itemBuilder: (context, index) {
  //                               InformalModel informal = informals[index];
  //                               return HomeScreenContainerWidget(
  //                                 onTap: () {},
  //                                 title: informal.name,
  //                                 subtitle: "Click to navigate to location",
  //                                 imgurl: informal.imgUrl,
  //                               );
  //                             })),
  //                   );
  //                 } else {
  //                   return Center(
  //                     child: CircularProgressIndicator(),
  //                   );
  //                 }
  //               }),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 15),
  //             child: Text(
  //               "For You",
  //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
  //             ),
  //           ),
  //           FutureBuilder(
  //             future: ViewModelMain().getAllEvents(),
  //             builder: (context, snapshot) {
  //               if (snapshot.hasData) {
  //                 List<EventDetail> allEvents = snapshot.data!;
  //                 allEvents.shuffle();
  //                 allEvents = allEvents.take(10).toList();
  //                 return Padding(
  //                   padding: const EdgeInsets.symmetric(
  //                     vertical: 20,
  //                   ),
  //                   child: SizedBox(
  //                     height: 300,
  //                     child: ListView.builder(
  //                       padding: EdgeInsets.only(left: 15),
  //                       shrinkWrap: true,
  //                       scrollDirection: Axis.horizontal,
  //                       itemCount: allEvents.length,
  //                       itemBuilder: (context, index) {
  //                         EventDetail event = allEvents[index];
  //                         return HomeScreenContainerWidget(
  //                           onTap: () {
  //                             showModalBottomSheet(
  //                               isScrollControlled: true,
  //                               context: context,
  //                               builder: (context) {
  //                                 return EventDescriptionWidget(
  //                                   imgurl: event.imgurl,
  //                                   category: event.category,
  //                                   title: event.artist,
  //                                   venue: event.venue,
  //                                   date: event.starttime,
  //                                   description: event.descriptionEvent,
  //                                 );
  //                               },
  //                             );
  //                           },
  //                           title: event.artist,
  //                           subtitle: "Click to navigate to location",
  //                           imgurl: event.imgurl,
  //                         );
  //                       },
  //                     ),
  //                   ),
  //                 );
  //               } else {
  //                 return Center(
  //                   child: CircularProgressIndicator(),
  //                 );
  //               }
  //             },
  //           ),
  //           FutureBuilder(
  //             future: _getBottomNavBarHeight(),
  //             builder: (context, snapshot) {
  //               if (!snapshot.hasData ||
  //                   snapshot.connectionState == ConnectionState.waiting) {
  //                 return SizedBox(
  //                   height: 100.0,
  //                 );
  //               } else {
  //                 return SizedBox(
  //                   height: snapshot.data,
  //                 );
  //               }
  //             },
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    List<EventDetail> list = Provider.of<ViewModelMain>(context).allEvents;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                // Hero section
                SizedBox(
                  height: 400.0,
                  child: PageView.builder(
                    controller: PageController(viewportFraction: 0.5, initialPage: 1000),
                    itemBuilder: (context, index) {
                      index = index % 2;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (index % 2 == 1)
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 60.0,
                                height: 35.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/hero_section_hearts_pink.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            else
                              SizedBox(
                                height: 35,
                              ),
                            if (index % 2 == 0)
                              Expanded(
                                flex: 2,
                                child: Container(
                                  width: 220,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/hero_section_unrevealed_text_holder.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Text(
                                    'Coming soon',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Brick_pixel',
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 8.0),
                            Expanded(
                              flex: 9,
                              child: Container(
                                width: 220,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/card_$index.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            if (index % 2 == 1)
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 220,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/hero_section_unrevealed_text_holder.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Text(
                                    'Coming soon',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Brick_pixel',
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            if (index % 2 == 0)
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 60.0,
                                height: 35.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/hero_section_hearts_blue.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            else
                              SizedBox(
                                height: 35,
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  color: Color.fromRGBO(255, 236, 38, 1),
                  height: 40,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: 70,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          ImageIcon(
                            AssetImage('assets/images/hero_section_hearts_blue.png'),
                            size: 90.0,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Crazy merch alert !!!",
                            style: TextStyle(
                              color: Color(0xFF182446),
                              fontSize: 18,
                              fontFamily: 'Game_Tape'
                            ),
                          ),
                          SizedBox(width: 50),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // SingleChildScrollView(
          //   child: Container(
          //     color: Colors.yellow,
          //     height: 50,
          //     child: Column(
          //       children: [
          //         ListView.builder(
          //           controller: _scrollController,
          //           scrollDirection: Axis.horizontal,
          //           itemCount: 10,
          //           itemBuilder: (context, index) {
          //             return Row(
          //               children: [
          //                 Icon(Icons.favorite, size: 24, color: Colors.blue.shade900),
          //                 SizedBox(width: 10),
          //                 Text(
          //                   "Crazy merch alert !!!",
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     color: Colors.blue.shade900,
          //                     fontSize: 18,
          //                   ),
          //                 ),
          //                 SizedBox(width: 50),
          //               ],
          //             );
          //           },
          //         ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
