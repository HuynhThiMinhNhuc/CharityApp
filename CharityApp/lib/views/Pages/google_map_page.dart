import 'dart:async';

import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

class GoogleMapPage extends StatefulWidget {
  final googlePlace = GooglePlace("AIzaSyC1GPiRhUr2xSsz801IdinRlINbBkJAXKU");

  final LatLng initLatlng;
  GoogleMapPage(
      {Key? key, this.initLatlng = const LatLng(10.762622, 106.660172)})
      : super(key: key);

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  late TextEditingController locationTextController;
  Completer<GoogleMapController> _googleMapController = Completer();
  Marker? locationMarker;
  Placemark? googlePlace;
  AutocompletePrediction? detailPlace;
  String? namePlace;

  @override
  void initState() {
    super.initState();
    locationTextController = TextEditingController();
    initialCameraPosition = CameraPosition(target: widget.initLatlng, zoom: 10);
  }

  @override
  void dispose() {
    locationTextController.dispose();
    super.dispose();
  }

  void getCurrentLocation() async {
    final current = await _determinePosition().catchError((e) {
      print(e);
      return null;
    });
    if (current != null) {
      googlePlace =
          (await placemarkFromCoordinates(current.latitude, current.longitude))
              .first;
      setMarker(current.latitude, current.longitude);
    } else {
      googlePlace = (await placemarkFromCoordinates(
              widget.initLatlng.latitude, widget.initLatlng.longitude))
          .first;
      setMarker(widget.initLatlng.latitude, widget.initLatlng.longitude);
    }
  }

  String? formatName() {
    String rs = "";
    if (detailPlace == null) {
      void addInfor(String? value) {
        if (value != null && value.isNotEmpty) {
          if (rs.isNotEmpty) rs += ", ";
          rs += value;
        }
      }

      addInfor(googlePlace!.street);
      addInfor(googlePlace!.locality);
      addInfor(googlePlace!.subAdministrativeArea);
      addInfor(googlePlace!.administrativeArea);
    } else {
      rs = detailPlace!.description ?? "";
      rs.replaceAll("City", "");
      rs.replaceAll("Province", "");
      rs.replaceAll("District", "");
    }
    return rs;
  }

  void setMarker(double lat, double lng) async {
    // googlePlace = (await placemarkFromCoordinates(lat, lng)).first;
    // print(googlePlace);
    namePlace = formatName();

    CameraPosition camera = CameraPosition(target: LatLng(lat, lng), zoom: 12);
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(camera));

    locationMarker = Marker(
        markerId: const MarkerId('myLocation'),
        position: LatLng(lat, lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: namePlace));
    setState(() {});
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    // LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     // Permissions are denied, next time you could try
    //     // requesting permissions again (this is also where
    //     // Android's shouldShowRequestPermissionRationale
    //     // returned true. According to Android guidelines
    //     // your App should show an explanatory UI now.
    //     return Future.error('Location permissions are denied');
    //   }
    // }

    // if (permission == LocationPermission.deniedForever) {
    //   // Permissions are denied forever, handle appropriately.
    //   return Future.error(
    //       'Location permissions are permanently denied, we cannot request permissions.');
    // }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundbottomtab,
          title: buildSearch(onSearch: searchComplete),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.check),
            onPressed: () {
              var args = [
                namePlace,
                LatLng(locationMarker!.position.latitude,
                    locationMarker!.position.longitude)
              ];
              Navigator.of(context).pop(args);
            }),
        body: Column(
            // height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
            children: [
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: initialCameraPosition,
                  myLocationEnabled: false,
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) {
                    _googleMapController.complete(controller);
                    googleMapController = controller;

                    getCurrentLocation();
                  },
                  markers: {
                    if (locationMarker != null) locationMarker!,
                  },
                  onTap: (LatLng latlng) async {
                    googlePlace = (await placemarkFromCoordinates(
                            latlng.latitude, latlng.longitude))
                        .first;
                    print(googlePlace);
                    detailPlace = null;
                    setMarker(latlng.latitude, latlng.longitude);
                  },
                ),
              ),
            ]),
      ),
    );
  }

  void searchComplete() async {
    if (detailPlace != null) {
      final place = await widget.googlePlace.details.get(detailPlace!.placeId!);
      final location = place != null &&
              place.result != null &&
              place.result!.geometry != null
          ? place.result!.geometry!.location
          : null;
      //Set marker
      setMarker(location!.lat!, location.lng!);
    }
  }

  Widget buildSearch({Function()? onSearch}) {
    return TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          controller: locationTextController,
          decoration: InputDecoration(
            hintText: 'Nhập địa chỉ...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            suffixIcon: IconButton(
              onPressed: null,
              icon: Icon(Icons.search),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
        ),
        suggestionsCallback: (keyword) async {
          if (keyword.isEmpty) return [];
          final result =
              await widget.googlePlace.autocomplete.get(keyword, region: 'vn');

          if (result != null && result.predictions != null) {
            return result.predictions!;
          }
          return [];
        },
        itemBuilder: (context, suggestion) => Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                (suggestion as AutocompletePrediction).description!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontFamily: 'Roboto_Regular',
                    fontWeight: FontWeight.normal),
              ),
            ),
        onSuggestionSelected: (place) {
          detailPlace = (place as AutocompletePrediction);
          onSearch?.call();
        });
  }
}
