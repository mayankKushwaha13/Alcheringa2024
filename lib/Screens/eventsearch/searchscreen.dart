import 'dart:math';

import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Model/stall_model.dart';
import 'package:alcheringa/Screens/activity_pages/widgets/competition_card.dart';
import 'package:alcheringa/Screens/event_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../../Model/eventdetail.dart';
import '../../utils/styles/colors.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  //  List<EventDetail> searchedEvents =[];
  //  List<StallModel> searchedStalls = [];
  List<StallModel> _stalls = [];
  List<StallModel> _filteredStalls = [];
  List<EventDetail> _filteredEvents = [];
  List<EventDetail> _allEvents = [];
  final TextEditingController _textFieldController = TextEditingController();
  bool toSuggest = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<List<StallModel>> getData() async {
    try {
      final stalls = viewModelMain.stallList;
      final List<EventDetail> events = viewModelMain.allEvents;
      suggestionList(events);
      _filteredStalls = stalls;
      setState(() {
        _stalls = stalls;
        _allEvents = events;
        _filteredStalls = List.from(_stalls);
      });
    } catch (e) {
      print('Error fetching data: $e');
    }

    return _stalls;
  }

  void suggestionList(List<EventDetail> events) {
    final random = Random();

// Function to take a random subset of a list
    List<T> takeRandom<T>(List<T> list, int count) {
      final copy = List.of(list);
      copy.shuffle(random);
      return copy.take(count).toList();
    }

    _filteredEvents = [
      ...takeRandom(events.where((event) => event.category == "Event").toList(), 3),
      ...takeRandom(events.where((event) => event.category != "Event").toList(), 3),
    ];
  }

  void _filter(String query) {
    List<StallModel> filteredStalls;
    List<EventDetail>? filteredEvents;

    if (query.isEmpty) {
      filteredStalls = List.from(_stalls);
      suggestionList(_allEvents);
      toSuggest = true;
    } else {
      toSuggest = false;
      filteredStalls = _stalls.where((stall) => stall.name.toLowerCase().contains(query.toLowerCase())).toList();
      filteredEvents = _allEvents.where((event) => event.artist.toLowerCase().contains(query.toLowerCase())).toList();
    }

    setState(() {
      _filteredStalls = filteredStalls;
      if (filteredEvents != null) _filteredEvents = filteredEvents;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: kToolbarHeight + 20,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black.withOpacity(0.5),
          leading: Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/images/back_button.png',
                width: 54.0,
                height: 54.0,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5, right: 20),
              child: Text(
                "SEARCH",
                style: TextStyle(
                  color: AppColors.Pink,
                  fontFamily: "Game_Tape",
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          height: mq.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: kToolbarHeight + 40,
              ),
              Container(
                width: mq.width * 0.85,
                height: mq.height * 0.07,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/searchbackground.png'), fit: BoxFit.fill),
                ),
                child: TextField(
                  controller: _textFieldController,
                  onChanged: _filter, //todo
                  style: TextStyle(
                    fontFamily: 'Game_Tape',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      hintText: 'Search events and more',
                      hintStyle: const TextStyle(
                        fontFamily: 'Game_Tape',
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
                ),
              ),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    toSuggest ? 'Suggestions' : "",
                    style: TextStyle(
                      fontFamily: 'Game_Tape',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _filteredEvents.where((event) => event.category == "Event").toList().map((event) {
                              return _buildCard(context: context, event: event);
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                            children: _filteredEvents.where((event) => event.category != "Event").toList().map((event) {
                          return CompetitionCard(event: event);
                        }).toList())
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCard({
  required BuildContext context,
  required EventDetail event,
}) {
  final screenHeight = MediaQuery.of(context).size.height;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
    child: Column(
      children: [
        GestureDetector(
          onTap: (){
            if(event.isArtistRevealed) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetailPage(event: event)));
            }
          },
          child: Stack(
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
                        : Image.asset('assets/images/card_0.png', fit: BoxFit.cover, alignment: Alignment.center,)),
              ),
              Container(
                height: screenHeight * 0.63,
                width: 186 * screenHeight * 0.63 / 480,
                decoration:
                    BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/card.png'), fit: BoxFit.cover)),
              ),
              // Heading
              Positioned.fill(
                left: 25 * screenHeight * 0.63 / 480,
                top: 336 * screenHeight * 0.63 / 480,
                child: Text(
                  event.isArtistRevealed ? event.artist : 'Coming Soon',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontFamily: "Game_Tape", fontSize: 20, color: Colors.white),
                ),
              ),
              // Description
              Positioned.fill(
                left: 25,
                top: 380 * screenHeight * 0.63 / 480,
                right: 25,
                child: Text(
                  event.isArtistRevealed ? event.descriptionShort : 'Coming Soon',
                  maxLines: 3,
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontFamily: "Game_Tape", fontSize: 12, color: Colors.orange),
                ),
              ),
              // Venue
              Positioned.fill(
                left: 25,
                top: 441 * screenHeight * 0.63 / 480,
                right: 25,
                child: Text(
                  event.isArtistRevealed ? "${event.starttime.date} ${event.starttime.date >= 5 ? "Jan" : "Feb"}, ${event.starttime.hours}: ${event.starttime.min} |" : 'Coming Soon',
                  maxLines: 3,
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontFamily: "Game_Tape", fontSize: 12, color: Colors.white),
                ),
              ),
              Positioned.fill(
                left: 110,
                top: 418 * screenHeight * 0.63 / 480,
                right: 25,
                child: Marquee(
                  text: event.isArtistRevealed ? "${event.venue}" : 'Coming Soon',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: "Game_Tape",
                  ),
                  scrollAxis: Axis.horizontal,
                  // Scroll horizontally
                  crossAxisAlignment: CrossAxisAlignment.center,
                  blankSpace: 40.0,
                  // Space between repetitions
                  velocity: 20.0,
                  // Speed of the scrolling text
                  pauseAfterRound: Duration(seconds: 1),
                  // Pause between loops
                  startPadding: 10.0,
                  // Padding before the text starts
                  accelerationDuration: Duration(seconds: 1),
                  // Acceleration effect
                  decelerationDuration: Duration(seconds: 1), // Deceleration effect
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
