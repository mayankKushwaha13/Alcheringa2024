import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Database/liked_events.dart';
import 'package:alcheringa/Model/merchModel.dart';
import 'package:alcheringa/Model/pass_model.dart';
import 'package:alcheringa/Model/view_model_main.dart';
import 'package:alcheringa/Screens/activity_pages/widgets/suggestion_events.dart';
import 'package:alcheringa/Services/retrofit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Common/resource.dart';
import '../Model/eventdetail.dart';
import 'event_detail_page.dart';
import 'merch_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool isLoading = true;

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController1;
  late final ScrollController _scrollController2;
  late final ScrollController _scrollController3;
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _currentIndex = 0;
  List<EventDetail> PronitesList = [];
  List<EventDetail> displayedSuggestions = [];
  bool isPassLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
    _scrollController3 = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling1();
      _startScrolling2();
      _startScrolling3();
    });
    // getMerchData();
    // getPronitesData();
    initializeSuggestions();
    // getPassList();
    getData();
  }

  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
    super.dispose();
  }

  Future<void> getData() async {
    List<Future> futures1 = [];
    List<Future> futures2 = [];
    List<Future> futures3 = [];

    if (viewModelMain.featuredEventsWithLive.isEmpty) {
      futures1.add(viewModelMain.getFeaturedEvents().then((_) {
        print('Fetched featured list');
      }));
    }
    if (viewModelMain.allEvents.isEmpty) {
      futures1.add(viewModelMain.getAllEvents().then((_) {
        initializeSuggestions();
        print('Fetched all list');
      }));
    }
    if (viewModelMain.merchMerch.isEmpty) {
      futures1.add(viewModelMain.getMerchMerch().then((_) {
        print('Fetched merch list');
      }));
    }
    if (viewModelMain.utilityList.isEmpty) {
      futures2.add(viewModelMain.getUtilities().then((_) {
        print('Fetched utilities list');
      }));
    }
    if (viewModelMain.informalList.isEmpty) {
      futures2.add(viewModelMain.getInformals().then((_) {
        print('Fetched informals list');
      }));
    }
    if (viewModelMain.stallList.isEmpty) {
      futures2.add(viewModelMain.getStalls().then((_) {
        print('Fetched stalls list');
      }));
    }
    if (viewModelMain.venuesList.isEmpty) {
      futures2.add(viewModelMain.getVenues().then((_) {
        print('Fetched venues list');
      }));
    }
    if (viewModelMain.allNotification.isEmpty) {
      futures3.add(viewModelMain.getAllNotifications().then((_) {
        print('Fetched notifications list');
      }));
    }
    if (viewModelMain.allsponsors.isEmpty) {
      futures2.add(viewModelMain.getsponsors().then((_) {
        print('Fetched sponsors list');
      }));
    }
    if (viewModelMain.interestList.isEmpty) {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('email') ?? '';
      futures3.add(viewModelMain.getInterests(email).then((_) {
        print('Fetched interest list');
      }));
    }
    if (viewModelMain.orderDetails.isEmpty) {
      futures3.add(viewModelMain.getOrderDetails().then((_) {
        print('Fetched order details list');
      }));
    }
    setState(() {
      isPassLoading = true;
    });
    if (viewModelMain.passList.isEmpty) {
      futures2.add(viewModelMain.getPassListFromSharedPreferences().then((passList) {
        viewModelMain.passList = passList;
        return viewModelMain.getPass().then((_) {
          print('Fetched passes list');
        });
      }));
    }
    setState(() {
      isPassLoading = false;
    });

    await Future.wait(futures1);
    if (mounted) {
      setState(() {});
    }
    await Future.wait(futures2);
    if (mounted) {
      setState(() {});
    }
    await Future.wait(futures3);

    if (mounted) {
      setState(() {
        print('Running all data');
      });
    }
  }

  Future<void> getPassList() async {
    try {
      await viewModelMain.getPass();
      print('Pass fetched ${viewModelMain.passList}');
      if (viewModelMain.passList.isEmpty) {
        setState(() async {
          viewModelMain.passList = await viewModelMain.getPassListFromSharedPreferences();
        });
        print('Cards fetched ${viewModelMain.passList} from shared preferences');
      }
    } catch (e) {
      print('Error fetching cards $e');
      showMessage('Please check your internet connection', context);
    }
  }

  void initializeSuggestions() {
    final List<EventDetail> list = viewModelMain.allEvents;
    final List<EventDetail> suggestions = list
        .where((element) =>
            element.category.replaceAll("\\s", "").toUpperCase() == "Competitions".replaceAll("\\s", "").toUpperCase())
        .toList();

    // Shuffle and pick a limited number of suggestions
    suggestions.shuffle(Random());
    displayedSuggestions = suggestions.take(20).toList();
    setState(() {});
  }

  Future<void> getPronitesData() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Create an instance of ViewModelMain
      ViewModelMain viewModel = ViewModelMain();

      // Fetch events
      final _pronitesList = await viewModel.getFeaturedEvents();

      // Debug print
      print('Fetched ${PronitesList.length} events');
    } catch (e) {
      print("Error fetching events: $e");
      // You might want to show an error message to the user here
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _startScrolling1() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController1.hasClients) {
        _scrollController1
            .animateTo(
          _scrollController1.offset + 100, // Scroll offset
          duration: Duration(milliseconds: 1000),
          curve: Curves.linear,
        )
            .then((_) {
          if (_scrollController1.offset >= _scrollController1.position.maxScrollExtent) {
            // Reset scroll when reaching the end
            _scrollController1.jumpTo(0);
          }
          _startScrolling1();
        });
      }
    });
  }

  void _startScrolling2() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController2.hasClients) {
        _scrollController2
            .animateTo(
          _scrollController2.offset + 100, // Scroll offset
          duration: Duration(milliseconds: 1000),
          curve: Curves.linear,
        )
            .then((_) {
          if (_scrollController2.offset >= _scrollController2.position.maxScrollExtent) {
            // Reset scroll when reaching the end
            _scrollController2.jumpTo(0);
          }
          _startScrolling2();
        });
      }
    });
  }

  void _startScrolling3() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController3.hasClients) {
        _scrollController3
            .animateTo(
          _scrollController3.offset + 100, // Scroll offset
          duration: Duration(milliseconds: 1000),
          curve: Curves.linear,
        )
            .then((_) {
          if (_scrollController3.offset >= _scrollController3.position.maxScrollExtent) {
            // Reset scroll when reaching the end
            _scrollController3.jumpTo(0);
          }
          _startScrolling3();
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
      dev.log(pass.length.toString());
      dev.log(response);
    } catch (e) {
      dev.log(e.toString());
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

    // Filter events based on type 'proshows'

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final List<EventDetail> suggestions = list.toList();
    // Shuffle and pick a limited number of suggestions
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
                    height: 500.0,
                    child: viewModelMain.featuredEventsWithLive.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : PageView.builder(
                            controller: PageController(viewportFraction: 0.6, initialPage: 1000),
                            // itemCount: displayedSuggestions.length,
                            itemBuilder: (context, index) {
                              final cardColorIndex = index % 2;
                              index = index % viewModelMain.featuredEventsWithLive.length;
                              final event = viewModelMain.featuredEventsWithLive[index];
                              final bool isRevealed = event.isArtistRevealed ?? false;

                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (cardColorIndex % 2 == 1)
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
                                        height: 40,
                                      ),
                                    if (cardColorIndex % 2 == 0)
                                      Expanded(
                                        flex: 2,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (isRevealed) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => EventDetailPage(event: event),
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: 250,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image:
                                                    AssetImage('assets/images/hero_section_unrevealed_text_holder.png'),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            child: Text(
                                              isRevealed ? event.artist : 'Coming soon',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Brick_pixel',
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    const SizedBox(height: 8.0),
                                    Expanded(
                                      flex: 9,
                                      child: Container(
                                        width: 250,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (isRevealed) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => EventDetailPage(event: event),
                                                ),
                                              );
                                            }
                                          },
                                          child: Stack(
                                            fit: StackFit.expand,
                                            alignment: Alignment.center,
                                            children: [
                                              if (isRevealed)
                                                Container(
                                                  width: 245,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: CachedNetworkImageProvider(event.iconURL),
                                                      alignment: Alignment.center,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              Image.asset(
                                                width: 245,
                                                isRevealed
                                                    ? 'assets/images/event_cards_revealed${cardColorIndex}.png'
                                                    : 'assets/images/card_$index.png',
                                                fit: BoxFit.fill,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (cardColorIndex % 2 == 1)
                                      SizedBox(
                                        height: 7.0,
                                      ),
                                    if (cardColorIndex % 2 == 1)
                                      Expanded(
                                        flex: 2,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (isRevealed) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => EventDetailPage(event: event),
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 250,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image:
                                                    AssetImage('assets/images/hero_section_unrevealed_text_holder.png'),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            child: Text(
                                              isRevealed ? event.artist : 'Coming soon',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Brick_pixel',
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (cardColorIndex % 2 == 0)
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
                          )),

                SizedBox(
                  height: 30.0,
                ),
                // marquee text crazy merch alert
                Container(
                  color: Color.fromRGBO(255, 236, 38, 1),
                  height: 30,
                  child: ListView.builder(
                    controller: _scrollController1,
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
                            style: TextStyle(color: Color(0xFF182446), fontSize: 18, fontFamily: 'Game_Tape'),
                          ),
                          SizedBox(width: 50),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // merch section
                SizedBox(
                  height: screenHeight * 0.4,
                  width: screenWidth,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          "assets/images/merch_ribbon.png",
                        ),
                      ),
                      Column(
                        children: [
                          viewModelMain.merchMerch.isEmpty
                              ? Center(child: CircularProgressIndicator())
                              : CarouselSlider(
                                  carouselController: _carouselController,
                                  options: CarouselOptions(
                                    viewportFraction: 1.2,
                                    autoPlay: true,
                                    enableInfiniteScroll: true,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    },
                                  ),
                                  items: viewModelMain.merchMerch
                                      .map(
                                        (item) => Builder(
                                          builder: (context) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(builder: (context) => MerchScreen()));
                                              },
                                              child: Stack(
                                                alignment: Alignment.topCenter,
                                                children: [
                                                  item.image == null
                                                      ? Image.asset(
                                                          'assets/images/default_image.png',
                                                          height: screenHeight * 0.24,
                                                        )
                                                      : Transform(
                                                          transform: Matrix4.rotationZ(0.1745),
                                                          alignment: Alignment.center,
                                                          child: CachedNetworkImage(
                                                            imageUrl: item.image ?? " ",
                                                            height: screenHeight * 0.24,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                          Spacer()
                        ],
                      ),
                      Positioned(
                        top: screenHeight * 0.26,
                        child: Builder(builder: (context) {
                          if (viewModelMain.merchMerch.isNotEmpty) {
                            MerchModel item = viewModelMain.merchMerch[_currentIndex];
                            return Text(
                              item.name ?? " ",
                              style: TextStyle(fontFamily: "Brick_Pixel", fontSize: 36, color: Colors.white),
                            );
                          } else {
                            return Text(
                              "Loading ...",
                              style: TextStyle(fontFamily: "Brick_Pixel", fontSize: 36, color: Colors.white),
                            );
                          }
                        }),
                      ),
                      Positioned(
                        top: screenHeight * 0.16,
                        left: 55 * screenWidth / screenHeight,
                        child: GestureDetector(
                          onTap: () {
                            _currentIndex--;
                            _carouselController.previousPage(
                                curve: Curves.fastEaseInToSlowEaseOut, duration: Duration(milliseconds: 800));
                          },
                          child: Image.asset(
                            'assets/images/prev_button.png',
                            scale: 0.8,
                          ),
                        ),
                      ),
                      Positioned(
                        top: screenHeight * 0.16,
                        right: (382 - 335) * screenWidth / screenHeight,
                        child: GestureDetector(
                          onTap: () {
                            _currentIndex++;
                            _carouselController.nextPage(
                                curve: Curves.fastEaseInToSlowEaseOut, duration: Duration(milliseconds: 800));
                          },
                          child: Image.asset(
                            'assets/images/next_merch_button.png',
                            scale: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/merch_ribbon_hearts.png",
                      height: screenWidth * 0.04,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MerchScreen()));
                        },
                        child: Text(
                          "click to learn more!",
                          style: TextStyle(fontFamily: "Game_Tape", fontSize: 24, color: Colors.white, shadows: [
                            BoxShadow(
                              offset: Offset(1.5, 1.5),
                              color: Colors.blue,
                            )
                          ]),
                        ))
                  ],
                ),

                SizedBox(
                  height: 20.0,
                ),
                //marquee text get your alcher card
                Container(
                  color: Color.fromRGBO(255, 236, 38, 1),
                  height: 30,
                  child: ListView.builder(
                    controller: _scrollController2,
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
                            "get your alcher card",
                            style: TextStyle(color: Color(0xFF182446), fontSize: 18, fontFamily: 'Game_Tape'),
                          ),
                          SizedBox(width: 50),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                // Alcher Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: AspectRatio(
                    aspectRatio: 0.7541589649,
                    child: isPassLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : PageView.builder(
                            controller: PageController(viewportFraction: 0.8),
                            itemCount: viewModelMain.passList.isEmpty ? 1 : viewModelMain.passList.length,
                            itemBuilder: (BuildContext context, int index) {
                              // Check if passList is empty
                              if (viewModelMain.passList.isEmpty) {
                                // Default page when passList is empty
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: AssetImage('assets/images/card_bg.png'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'No Cards Available',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontFamily: 'Game_Tape',
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              final uri = Uri.parse('https://alcheringa.iitg.ac.in');
                                              try {
                                                launchUrl(uri);
                                              } catch (e) {
                                                print('Cannot open the browser');
                                                showMessage('Unable to open browser', context);
                                              }
                                            },
                                            child: Container(
                                              width: 150,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage('assets/images/get_card_box.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Get Card',
                                                style: TextStyle(
                                                    fontFamily: 'Brick_Pixel',
                                                    color: Color.fromRGBO(255, 241, 232, 1),
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w400,
                                                    shadows: [
                                                      Shadow(
                                                          offset: Offset(2.5, 2), color: Colors.black, blurRadius: 2),
                                                    ]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                // Regular page when passList has items
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: AssetImage('assets/images/card_bg.png'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 40.0,
                                            right: 40.0,
                                            top: 40.0,
                                            bottom: 20.0,
                                          ),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Image.asset('assets/images/alcher_lady_logo.png'),
                                          ),
                                        ),
                                        Container(
                                          height: 102.0,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage('assets/images/card_ribbon.png'),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          viewModelMain.passList[index].name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontFamily: 'Game_Tape',
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 70.0,
                                              right: 70.0,
                                              top: 20.0,
                                            ),
                                            child: Container(
                                              color: Colors.white,
                                              child: QrImageView(
                                                data: viewModelMain.passList[index].id,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20.0),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                // marquee text cool stuff for you
                Container(
                  color: Color.fromRGBO(255, 236, 38, 1),
                  height: 30,
                  child: ListView.builder(
                    controller: _scrollController3,
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
                            "cool stuff for you !!!",
                            style: TextStyle(color: Color(0xFF182446), fontSize: 18, fontFamily: 'Game_Tape'),
                          ),
                          SizedBox(width: 50),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Below is event suggestion
                SizedBox(
                  height: 350,
                  child: PageView.builder(
                    controller: PageController(viewportFraction: 0.8),
                    itemCount: (displayedSuggestions.length / 2).ceil(),
                    itemBuilder: (context, pageIndex) {
                      final int startIndex = pageIndex * 2;
                      final List<EventDetail> currentPageSuggestions =
                          displayedSuggestions.skip(startIndex).take(2).toList();

                      return Column(
                        children: currentPageSuggestions
                            .map(
                              (suggestion) => Expanded(
                                child: SuggestionCard(event: suggestion),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ),
                // Liked Events
                FutureBuilder(
                    future: LikedEventsDatabase().readData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        List<EventDetail> likedEvents = snapshot.data!;
                        return Column(
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            _buildHeading(text: "Liked Events", backgroundImage: "assets/images/heading.png"),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: screenHeight * 0.63,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: likedEvents.length,
                                itemBuilder: (context, index) {
                                  EventDetail event = likedEvents[index];
                                  return _buildCard(
                                    event: event,
                                    headingSize: 18,
                                    isLiked: likedEvents.indexWhere((element) => element.artist == event.artist) != -1
                                        ? true
                                        : false,
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
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

  Widget _buildCard({required EventDetail event, required bool isLiked, double headingSize = 20}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final widgetHeight = screenHeight * 0.6;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: GestureDetector(
        onTap: () {
          if (event.isArtistRevealed) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventDetailPage(event: event)));
          }
        },
        child: Column(
          children: [
            Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: event.isArtistRevealed
                          ? CachedNetworkImage(
                              imageUrl: event.iconURL,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            )
                          : Image.asset(
                              'assets/images/card_0.png',
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            )),
                ),
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
                    event.isArtistRevealed ? event.artist : 'Coming Soon',
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
                    event.isArtistRevealed ? event.descriptionEvent : 'Coming Soon',
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
                    event.isArtistRevealed
                        ? event.starttime.date > 5
                            ? event.starttime.date.toString() +
                                " Jan " +
                                event.starttime.hours.toString() +
                                " PM | " +
                                event.venue
                            : event.starttime.date.toString() +
                                " Feb " +
                                event.starttime.hours.toString() +
                                " PM | " +
                                event.venue
                        : 'Coming Soon',
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
