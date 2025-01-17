import 'package:alcheringa/Screens/event_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Common/globals.dart';
import '../Model/eventdetail.dart';
import '../Model/view_model_main.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String date = '8';
  String month = 'FEB';
  int selectedDay = 0;
  String selectedVenueCategory = 'All';
  String selectedVenue = 'ALL';
  bool isLoading = true; // Add this if not already present
  int initialDay = 0;
  final ScrollController verticalController = ScrollController();
  final ScrollController horizontalController = ScrollController();
  final ViewModelMain viewModel = ViewModelMain();

  String key = "ALL";


  final Map<String, List<String>> itemListMap = {
  "All": [
    "Lecture Hall 1",
    "Lecture Hall 2",
    "Lecture Hall 3",
    "Lecture Hall 4",
    "Core 5",
    "Core 1",
    "Front of Graffiti Wall",
    "Behind Graffiti Wall",
    "Old Sac Wall",
    "New SAC",
    "Old Sac Stage",
    "Conference Hall 1",
    "Conference Hall 2",
    "Conference Hall 3",
    "Conference Hall 4",
    "Mini Auditorium",
    "Auditorium",
    "Audi Park",
    "Senate Hall",
    "Rocko Stage",
    "Expo Stage",
    "Library",
    "Library Shed",
    "Library Basement",
    "Football Field",
    "Basketball Courts",
    "Volley Ball Court",
    "Pronite Stage",
    "Athletics Field",
    "Entire Campus",
  ],
  "Lecture Halls": [
    "Lecture Hall 1",
    "Lecture Hall 2",
    "Lecture Hall 3",
    "Lecture Hall 4",
    "Core 5",
    "Core 1",
  ],
  "Grounds": [
    "Football Field",
    "Basketball Courts",
    "Volley Ball Court",
    "Pronite Stage",
    "Athletics Field",
  ],
  "Library Area": [
    "Library",
    "Library Shed",
    "Library Basement",
  ],
  "Admin Area": [
    "Senate Hall",
    "Rocko Stage",
    "Expo Stage",
  ],
  "Auditorium": [
    "Mini Auditorium",
    "Auditorium",
    "Audi Park",
  ],
  "Conference Hall": [
    "Conference Hall 1",
    "Conference Hall 2",
    "Conference Hall 3",
    "Conference Hall 4",
  ],
  "SAC Area": [
    "Front of Graffiti Wall",
    "Behind Graffiti Wall",
    "Old Sac Wall",
    "Old Sac Stage",
    "New SAC",
  ],
};

final List<String> keys = ["All","Lecture Halls","Grounds","Library Area", "Admin Area","Auditorium","Conference Hall","SAC Area"];



  List<EventDetail> allEvents = [];
  List<EventDetail> filteredEvents = [];

  final double hourHeight = 60.0; // Height for 1 hour

  Widget buildEvent(EventDetail event) {
    final eventHeight = calculateEventHeight(
        TimeOfDay(hour: event.starttime.hours, minute: event.starttime.min),
        TimeOfDay(
            hour: event.getEndTime().hours, minute: event.getEndTime().min));
    final topOffset = calculateEventHeight(TimeOfDay(hour: 8, minute: 0),
        TimeOfDay(hour: event.starttime.hours, minute: event.starttime.min));

    return Positioned(
      top: topOffset,
      left: 0,
      right: 0,
      height: eventHeight,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            event.type,
            style: TextStyle(
              fontFamily: 'Game_Tape',
              fontSize: 14,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  double calculateEventHeight(TimeOfDay start, TimeOfDay end) {
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    final durationMinutes = endMinutes - startMinutes;
    return (durationMinutes / 60.0) * hourHeight;
  }

  Color dayColor(int day) {
    if (day == selectedDay) {
      return Color(0xFFFFF1E8);
    } else {
      return Color(0xFF83769C);
    }
  }

  String formatTimeToAmPm(int hour) {
    final time = DateTime(2024, 1, 1, hour);
    return DateFormat('h:00 a').format(time);
  }

  Future<void> getEventsData() async {
    setState(() {
      isLoading = true;
    });

    try {

      // Fetch events
      allEvents = viewModelMain.allEvents;

      // Debug print
      print('Fetched ${allEvents.length} events');

      // Apply initial filtering after getting data
      filterEvents();
    } catch (e) {
      print("Error fetching events: $e");
      // You might want to show an error message to the user here
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterEvents() {
    if (allEvents.isEmpty) {
      print('No events to filter');
      return;
    }

    setState(() {
      filteredEvents = allEvents.where((event) {
        // Debug prints
        print('Filtering event: ${event.type}');
        print('Event venue: ${event.venue}, Selected venue: $selectedVenue');
        print('Event day: ${event.starttime.date}, Selected day: $selectedDay');

        final isSameDay = event.starttime.date.toString() == date;

        // If 'All' is selected, show all venues, otherwise filter by selected venue
        final isSameVenue = selectedVenue == 'ALL' ||
            event.venue.trim().toLowerCase() ==
                selectedVenue.trim().toLowerCase();

        return isSameDay && isSameVenue;
      }).toList();

      print('Filtered events count: ${filteredEvents.length}');
    });
  }

  // Modified venue selection handler
  void onVenueChanged(String? newValue) {
    if (newValue == null) return;

    setState(() {
      selectedVenue = newValue;
      filterEvents();
    });
  }

  // Modified venue category selection handler
  void onVenueCategoryChanged(String? newValue) {
    if (newValue == null) return;

    setState(() {
      selectedVenueCategory = newValue;
      selectedVenue = 'ALL'; // Reset selected venue when category changes
      filterEvents();
    });
  }

  // Modify your day selection handler
  void onDaySelected(int index) {
    setState(() {
      selectedDay = index;
      if (index == 0) {
        date = '8';
        month = 'FEB';
      } else if (index == 1) {
        date = '9';
        month = 'FEB';
      } else if (index == 2) {
        date = '10';
        month = 'FEB';
      } else if (index == 3) {
        date = '11';
        month = 'FEB';
      }
      filterEvents(); // Apply filtering immediately
    });
  }

  @override
  void initState() {
    super.initState();
    selectedDay = initialDay;
    getEventsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/schedule_screen_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              // Day Selector Row
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    final days = ['DAY 0', 'DAY 1', 'DAY 2', 'DAY 3'];
                    return GestureDetector(
                      onTap: () {
                        onDaySelected(index);
                      },
                      child: Text(
                        days[index],
                        style: TextStyle(
                          color: dayColor(index),
                          fontFamily: 'Game_Tape',
                          fontSize: 20.0,
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // Filter Row
              Container(
                height: 80,
                child: Row(
                  children: [
                    // Date Display
                    SizedBox(
                      width: 71,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            date,
                            style: TextStyle(
                              fontFamily: 'Brick_Pixel',
                              fontSize: 24,
                              color: Color(0xFFCA3562),
                            ),
                          ),
                          Text(
                            month,
                            style: TextStyle(
                              fontFamily: 'Brick_Pixel',
                              fontSize: 24,
                              color: Color(0xFFCA3562),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 22.0,
                    ),

                    // Vertical Divider
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: VerticalDivider(
                        width: 4,
                        color: Colors.grey,
                      ),
                    ),
                    // Venue Dropdown
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            // Venue Category Dropdown
                            DropdownButtonFormField<String>(
                              value: selectedVenueCategory,
                              style: TextStyle(
                                fontFamily: 'Game_Tape',
                                fontSize: 20.0,
                                color: Color(0xFFFFF1E8),
                              ),
                              items: keys.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: onVenueCategoryChanged,
                              dropdownColor: Color(0xFF1D2B53),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 30.0),
                                fillColor: Color(0xFF1D2B53),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.pink, width: 2),
                                  borderRadius: BorderRadius.zero,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.pink, width: 2),
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: 2,
                color: Colors.grey,
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: verticalController,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Time Column
                          SizedBox(
                            width: 95,
                            child: Column(
                              children: [
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(color: Colors.grey.withOpacity(1), ),
                                    right: BorderSide(color: Colors.grey.withOpacity(1), ),
                                  )),
                                ), // Empty space for top alignment
                                ...List.generate(
                                  15, // Each hour block
                                  (index) => Container(
                                    height: hourHeight,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey.withOpacity(1),
                                        ),
                                        right: BorderSide(
                                          color: Colors.grey.withOpacity(1),
                                        ),
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          formatTimeToAmPm(index + 8),
                                          style: const TextStyle(
                                            fontFamily: 'Game_Tape',
                                            fontSize: 19,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Venue Time Slots and Events
                          Expanded(
                            child: isLoading
                                ? Center(child: CircularProgressIndicator())
                                : SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    controller: horizontalController,
                                    child: Row(
                                      children: (selectedVenueCategory ==
                                                  'All'
                                              ? itemListMap["All"]!
                                              : itemListMap[selectedVenueCategory] ??[]).map((venue) {
                                        final venueEvents = filteredEvents.where((event) => event.venue.toLowerCase() == venue.toLowerCase()).toList();
                                        return SizedBox(
                                          width: 200, //column width for every block ie the place
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration:BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide( color: Colors.grey.withOpacity(1),),
                                                            right: BorderSide(color: Colors.grey.withOpacity(1),),
                                                          ),
                                                        ),
                                                height: 60,
                                                alignment: Alignment.center,
                                                child: Text(venue,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:FontWeight.bold,
                                                    fontFamily: 'Game_Tape',
                                                  ),
                                                ),
                                              ),
                                              Stack(
                                                children: [
                                                  // Time Slots
                                                  Column(
                                                    children: List.generate(15,(index) => Container(
                                                        height: hourHeight,
                                                        decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide( color: Colors.grey.withOpacity(1),),
                                                          right: BorderSide(color: Colors.grey.withOpacity(1),),
                                                        ),
                                                      ),
                                                      ),
                                                    ),
                                                  ),
                                                  // Events for the Venue
                                                  ...venueEvents.map((event) {
                                                    final start =event.starttime;
                                                    final end =event.getEndTime();
                                                    final startOffset =(start.hours - 8) +(start.min / 60);
                                                    final duration = (end.hours -start.hours) + (end.min - start.min) /60;
                                                    return Positioned(
                                                      top: startOffset *(hourHeight),
                                                      left: 8,
                                                      right: 8,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetailPage(event: event)));
                                                        },
                                                        child: Container(
                                                          height: duration *hourHeight,
                                                          padding:const EdgeInsets.all(8),
                                                          decoration:BoxDecoration(
                                                            image: DecorationImage(
                                                              image: AssetImage('assets/images/schedule_event_bg.png'),
                                                              fit: BoxFit.cover
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: SingleChildScrollView(
                                                              child: Column(
                                                                crossAxisAlignment:CrossAxisAlignment.start,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    event.artist,
                                                                    style: const TextStyle(
                                                                      fontSize: 25,
                                                                      color: Color(0xFFFFF1E8),
                                                                      fontWeight:FontWeight.bold,
                                                                      fontFamily: 'Game_Tape',
                                                                    ),
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                  Text(
                                                                    event.type,
                                                                    style: const TextStyle(
                                                                      fontSize: 13,
                                                                      color: Color(0xFFFFF1E8),
                                                                      fontWeight:FontWeight.bold,
                                                                      fontFamily: 'Game_Tape',
                                                                    ),
                                                                    overflow: TextOverflow.ellipsis,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      SizedBox(height:bottomNavBarHeight), // Adjusted for the bottom of the schedule
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
