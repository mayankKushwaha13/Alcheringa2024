import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

// import 'dart:ui' as ui;
import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Model/eventdetail.dart';
import 'package:alcheringa/Model/own_time.dart';
import 'package:alcheringa/Model/venue_model.dart';
import 'package:alcheringa/Model/view_model_main.dart';
import 'package:alcheringa/Screens/activity_pages/pixel_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/event_provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _center = LatLng(26.190585, 91.696628);
  Completer<GoogleMapController> _controller = Completer();
  double _currentZoom = 17.0;
  bool _isPermissionGranted = false;
  Set<Marker> _markers = {};
  final String mapstyle = '''
  [ { "featureType": "all", "elementType": "labels.text", "stylers": [ { "visibility": "on" } ] }, { "featureType": "all", "elementType": "labels.icon", "stylers": [ { "visibility": "off" } ] }, { "featureType": "administrative.land_parcel", "elementType": "geometry.fill", "stylers": [ { "color": "#ff0000" }, { "visibility": "off" } ] }, { "featureType": "landscape.man_made", "elementType": "geometry.fill", "stylers": [ { "color": "#48597B" } ] }, { "featureType": "landscape.man_made", "elementType": "geometry.stroke", "stylers": [ { "color": "#b2b2b2" }, { "visibility": "on" } ] }, { "featureType": "landscape.natural.landcover", "elementType": "geometry.fill", "stylers": [ { "color": "#a6a6a6" }, { "visibility": "off" } ] }, { "featureType": "landscape.natural.terrain", "elementType": "geometry.fill", "stylers": [ { "color": "#1C2536" }, { "visibility": "on" } ] }, { "featureType": "poi.business", "elementType": "geometry.fill", "stylers": [ { "color": "#508472" } ] }, { "featureType": "poi.government", "elementType": "geometry.fill", "stylers": [ { "color": "#b692b6" } ] }, { "featureType": "poi.park", "elementType": "geometry.fill", "stylers": [ { "color": "#508472" } ] }, { "featureType": "poi.park", "elementType": "geometry.stroke", "stylers": [ { "color": "#f8d93c" }, { "visibility": "off" } ] }, { "featureType": "poi.school", "elementType": "geometry.fill", "stylers": [ { "color": "#1C2536" } ] }, { "featureType": "poi.sports_complex", "elementType": "geometry.fill", "stylers": [ { "color": "#508472" } ] }, { "featureType": "poi.sports_complex", "elementType": "geometry.stroke", "stylers": [ { "color": "#e4e748" } ] }, { "featureType": "road", "elementType": "geometry.fill", "stylers": [ { "color": "#819BC8" } ] }, { "featureType": "road", "elementType": "geometry.stroke", "stylers": [ { "color": "#757575" }, { "visibility": "on" } ] }, { "featureType": "water", "elementType": "geometry.fill", "stylers": [ { "color": "#75aef3" } ] } ]
  ''';
  final TextEditingController _textFieldController = TextEditingController();
  String selectedVenue = '';
  List<VenueModel> _filteredVenue = [];
  List<VenueModel> _venueList = [];
  List<EventDetail> eventList = [];
  late BitmapDescriptor customMarker;
  final CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    controller.setMapStyle(mapstyle);
    _customInfoWindowController.googleMapController = controller;
  }

  //
  // void _onMapCreated(GoogleMapController controller) {
  //   _controller.complete(controller);
  // }

  void _checkAndRequestPermission() async {
    _isPermissionGranted = await viewModelMain.requestLocationPermission();
  }

  // void loadCustomMarker() async {
  //   final _customMarker = await BitmapDescriptor.asset(
  //     const ImageConfiguration(size: Size(40, 50)),
  //     'assets/images/map_marker.png',
  //   );
  //   setState(() {
  //     customMarker = _customMarker;
  //   });
  // }
  Future<void> loadCustomMarker() async {
    final Uint8List markerIcon = await viewModelMain.getBytesFromAsset('assets/images/map_marker.png', 60);
    customMarker = BitmapDescriptor.bytes(markerIcon);
  }

  Set<Marker> convertToMarkers(List<VenueModel> venueList) {
    return venueList.map((venue) {
      return Marker(
          markerId: MarkerId(venue.name),
          position: venue.latLng,
          icon: customMarker,
          // infoWindow: InfoWindow(
          //   title: venue.name,
          //   snippet: venue.description,
          //   onTap: () async {
          //     final googleMapsUrl = Uri.parse(
          //         'https://www.google.com/maps/dir/?api=1&destination=${venue.latLng.latitude},${venue.latLng.longitude}');
          //
          //     if (await canLaunchUrl(googleMapsUrl)) {
          //       await launchUrl(googleMapsUrl);
          //     } else {
          //       throw 'Could not open Google Maps';
          //     }
          //   },
          // ),
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              GestureDetector(
                onTap: () async {
                  final Uri appleMapsUrl = Uri.parse(
                      'https://maps.apple.com/?daddr=${venue.latLng.latitude},${venue.latLng.longitude}&dirflg=w');
                  final Uri googleMapsUrl = Uri.parse(
                      'https://www.google.com/maps/dir/?api=1&destination=${venue.latLng.latitude},${venue.latLng.longitude}');

                  if (Platform.isIOS) {
                    if (await canLaunchUrl(appleMapsUrl)) {
                      await launchUrl(appleMapsUrl);
                    } else {
                      throw 'Could not open Apple Maps';
                    }
                  } else if (Platform.isAndroid) {
                    if (await canLaunchUrl(googleMapsUrl)) {
                      await launchUrl(googleMapsUrl);
                    } else {
                      throw 'Could not open Google Maps';
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      Text(
                        venue.name,
                        style: TextStyle(
                          fontSize: 16.0
                        ),
                      ),
                      Text(
                        'click to navigate',
                        style: TextStyle(
                          fontSize: 12.0
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              venue.latLng,
            );
          });
    }).toSet();
  }

  Future<void> getData() async {
    await loadCustomMarker();
    final venueList = viewModelMain.venuesList;
    final _eventList = viewModelMain.allEvents;
    setState(() {
      _markers = convertToMarkers(venueList);
      _venueList = venueList;
      _filteredVenue = venueList;
      eventList = _eventList;
    });
  }

  EventDetail? getNextEvent(String venue) {
    DateTime current = DateTime.now();
    int currentDay = current.day;
    int currentHour = current.hour;
    int currentMin = current.minute;

    OwnTime now = OwnTime(date: currentDay, hours: currentHour, min: currentMin);

    var filteredEvents = eventList.where((event) => event.venue.toLowerCase() == venue.toLowerCase() && event.starttime.isAfter(now) && event.isArtistRevealed).toList();
    if (filteredEvents.isEmpty) {
      return null;
    }

    EventDetail nextEvent = filteredEvents.reduce((a, b) => a.starttime.isAfter(b.starttime) ? b : a);

    return nextEvent;
  }

  void _filterVenue(String query, List<VenueModel> venues) {
    if (query.isEmpty) {
      setState(() {
        _filteredVenue = List.from(venues);
      });
    } else {
      setState(() {
        _filteredVenue = venues.where((venue) => venue.name.toLowerCase().contains(query.toLowerCase())).toList();
      });
    }
  }

  // void _filterVenue(String query) {
  //   if (query.isEmpty) {
  //     setState(() {
  //       _filteredVenue = List.from(_venueList);
  //     });
  //   } else {
  //     setState(() {
  //       _filteredVenue = _venueList
  //           .where((venue) =>
  //               venue.name.toLowerCase().contains(query.toLowerCase()))
  //           .toList();
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _checkAndRequestPermission();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final eventProvider = Provider.of<EventProvider>(context, listen: false);
      eventProvider.fetchEvents();
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    final venues = eventProvider.venues;
    final events = eventProvider.allEvents;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          GoogleMap(
            style: mapstyle,
            initialCameraPosition: CameraPosition(target: _center, zoom: _currentZoom),
            onMapCreated: _onMapCreated,
            zoomControlsEnabled: false,
            myLocationEnabled: _isPermissionGranted,
            myLocationButtonEnabled: false,
            markers: _markers,
            minMaxZoomPreference: MinMaxZoomPreference(16, 20),
            onTap: (location) {
              _customInfoWindowController.hideInfoWindow;
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
              _customInfoWindowController.hideInfoWindow;
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            width: 150,
            offset: 70.0,
          ),
          viewModelMain.venuesList.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: [
                    Positioned(
                      top: 20.0,
                      left: 0.0,
                      right: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          children: [
                            PixelTextField(
                              hintText: 'Search',
                              controller: _textFieldController,
                              onChanged: (query) => _filterVenue(query, venues),
                              height: 50,
                            ),
                            if (_textFieldController.text.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ..._filteredVenue.map((venue) {
                                        return GestureDetector(
                                          onTap: () async {
                                            FocusScope.of(context).unfocus();
                                            final venueLocation = venue.latLng;
                                            final GoogleMapController controller = await _controller.future;

                                            controller.animateCamera(CameraUpdate.newLatLng(venueLocation));
                                            controller.showMarkerInfoWindow(MarkerId(venue.name));
                                            setState(() {
                                              _textFieldController.text = '';
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(15.0),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(131, 118, 156, 1),
                                              border:
                                                  Border.all(color: Colors.black, width: 2.0, style: BorderStyle.solid),
                                            ),
                                            child: Text(
                                              venue.name,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Game_Tape",
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(_markers.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          final venueLocation = _venueList[index].latLng;
                                          final GoogleMapController mapController = await _controller.future;

                                          mapController.animateCamera(CameraUpdate.newLatLng(venueLocation));
                                          mapController.showMarkerInfoWindow(MarkerId(_venueList[index].name));
                                        },
                                        child: Container(
                                          height: 120.0,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage('assets/images/map_marker_holder_bg.png'),
                                                fit: BoxFit.fill),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                AspectRatio(
                                                  aspectRatio: 1,
                                                  child: Container(
                                                      padding: EdgeInsets.all(10.0),
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage('assets/images/map_sprite_holder.png'),
                                                            fit: BoxFit.fill),
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl: _venueList[index].imgUrl,
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _venueList[index].name,
                                                      style: TextStyle(
                                                        fontSize: 22.0,
                                                        fontFamily: "Game_Tape",
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Upcoming events:',
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontFamily: "Game_Tape",
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      getNextEvent(_venueList[index].name)?.artist ??
                                                          "No upcoming event",
                                                      style: TextStyle(
                                                        fontSize: 11.0,
                                                        fontFamily: "Game_Tape",
                                                        color: Color(0xFFFF77A8),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                  },
                                                  child: Image.asset('assets/images/map_location_icon.png'),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
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

class BottomSheet extends StatefulWidget {
  BottomSheet({super.key, required this.controller});

  Completer<GoogleMapController> controller;

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  List<EventDetail> eventList = [];
  List<VenueModel> _markers = [];

  Future<void> getData() async {
    final _venueList = viewModelMain.venuesList;
    final _eventList = viewModelMain.allEvents;
    setState(() {
      _markers = _venueList;
      eventList = _eventList;
    });
  }

  EventDetail? getNextEvent(String venue) {
    DateTime current = DateTime.now();
    int currentDay = current.day;
    int currentHour = current.hour;
    int currentMin = current.minute;

    OwnTime now = OwnTime(date: currentDay, hours: currentHour, min: currentMin);

    var filteredEvents = eventList.where((event) => event.venue == venue && event.starttime.isAfter(now)).toList();
    if (filteredEvents.isEmpty) {
      return null;
    }

    EventDetail nextEvent = filteredEvents.reduce((a, b) => a.starttime.isAfter(b.starttime) ? b : a);

    return nextEvent;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Color(0xFF1D2B53),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_markers.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: GestureDetector(
                      onTap: () async {
                        final venueLocation = _markers[index].latLng;
                        final GoogleMapController mapController = await widget.controller.future;

                        mapController.animateCamera(CameraUpdate.newLatLng(venueLocation));
                        mapController.showMarkerInfoWindow(MarkerId(_markers[index].name));
                      },
                      child: Container(
                        height: 99.0,
                        width: 327,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/map_marker_holder_bg.png'), fit: BoxFit.fill),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('assets/images/map_sprite_holder.png'), fit: BoxFit.fill),
                                    ),
                                    child: CachedNetworkImage(imageUrl: _markers[index].imgUrl)),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _markers[index].name,
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontFamily: "Game_Tape",
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Upcoming events:',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: "Game_Tape",
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    getNextEvent(_markers[index].name)?.artist ?? "No upcoming event",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: "Game_Tape",
                                      color: Color(0xFFFF77A8),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Image.asset('assets/images/map_location_icon.png')
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: bottomNavBarHeight,
            ),
          ],
        ),
      ),
    );
  }
}
