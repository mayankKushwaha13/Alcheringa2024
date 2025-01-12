import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alcheringa/Model/eventdetail.dart';
import 'package:alcheringa/Model/view_model_main.dart';
import 'package:alcheringa/Screens/activity_pages/widgets/competition_card.dart';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:alcheringa/Model/venue_model.dart';

class EventDetailPage extends StatefulWidget {
  final EventDetail event;

  EventDetailPage({required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  List<VenueModel> venues = [];
  VenueModel? selectedVenue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchVenues();
  }

  Future<void> _fetchVenues() async {
    try {
      // Access ViewModelMain via Provider
      final viewModelMain = Provider.of<ViewModelMain>(context, listen: false);
      List<VenueModel> fetchedVenues = await viewModelMain.getVenues();

      setState(() {
        venues = fetchedVenues;
        // Find the venue that matches the event's venue name
        selectedVenue = venues.firstWhere(
          (venue) => venue.name == widget.event.venue,
          orElse: () => VenueModel(
            name: 'Unknown',
            latLng: LatLng(0, 0),
            description: 'No details available',
            imgUrl: '',
          ),
        );
      });
    } catch (e) {
      print('Error fetching venues: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fetch events of the same type for suggestions
    final allEvents =
        Provider.of<ViewModelMain>(context, listen: false).allEvents;
    final List<EventDetail> suggestions = allEvents
        .where((e) => e.type == widget.event.type && e != widget.event)
        .toList();

    // Shuffle and pick a limited number of suggestions
    suggestions.shuffle(Random());
    final List<EventDetail> displayedSuggestions =
        suggestions.take(10).toList();

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.fill,
              ),
            ),
      
            // Scrollable Content
            SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.only(top: 100, left: 25, right: 25, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
      
                    // Event Image
                    Center(
                      child: Container(
                        width: 325,
                        height: 325,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          image: DecorationImage(
                            image: NetworkImage(widget.event.imgurl),
                            fit: BoxFit.fill, // Use BoxFit.cover to make it fit
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
      
                    // Artist Name
                    Text(
                      widget.event.artist,
                      style: TextStyle(
                        fontFamily: 'Brick_Pixel',
                        color: Color.fromRGBO(255, 241, 232, 1),
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
      
                    // Event Type
                    Text(
                      widget.event.type,
                      style: TextStyle(
                        fontFamily: 'Game_Tape',
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
                        Text(
                          widget.event.venue,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Game_Tape',
                            color: Color.fromRGBO(255, 241, 232, 1),
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '${widget.event.starttime.date}, ${widget.event.starttime.hours}:${widget.event.starttime.min}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'Game_Tape',
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
                      widget.event.descriptionEvent,
                      style: TextStyle(
                        fontFamily: 'Game_Tape',
                        color: Color.fromRGBO(255, 241, 232, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 30),
      
                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Get Card Button
                        GestureDetector(
                          onTap: () {
                            if (widget.event.reglink.isNotEmpty) {
                              // Navigate to registration link
                            }
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 150,
                                height: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/get_card_box.png'),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Text(
                                'Get Card',
                                style: TextStyle(
                                  fontFamily: 'Brick_Pixel',
                                  color: Color.fromRGBO(255, 241, 232, 1),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                    shadows: [
                                      Shadow(
                                          offset: Offset(2.5, 2),
                                          color: Colors.black,
                                          blurRadius: 2),
                                  ]
                                ),
                              ),
                            ],
                          ),
                        ),
      
                        // Direction Button
                        GestureDetector(
                          onTap: () async {
                            if (selectedVenue != null) {
                              final googleMapsUrl = Uri.parse(
                                  'https://www.google.com/maps/dir/?api=1&destination=${selectedVenue!.latLng.latitude},${selectedVenue!.latLng.longitude}');
      
                              if (await canLaunchUrl(googleMapsUrl)) {
                                await launchUrl(googleMapsUrl);
                              } else {
                                throw 'Could not open Google Maps';
                              }
                            } else {
                              print('Selected venue is null.');
                            }
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 150,
                                height: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/direction_box.png'),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Text(
                                'Direction',
                                style: TextStyle(
                                  fontFamily: 'Brick_Pixel',
                                  color: Color.fromRGBO(255, 241, 232, 1),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                    shadows: [
                                      Shadow(
                                          offset: Offset(2.5, 2),
                                          color: Colors.black,
                                          blurRadius: 2),
                                    ]
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
      
                    // Horizontal Divider
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 325,
                        height: 4,
                        color: Color.fromRGBO(129, 177, 155, 1),
                      ),
                    ),
                    SizedBox(height: 20),
      
                    // Suggestions Section
                    Text(
                      'Suggestions',
                      style: TextStyle(
                        fontFamily: 'Brick_Pixel',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(255, 241, 232, 1),
                      ),
                    ),
                    SizedBox(height: 10),
      
                    // Suggestions Cards
                    SizedBox(
                      height: 400,
                      child: PageView.builder(
                        controller: PageController(viewportFraction: 1),
                        itemCount: (displayedSuggestions.length / 2).ceil(),
                        itemBuilder: (BuildContext context, int pageIndex) {
                          final int startIndex = pageIndex * 2;
                          final List<EventDetail> currentPageSuggestions =
                              displayedSuggestions
                                  .skip(startIndex)
                                  .take(2)
                                  .toList();
      
                          return Column(
                            children: currentPageSuggestions
                                .map(
                                  (suggestion) => Expanded(
                                    child: CompetitionCard(event: suggestion),
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ),
      
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
      
            // Custom App Bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                    // Event Category Text
                    Flexible(
                      child: Text(
                        widget.event.artist,
                        style: TextStyle(
                          fontFamily: 'Brick_Pixel',
                          color: Color.fromRGBO(255, 241, 232, 1),
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis, // Optional for truncation
                        maxLines: 1, // Ensures single-line display
                      ),
                    ),
                    SizedBox(width: 30),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
