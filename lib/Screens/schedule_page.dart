import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Model/view_model_main.dart';
import 'package:alcheringa/Screens/cart_screen.dart';
import 'package:alcheringa/Screens/end_drawer.dart';
import 'package:alcheringa/Screens/notification/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:intl/intl.dart';

import '../Model/venue_model.dart';

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
  final ScrollController verticalController = ScrollController();
  final ScrollController horizontalController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> venuesList = ['ALL', 'Auditorium'];

  Color dayColor(int day) {
    if(day == selectedDay) {
      return Color(0xFFFFF1E8);
    } else {
      return Color(0xFF83769C);
    }
  }

  String formatTimeToAmPm(int hour) {
    final time = DateTime(2024, 1, 1, hour);
    return DateFormat('h:00 a').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 29, 43, 83),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
                  },
                  icon: Image.asset('assets/images/appbar_cart_icon.png'),
                ),
                badges.Badge(
                  badgeContent: Text(
                    '2',
                    style: TextStyle(
                      color: Color(0xFFCA3562),
                      fontFamily: 'Alcherpixel',
                    ),
                  ),
                  position: badges.BadgePosition.bottomEnd(bottom: 0, end: 10),
                  badgeStyle:
                      badges.BadgeStyle(badgeColor: Colors.transparent, borderRadius: BorderRadius.circular(5)),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationScreen()));
                    },
                    icon: Image.asset('assets/images/appbar_notification_icon.png'),
                  ),
                ),
              ],
            ),
            Image.asset('assets/images/appbar_alcheringa.png'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    // Action for first trailing icon
                  },
                  icon: Image.asset('assets/images/appbar_search_icon.png'),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: Image.asset(
              'assets/images/appbar_menu_icon.png',
            ),
          ),
        ],
      ),
      endDrawer: EndDrawer(
        scaffoldState: _scaffoldKey,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/schedule_screen_bg.png', // Replace with your image path
                fit: BoxFit.cover, // Ensures the image covers the entire screen
              ),
            ),

            Column(
              children: [
                // Day Selector Row
                Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDay = 0;
                            date = '31';
                            month = 'JAN';
                          });
                        },
                        child: Text(
                          'DAY 0',
                          style: TextStyle(
                            color: dayColor(0),
                            fontFamily: 'Alcherpixel',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDay = 1;
                            date = '01';
                            month = 'FEB';
                          });
                        },
                        child: Text(
                          'DAY 1',
                          style: TextStyle(
                            color: dayColor(1),
                            fontFamily: 'Alcherpixel',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDay = 2;
                            date = '02';
                            month = 'FEB';
                          });
                        },
                        child: Text(
                          'DAY 2',
                          style: TextStyle(
                            color: dayColor(2),
                            fontFamily: 'Alcherpixel',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDay = 3;
                            date = '03';
                            month = 'FEB';
                          });
                        },
                        child: Text(
                          'DAY 3',
                          style: TextStyle(
                            color: dayColor(3),
                            fontFamily: 'Alcherpixel',
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
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
                              color: Color(0xFFFFF1E8)
                            ),
                            items: venuesList
                                .map((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedVenue = newValue!;
                              });
                            },
                            dropdownColor: Color(0xFF1D2B53),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                              fillColor: Color(0xFF1D2B53),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.pink, width: 2), // Pink border
                                borderRadius: BorderRadius.zero, // Zero border radius
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.pink, width: 2),
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
            
                Container(
                  height: 2,
                  color: Colors.grey,
                ),
            
                // Schedule Grid
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
                              width: 80,
                              child: Column(
                                children: List.generate(
                                  17,
                                      (index) => SizedBox(
                                    height: 44,
                                    child: Center(
                                      child: Text(
                                        formatTimeToAmPm(index + 8),
                                        style: TextStyle(
                                          fontFamily: 'Alcherpixel',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Event Grid
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller: horizontalController,
                                child: SizedBox(
                                  width: 800,
                                  child: Column(
                                    children: List.generate(
                                      17,
                                          (index) => Container(
                                        height: 44,
                                        color: index.isEven
                                            ? Colors.grey.withOpacity(0.1)
                                            : Colors.transparent,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 200,
                                              margin: EdgeInsets.all(4),
                                              child: Center(
                                                child: Text(
                                                  'Event ${index + 1}',
                                                  style: TextStyle(
                                                    fontFamily: 'Alcherpixel',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 200,
                                              margin: EdgeInsets.all(4),
                                              child: Center(
                                                child: Text(
                                                  'Event ${index + 2}',
                                                  style: TextStyle(
                                                    fontFamily: 'Alcherpixel',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 200,
                                              margin: EdgeInsets.all(4),
                                              child: Center(
                                                child: Text(
                                                  'Event ${index + 3}',
                                                  style: TextStyle(
                                                    fontFamily: 'Alcherpixel',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: bottomNavBarHeight),
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
