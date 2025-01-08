import 'dart:math';

import 'package:alcheringa/Model/stall_model.dart';
import 'package:alcheringa/Screens/activity_pages/widgets/competition_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  //  List<EventDetail> searchedEvents =[];
  //  List<StallModel> searchedStalls = [];
  List<StallModel> _stalls = [];
  List<StallModel> _filteredStalls = [];
  List<EventDetail> _filteredEvents = [];
  List<EventDetail> _allEvents = [];
    final TextEditingController _textFieldController = TextEditingController();


  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<List<StallModel>> getData() async {
    try {
      final stalls = await ViewModelMain().getStalls();
      final  List<EventDetail> events = await ViewModelMain().getAllEvents();
      _filteredEvents = events;
      _filteredStalls = stalls;
      setState(() {
        _stalls = stalls;
        _allEvents = events;
        // print("This is stalls list: ${stalls.first.imgurl}");
        _filteredStalls = List.from(_stalls);
      });
      print('Hello ${_stalls.first.name}');
    } catch (e) {
      print('Error fetching data: $e');
    }
    
    return _stalls;
  }

 void _filter(String query) {
  List<StallModel> filteredStalls;
  List<EventDetail> filteredEvents;

  if (query.isEmpty) {
    filteredStalls = List.from(_stalls);
    filteredEvents = List.from(_allEvents);
  } else {
    filteredStalls = _stalls
        .where((stall) =>
            stall.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    filteredEvents = _allEvents
        .where((event) =>
            event.artist.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  setState(() {
    _filteredStalls = filteredStalls;
    _filteredEvents = filteredEvents;
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
                    onChanged: _filter,//todo
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
                  height: mq.height * 0.04,
                ),

                Expanded(child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        SizedBox(height: 5),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _filteredEvents.where((event)=> event.category =="Event").toList().map((event){
                              return _buildCard(context: context, event: event);
                            }).toList(),
                          ),
                        ),
                        SizedBox(height:20,),
                        Column(
                          children: _filteredEvents.where((event)=> event.category != "Event").toList().map((event){
                            return CompetitionCard(event: event);
                          }).toList()
                          )
                    ],
                  ),
                ),)
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
