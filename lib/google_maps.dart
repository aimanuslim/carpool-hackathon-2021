/* When intializing this widget, there will be drawn a map with the drivers route 
(source_location, dest_location) and given a state of where the passenger should 
join the route. The output is the distance saved in KM instead of driving alone.
 */

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:async';
import 'savedKM.dart';

import 'dart:math' show cos, sqrt, asin;

// void main() => runApp(GoogleMaps());

const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
// const LatLng SOURCE_LOCATION = LatLng(3.1112913233110935, 101.66584823996021);
const LatLng DEST_LOCATION = LatLng(3.1956071385311455, 101.60778900777943);
const LatLng PASSENGER_LOCAITON = LatLng(3.160461096819543, 101.59772941034296);

class GoogleMaps extends StatefulWidget {
  final LatLng source_location;
  final LatLng dest_location;
  final LatLng passenger_location;

  // In the constructor, require a Person
  GoogleMaps(
      {Key? key,
      required this.source_location,
      required this.dest_location,
      required this.passenger_location})
      : super(key: key);

  @override
  _GoogleMapsState createState() =>
      _GoogleMapsState(source_location, dest_location, passenger_location);
}

class _GoogleMapsState extends State<GoogleMaps> {
  late GoogleMapController mapController;

  // ignore: non_constant_identifier_names
  LatLng source_location;
  // ignore: non_constant_identifier_names
  LatLng dest_location;
  // ignore: non_constant_identifier_names
  LatLng passenger_location;

  _GoogleMapsState(
      this.source_location, this.dest_location, this.passenger_location);

  // ignore: empty_constructor_bodies

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  late double distanceSaved;

  String googleAPIKey = "AIzaSyBaTNZP7jh7tzO9QoL_0QoEJlTH10cQCqI";

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    // Drawing everything and setting it up
    List<LatLng> polyLinePoints = await Future.any([
      getPolyPoints(source_location, DEST_LOCATION, true),
    ]);
    LatLng shortCoord =
        _shortestRoute(3.160461096819543, 101.59772941034296, polyLinePoints);
    drawPolyLine(PASSENGER_LOCAITON, shortCoord);
    setMapPins();
    List<LatLng> savedDistancePoly = await Future.any([
      getPolyPoints(source_location, DEST_LOCATION, false),
    ]);
    distanceSaved = _getDistance(savedDistancePoly);
    print(distanceSaved);
  }

  void setMapPins() {
    setState(() {
      _markers.add(
          Marker(markerId: MarkerId('sourcePin'), position: source_location));
      _markers
          .add(Marker(markerId: MarkerId('destPin'), position: DEST_LOCATION));
    });
  }

  void drawPolyLine(LatLng source, LatLng dest) {
    List<LatLng> latlngSegment1 = [];

    latlngSegment1.add(source);
    latlngSegment1.add(dest);
    _polylines.add(Polyline(
      polylineId: PolylineId('line1'),
      visible: true,
      //latlng is List<LatLng>
      points: latlngSegment1,
      width: 2,
      color: Colors.red,
    ));
  }

  Future<List<LatLng>> getPolyPoints(
      LatLng source, LatLng dest, bool plot) async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> polylineCoordinates = [];

    // Stupid placeholder because of null issues
    Polyline polyline = Polyline(
        polylineId: PolylineId("poly"),
        color: Color.fromARGB(255, 40, 122, 198),
        points: polylineCoordinates);

    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        source.latitude,
        source.longitude,
        dest.latitude,
        dest.longitude);
    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      if (plot == true) {
        setState(() {
          polyline = Polyline(
              polylineId: PolylineId("poly"),
              color: Color.fromARGB(255, 40, 122, 198),
              points: polylineCoordinates);
          _polylines.add(polyline);
        });
      }
    }
    return polylineCoordinates;
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double _getDistance(List<LatLng> polylineCoordinates) {
    double totalDistance = 0.0;
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }
    return totalDistance;
  }

  LatLng _shortestRoute(lat, lon, List<LatLng> polylineCoordinates) {
    LatLng shortest = LatLng(0, 0);
    double shortestLength = 100000;
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      double temp = _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        lat,
        lon,
      );
      if (shortestLength > temp) {
        shortest = LatLng(
            polylineCoordinates[i].latitude, polylineCoordinates[i].longitude);
        shortestLength = temp;
      }
    }
    setState(() {
      _markers.add(Marker(markerId: MarkerId('pickupPin'), position: shortest));
      _markers.add(
          Marker(markerId: MarkerId('originPin'), position: LatLng(lat, lon)));
    });
    return shortest;
  }

  int _selectedIndex = 0;
  void _onItemTap(int index) {
    _selectedIndex = index;
    if (_selectedIndex == 0) {
      Navigator.pop(context);
    } else if (_selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SavedKM(
                  number: distanceSaved.toInt(),
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Here is how to get to your [placeholder]'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(3.1112913233110935, 101.66584823996021),
          zoom: 11.0,
        ),
        markers: _markers.toSet(),
        polylines: _polylines,
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_back_outlined), label: 'Back'),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment_turned_in_outlined),
                label: 'Accept route'),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.grey,
          iconSize: 40,
          onTap: _onItemTap,
          elevation: 5),
    ));
  }
}
