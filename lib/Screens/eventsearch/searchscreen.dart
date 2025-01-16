import 'dart:math';

import 'package:alcheringa/Model/stall_model.dart';
import 'package:alcheringa/Screens/activity_pages/widgets/competition_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import '../../Model/eventdetail.dart';
import '../../Model/view_model_main.dart';
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
      final stalls = await ViewModelMain().getStalls();
      final List<EventDetail> events = await ViewModelMain().getAllEvents();
      suggestionList(events);
      _filteredStalls = stalls;
      setState(() {
        _stalls = stalls;
        _allEvents = events;
        _filteredStalls = List.from(_stalls);
      });
      print('Hello ${_stalls.first.name}');
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
      ...takeRandom(
          events.where((event) => event.category == "Event").toList(), 3),
      ...takeRandom(
          events.where((event) => event.category != "Event").toList(), 3),
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
      filteredStalls = _stalls
          .where(
              (stall) => stall.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      filteredEvents = _allEvents
          .where((event) =>
              event.artist.toLowerCase().contains(query.toLowerCase()))
          .toList();
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
          body: Container(
              width: double.infinity,
              height: mq.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(children: [
                // Header Section
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'assets/images/back_button.png',
                          width: 54.0,
                          height: 54.0,
                        ),
                      ),
                      const Text(
                        'Search',
                        style: TextStyle(
                          fontFamily: 'Game_Tape',
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(255, 119, 168, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: mq.height * 0.02,
                ),
                Container(
                  width: mq.width * 0.85,
                  height: mq.height * 0.07,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/searchbackground.png'),
                        fit: BoxFit.fill),
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
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14)),
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
                SizedBox(height: 10,),
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
                              children: _filteredEvents
                                  .where((event) => event.category == "Event")
                                  .toList()
                                  .map((event) {
                                return _buildCard(
                                    context: context, event: event);
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                              children: _filteredEvents
                                  .where((event) => event.category != "Event")
                                  .toList()
                                  .map((event) {
                            return CompetitionCard(event: event);
                          }).toList())
                        ],
                      ),
                    ),
                  ),
                )
              ]))),
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
        Stack(
          children: [
            Positioned.fill(
                child: CachedNetworkImage(
              imageUrl: event.imgurl,
              fit: BoxFit.cover,
            )),
            Container(
              height: screenHeight * 0.63,
              width: 186 * screenHeight * 0.63 / 480,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/card.png'),
                      fit: BoxFit.cover)),
            ),
            // Heading
            Positioned.fill(
              left: 25 * screenHeight * 0.63 / 480,
              top: 336 * screenHeight * 0.63 / 480,
              child: Text(
                event.artist,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: "Game_Tape", fontSize: 20, color: Colors.white),
              ),
            ),
            // Description
            Positioned.fill(
              left: 25,
              top: 380 * screenHeight * 0.63 / 480,
              right: 25,
              child: Text(
                event.descriptionEvent,
                maxLines: 3,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    fontFamily: "Game_Tape",
                    fontSize: 12,
                    color: Colors.orange),
              ),
            ),
            // Venue
            Positioned.fill(
              left: 25,
              top: 441 * screenHeight * 0.63 / 480,
              right: 25,
              child: Text(
                "${event.starttime.date} ${event.starttime.date >= 5 ? "Jan" : "Feb"}, ${event.starttime.hours}: ${event.starttime.min} |",
                maxLines: 3,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    fontFamily: "Game_Tape", fontSize: 12, color: Colors.white),
              ),
            ),
            Positioned.fill(
              left: 110,
              top: 418 * screenHeight * 0.63 / 480,
              right: 25,
              child: Marquee(
                text: "${event.venue}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: "Game_Tape",
                ),
                scrollAxis: Axis.horizontal, // Scroll horizontally
                crossAxisAlignment: CrossAxisAlignment.center,
                blankSpace: 40.0, // Space between repetitions
                velocity: 20.0, // Speed of the scrolling text
                pauseAfterRound: Duration(seconds: 1), // Pause between loops
                startPadding: 10.0, // Padding before the text starts
                accelerationDuration:
                    Duration(seconds: 1), // Acceleration effect
                decelerationDuration:
                    Duration(seconds: 1), // Deceleration effect
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
