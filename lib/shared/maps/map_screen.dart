import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  // const MapScreen({super.key});
  // final double lat;
  // final double lng;
  // const MapScreen(this.lat, this.lng);
  final dynamic destloc;
  const MapScreen({super.key, this.destloc});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  static LatLng curLocation = const LatLng(-6.935127337338836, 107.62177380494678);
  static LatLng destLocation = const LatLng(-6.935127337338836, 107.61950714380434);
  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    setState(() {
      destLocation = LatLng(widget.destloc['lat'], widget.destloc['lng']);
    });
    getPolylinePoints().then((coordinates) => {
          generatePolyLineFromPoints(coordinates),
        });
    // getLocationUpdates().then(
    //   (_) => {
    //     getPolylinePoints().then((coordinates) => {
    //           generatePolyLineFromPoints(coordinates),
    //         }),
    //   },
    // );
  }

  // Future _getCurrentLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     KedairekaOverlayNotifications.showError(
  //         "Location services are disabled.");
  //     return Future.error('Location services are disabled.');
  //   }

  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       KedairekaOverlayNotifications.showError(
  //           "Location permissions are denied");
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     KedairekaOverlayNotifications.showError(
  //         "Location permissions are permanently denied, we cannot request permissions.");
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   polylines = await _getAllPolylines();
  //   markers.add(Marker(
  //       markerId: const MarkerId('driver_location'),
  //       icon: currentLocationIcon,
  //       position: LatLng(currentPosition?.target.latitude ?? 0,
  //           currentPosition?.target.longitude ?? 0)));
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('=== isi lat lng ${widget.destloc.toString()}');

    return Scaffold(
      body: GoogleMap(
        onMapCreated: ((GoogleMapController controller) =>
            mapController.complete(controller)),
        initialCameraPosition: CameraPosition(target: curLocation, zoom: 13),
        markers: {
          Marker(
              markerId: const MarkerId("current_position"),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueAzure),
              position: curLocation),
          Marker(
              markerId: const MarkerId("destination_position"),
              icon: BitmapDescriptor.defaultMarker,
              position: LatLng(widget.destloc['lat'], widget.destloc['lng']))
        },
        polylines: Set<Polyline>.of(polylines.values),
      ),
    );
  }

  // Future<void> getLocationUpdate() {
  //   bool serviceEnabled;
  //   PermissionStatus
  // }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();

    // Create a PolylineRequest object
    PolylineRequest request = PolylineRequest(
      origin: PointLatLng(curLocation.latitude, curLocation.longitude),
      destination: PointLatLng(destLocation.latitude, destLocation.longitude),
      mode: TravelMode.driving, // Set travel mode
    );

    // Call the updated method with named parameter 'request'
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: request,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }
    return polylineCoordinates;
  }


  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.greenAccent,
        points: polylineCoordinates,
        width: 8);
    setState(() {
      polylines[id] = polyline;
    });
  }
}
