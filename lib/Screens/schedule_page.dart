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
  String date = '31';
  String month = 'Jan';
  int selectedDay = 0;
  String selectedVenue = 'ALL';
  bool isLoading = true; // Add this if not already present
  int initialDay = 0;
  final ScrollController verticalController = ScrollController();
  final ScrollController horizontalController = ScrollController();
  final ViewModelMain viewModel = ViewModelMain();
  List<String> venuesList = ['ALL', 'Auditorium', 'library'];
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

  List<EventDetail> allEvents = [];
  List<EventDetail> filteredEvents = [];
  List<Map<String, dynamic>> events = [
    {
      'name': 'Event 1',
      'startTime': TimeOfDay(hour: 9, minute: 0),
      'endTime': TimeOfDay(hour: 10, minute: 30),
      'venue': 'Auditorium'
    },
    {
      'name': 'Event 2',
      'startTime': TimeOfDay(hour: 11, minute: 0),
      'endTime': TimeOfDay(hour: 12, minute: 0),
      'venue': 'Auditorium'
    },
    {
      'name': 'Event 3',
      'startTime': TimeOfDay(hour: 13, minute: 0),
      'endTime': TimeOfDay(hour: 15, minute: 0),
      'venue': 'Auditorium'
    },
    {
      'name': 'Event 4',
      'startTime': TimeOfDay(hour: 9, minute: 0),
      'endTime': TimeOfDay(hour: 10, minute: 30),
      'venue': 'library'
    },
  ];

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
      allEvents = await ViewModelMain().getAllEvents();
      // Apply initial filtering after getting data
      filterEvents();
    } catch (e) {
      print("Error fetching events: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterEvents() {
    if (allEvents.isEmpty) return; // Guard clause

    setState(() {
      filteredEvents = allEvents.where((event) {
        // Print debugging information
        print('Filtering event: ${event.type}');
        print('Event venue: ${event.venue}, Selected venue: $selectedVenue');
        print('Event day: ${event.starttime.date}, Selected day: $selectedDay');

        final isSameDay = event.starttime.date == selectedDay;
        final isSameVenue = selectedVenue == 'ALL' ||
            event.venue.trim().toLowerCase() ==
                selectedVenue.trim().toLowerCase();

        final isIncluded = isSameDay && isSameVenue;
        print('Is included: $isIncluded');

        return isIncluded;
      }).toList();

      // Print total filtered events
      print('Total filtered events: ${filteredEvents.length}');
    });
  }

  // Modify your venue selection handler
  void onVenueChanged(String? newValue) {
    if (newValue == null) return;

    setState(() {
      selectedVenue = newValue;
      filterEvents(); // Apply filtering immediately
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
      body: SafeArea(
        child: Stack(
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
                          // setState(() {
                          //   selectedDay = index;
                          //   if (index == 0) {
                          //     date = '8';
                          //     month = 'FEB';
                          //   } else if (index == 1) {
                          //     date = '9';
                          //     month = 'FEB';
                          //   } else if (index == 2) {
                          //     date = '10';
                          //     month = 'FEB';
                          //   } else if (index == 3) {
                          //     date = '11';
                          //     month = 'FEB';
                          //   }
                          //   filterEvents();
                          // });
                        },
                        child: Text(
                          days[index],
                          style: TextStyle(
                            color: dayColor(index),
                            fontFamily: 'Alcherpixel',
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
                                fontFamily: 'Alcherpixel',
                                fontSize: 24,
                                color: Color(0xFFCA3562),
                              ),
                            ),
                            Text(
                              month,
                              style: TextStyle(
                                fontFamily: 'Alcherpixel',
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
                      Container(
                        width: 2,
                        color: Colors.grey,
                      ),
                      // Venue Dropdown
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: DropdownButtonFormField<String>(
                          value: selectedVenue,
                          style: TextStyle(
                              fontFamily: 'Alcherpixel',
                              fontSize: 20.0,
                              color: Color(0xFFFFF1E8)),
                          items: venuesList
                              .map((String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: onVenueChanged,
                          // onChanged: (String? newValue) {
                          //   setState(() {
                          //     selectedVenue = newValue!;
                          //     filterEvents();
                          //   });
                          // },
                          dropdownColor: Color(0xFF1D2B53),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 30.0),
                            fillColor: Color(0xFF1D2B53),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.pink, width: 2), // Pink border
                              borderRadius:
                                  BorderRadius.zero, // Zero border radius
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.pink, width: 2),
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      )),
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
                                      bottom: BorderSide(
                                        color: Colors.grey.withOpacity(1),
                                      ),
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
                                        children: venuesList
                                            .where((venue) =>
                                                selectedVenue == 'ALL' ||
                                                selectedVenue.toLowerCase() ==
                                                    venue.toLowerCase())
                                            .map((venue) {
                                          final venueEvents = filteredEvents
                                              .where((event) =>
                                                  event.venue.toLowerCase() ==
                                                  venue.toLowerCase())
                                              .toList();

                                          // Check if there are no events for the selected venue
                                          // if (venueEvents.isEmpty &&
                                          //     selectedVenue != 'ALL') {
                                          //   return SizedBox(
                                          //     width: 200,
                                          //     child: Center(
                                          //       child: Text(
                                          //         'There are no events at the current location',
                                          //         style: TextStyle(
                                          //           color: Colors.white,
                                          //           fontStyle: FontStyle.italic,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   );
                                          // }

                                          return SizedBox(
                                            width: 200, // Fixed width per venue
                                            child: Stack(
                                              children: [
                                                // Venue Name
                                                Container(
                                                  height: 50,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    venue,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                // Time Slots
                                                Column(
                                                  children: List.generate(
                                                    15,
                                                    (index) => Container(
                                                      height: hourHeight,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            color: Colors.grey
                                                                .withOpacity(1),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // Events for the Venue
                                                ...venueEvents.map((event) {
                                                  final start = event.starttime;
                                                  final end =
                                                      event.getEndTime();
                                                  final startOffset =
                                                      (start.hours - 8) +
                                                          (start.min / 60);
                                                  final duration = (end.hours -
                                                          start.hours) +
                                                      (end.min - start.min) /
                                                          60;

                                                  return Positioned(
                                                    top: startOffset *
                                                        hourHeight,
                                                    left: 8,
                                                    right: 8,
                                                    child: Container(
                                                      height:
                                                          duration * hourHeight,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.blueAccent
                                                            .withOpacity(0.8),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            event.type,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height:
                                bottomNavBarHeight), // Adjusted for the bottom of the schedule
                      ],
                    ),
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
