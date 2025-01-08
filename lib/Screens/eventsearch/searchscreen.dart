import 'dart:math';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../Model/eventdetail.dart';
import '../../Model/view_model_main.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final List<EventDetail> ProEvents = Provider.of<ViewModelMain>(context)
        .allEvents
        .where((event) => event.category == "Event")
        .toList();
    ProEvents.shuffle(Random());
    final List<EventDetail> randomEvents = ProEvents.take(5).toList();
    final TextEditingController _textFieldController = TextEditingController();
    String selectedEvent = '';
    List<EventDetail> _filteredevents = [];
    List<EventDetail> _allevents = [];
    void _filterevent(String query) {
      if (query.isEmpty) {
        setState(() {
          _filteredevents = List.from(_allevents);
        });
      } else {
        setState(() {
          _filteredevents = _allevents
              .where((event) =>
                  event.category.toLowerCase().contains(query.toLowerCase()))
              .toList();
        });
      }
    }

    return Scaffold(
        body: Container(
            width: double.infinity,
            height: screenHeight,
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
                        fontFamily: 'AlcherPixel',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(255, 119, 168, 1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                width: screenWidth * 0.85,
                height: screenHeight * 0.07,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/searchbackground.png'),
                      fit: BoxFit.fill),
                ),
                child: TextField(
                  controller: _textFieldController,
                  onChanged: _filterevent,
                  style: TextStyle(
                    fontFamily: 'Alcherpixel',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      hintText: 'Search events and more',
                      hintStyle: const TextStyle(
                        fontFamily: 'Aclherpixel',
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14)),
                ),
              ),

              SizedBox(
                height: screenHeight * 0.04,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Suggestions',
                          style: TextStyle(
                            fontFamily: 'AlcherPixel v2.0',
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: randomEvents.map((event) {
                            return _buildCard(
                              context: context,
                              event: event,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ])));
  }
}

class CompetitionCard extends StatefulWidget {
  final EventDetail event;

  const CompetitionCard({required this.event, Key? key}) : super(key: key);

  @override
  State<CompetitionCard> createState() => _CompetitionCardState();
}

class _CompetitionCardState extends State<CompetitionCard> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              "assets/images/event_card_bg.png",
              fit: BoxFit.cover,
              width: mq.width,
              height: mq.width * 0.4,
            ),
          ),
          Container(
            width: mq.width,
            height: mq.width * 0.4,
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/basketball.png",
                  scale: 1.2,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.event.artist,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.15,
                              fontFamily: 'Brick_Pixel'),
                        ),
                        Flexible(
                          child: Text(
                            widget.event.descriptionEvent,
                            style: TextStyle(
                                color: Color(0xFFFF77A8),
                                fontSize: 14,
                                fontFamily: 'Game_Tape',
                                letterSpacing: .15),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "${widget.event.starttime.date} Jan, ${widget.event.starttime.hours > 12 ? widget.event.starttime.hours - 12 : widget.event.starttime.hours} ${widget.event.starttime.hours > 12 ? "PM" : "AM"}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFFFF1E8),
                                fontSize: 16,
                                fontFamily: 'Game_Tape',
                                fontWeight: FontWeight.w400,
                                height: 1.71,
                              ),
                            ),
                            Text(
                              "|",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFFFFF1E8),
                                fontSize: 16,
                                fontFamily: 'Game_Tape',
                                fontWeight: FontWeight.w400,
                                height: 1.71,
                                letterSpacing: 0.15,
                              ),
                            ),
                            Text(
                              widget.event.venue,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFFFFF1E8),
                                fontSize: 16,
                                fontFamily: 'Game_Tape',
                                fontWeight: FontWeight.w400,
                                height: 1.71,
                                letterSpacing: 0.15,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
        Stack(
          children: [
            Positioned.fill(
                child: Image(
              image: NetworkImage(event.imgurl),
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
                    fontFamily: "AlcherPixel-Bold v2.0",
                    fontSize: 20,
                    color: Colors.white),
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
                    fontFamily: "AlcherPiel",
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
                "${event.starttime.date} ${event.starttime.date >= 5 ? "Jan" : "Feb"}, ${event.starttime.hours}: ${event.starttime.min} | ${event.venue}",
                maxLines: 3,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    fontFamily: "AlcherPixel",
                    fontSize: 12,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
