import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

import 'data/emojis.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: NfcScan(),
      ),
    );
  }
}

class NfcScan extends StatefulWidget {
  NfcScan({Key key}) : super(key: key);

  @override
  _NfcScanState createState() => _NfcScanState();
}

class _NfcScanState extends State<NfcScan> {
  LocationData _currentLocation;
  final Map<String, Marker> _markers = {};

  List<Circle> _circles = [
    Circle(
        circleId: CircleId("player"),
        center: LatLng(45.521563, -122.677433),
        strokeColor: Colors.blue,
        strokeWidth: 1,
        radius: 200,
        fillColor: Colors.blue.withOpacity(0.2))
  ];

  Completer<GoogleMapController> _mapController = Completer();

  var location = new Location();

  _updatePlayerCircle(final LocationData location) {
    int playerCircleIndex =
        _circles.indexWhere((c) => c.circleId.value == 'player');
    Circle currentPlayerCircle = _circles[playerCircleIndex];
    setState(() {
      _circles[playerCircleIndex] = currentPlayerCircle.copyWith(
          centerParam: locationDataToLatLang(location));
    });
  }

  LatLng locationDataToLatLang(LocationData ld) {
    return LatLng(ld.latitude, ld.longitude);
  }

  _initLocation() async {
    LocationData loc = await location.getLocation();
    _currentLocation = loc;
    _updatePlayerCircle(loc);
  }

  @override
  initState() {
    super.initState();
    _initLocation();
    location.onLocationChanged().listen((LocationData currentLocation) {
      setState(() {
        _currentLocation = currentLocation;
      });
      _updatePlayerCircle(currentLocation);
    });
    FlutterNfcReader.onTagDiscovered().listen((onData) async {
      print(onData.id);
      print(onData.content);
      print(_currentLocation.latitude.toString() +
          ", " +
          _currentLocation.longitude.toString());
      print(_currentLocation.altitude);
      print(_currentLocation.accuracy);

      final marker = Marker(
        markerId: MarkerId(onData.id),
        position: LatLng(_currentLocation.latitude, _currentLocation.longitude),
        infoWindow: InfoWindow(
          title: onData.id,
          snippet: "NFC TEST",
        ),
      );

      final CameraPosition pos = CameraPosition(
          target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
          //tilt: 59.440717697143555,
          zoom: 17.0);
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(pos));

      setState(() {
        // _markers.clear();

        try {
          _markers[onData.id] = marker;
        } on PlatformException catch (e) {
          if (e.code == 'PERMISSION_DENIED') {
//                error = 'Permission denied';
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //problem med hot restart. kartan försvinner då.
        //fungerar igen vid omstart eller om man lägger till eller tar bort en widget som wrappar GoogleMap()
        Container(
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            //kan användas för heatmap och för att se användarens search radius. Det är inom den radiusen som användaren kan se nya publika nfc chip
            //finns även plygons
            circles: _circles.toSet(),
            initialCameraPosition: CameraPosition(
              target: LatLng(45.521563, -122.677433),
              zoom: 17.0,
            ),
            markers: _markers.values.toSet(),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              EMOJIS[8].code,
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
      ],
    );
  }
}
