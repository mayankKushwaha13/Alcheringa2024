import 'dart:async';

import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Model/view_model_main.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var opened = false;
  final _center = LatLng(26.198559, -268.281730);
  Completer<GoogleMapController> _controller = Completer();
  double _currentZoom = 11.0;
  bool _isPermissionGranted = false;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _checkAndRequestPermission() async {
    // _isPermissionGranted = await ViewModelMain().requestLocationPermission();
  }

  @override
  void initState() {
    super.initState();
    // _checkAndRequestPermission();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scaffoldKey.currentState?.showBottomSheet((BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('This is bottom sheet scaffold'),
            SizedBox(
              height: bottomNavBarHeight,
            )
          ],
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _center, zoom: _currentZoom),
            onMapCreated: _onMapCreated,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
        ],
      ),
    );
  }
}
