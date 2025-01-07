import 'package:flutter/material.dart';
import 'package:alcheringa/Model/eventdetail.dart';

class EventDetailPage extends StatelessWidget {
  final EventDetail event;

  EventDetailPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          event.category,
          style: TextStyle(
            color: Color.fromRGBO(255, 241, 232, 1),
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black.withOpacity(0.8),
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/back_button.png',
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),

          // Content Section
          Positioned(
            top: 112,
            left: 25,
            right: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event Image
                Container(
                  width: 325,
                  height: 325,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.3),
                    image: DecorationImage(
                      image: NetworkImage(event.imgurl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Artist Name
                Text(
                  event.artist,
                  style: TextStyle(
                    color: Color.fromRGBO(255, 241, 232, 1),
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                // Event Type
                Text(
                  event.type,
                  style: TextStyle(
                    color: Color.fromRGBO(255, 160, 194, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 10),

                // Venue and Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(textAlign: TextAlign.left,
                      event.venue,
                      style: TextStyle(
                        color: Color.fromRGBO(255, 241, 232, 1),
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(textAlign: TextAlign.right,
                      '${event.starttime.date}, ${event.starttime.hours}:${event.starttime.min}',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 241, 232, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Event Description
                Text(
                  event.descriptionEvent,
                  style: TextStyle(
                    color: Color.fromRGBO(255, 241, 232, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 30),

                // Action Buttons with Overlayed Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Get Card Button
                    GestureDetector(
                      onTap: () {
                        // Action for Get Card button
                        if (event.reglink.isNotEmpty) {
                          // Navigate to registration link
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Background Image
                          Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/get_card_box.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          // Text Overlay
                          Text(
                            'Get Card',
                            style: TextStyle(
                              color: Color.fromRGBO(255, 241, 232, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Direction Button
                    GestureDetector(
                      onTap: () {
                        // Action for Direction button
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Background Image
                          Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/direction_box.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          // Text Overlay
                          Text(
                            'Direction',
                            style: TextStyle(
                              color: Color.fromRGBO(255, 241, 232, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                // Horizontal Divider
                Container(
                  width: 325,
                  height: 4,
                  color: Colors.black,
                ),
                SizedBox(height: 20),

                // Suggestions Section
                Text(
                  'Suggestions',
                  style: TextStyle(
                    fontFamily: 'AlcherPixel',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(255, 241, 232, 1),
                  ),
                ),
                SizedBox(height: 10),

                // Suggestion Cards (Placeholder)

              ],
            ),
          ),
        ],
      ),
    );
  }
}
