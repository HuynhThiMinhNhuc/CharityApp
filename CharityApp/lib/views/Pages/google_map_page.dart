import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  GoogleMapPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(10.762622, 106.660172), zoom: 10);
  late Position position;

  @override
  void initState() {
    super.initState();
  }

  void getCurrentLocation() async {
    position = await _determinePosition();
    // setState(() {
    //   initialCameraPosition = CameraPosition(
    //       target: LatLng(position.latitude, position.longitude), zoom: 10);
    // });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    return MaterialApp(
      home: Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: initialCameraPosition,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
            )),
      ),
    );
  }
}
