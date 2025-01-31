// import 'dart:async';
// import 'dart:html';
// import 'dart:math' show cos, sqrt, asin;

// import 'package:app_management_system/shared/custom_alert/alert_dialog_custom.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as loc;
// import 'package:location/location.dart';

// class NavigationWidget extends StatefulWidget {
//   final double lat;
//   final double lng;
//   const NavigationWidget(this.lat, this.lng);

//   @override
//   State<NavigationWidget> createState() => _NavigationWidgetState();
// }

// class _NavigationWidgetState extends State<NavigationWidget> {
//   final Completer<GoogleMapController> maps = Completer();
//   Map<PolylineId, Polyline> polylines = {};
//   PolylinePoints polylinePoints = PolylinePoints();
//   Location location = Location();
//   loc.LocationData? currentPosition;
//   LatLng curLocation = LatLng(-6.935127337338836, 107.62177380494678);
//   StreamSubscription<loc.LocationData>? locationSubscription;
//   Marker? sourcePosition, destinationPosition;

//   @override
//   void initState() {
//     super.initState();
//     getNavigation();
//     addMarker();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }

//   getNavigation() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;
//     final GoogleMapController? controller = await maps.future;
//     location.changeSettings(accuracy: loc.LocationAccuracy.high);

//     // ask for permission
//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       // showAlertDialog("Location services are disabled.");
//       // return Future.error('Location services are disabled.');
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }

//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted == PermissionStatus.granted) {
//         return;
//       }
//     }

//     // get current location
//     if (permissionGranted == loc.PermissionStatus.granted) {
//       currentPosition = await location.getLocation();
//       curLocation =
//           LatLng(currentPosition!.latitude!, currentPosition!.longitude!);
//       locationSubscription =
//           location.onLocationChanged.listen((LocationData currentLocation) {
//         controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//             target:
//                 LatLng(currentPosition!.latitude!, currentPosition!.longitude!),
//             zoom: 16)));

//         if (mounted) {
//           controller
//               ?.showMarkerInfoWindow(MarkerId(sourcePosition!.markerId.value));

//           setState(() {
//             curLocation =
//                 LatLng(currentLocation.latitude!, currentLocation.longitude!);
//             sourcePosition = Marker(
//                 markerId: MarkerId(currentLocation.toString()),
//                 icon: BitmapDescriptor.defaultMarkerWithHue(
//                     BitmapDescriptor.hueBlue),
//                 position: LatLng(
//                     currentLocation.latitude!, currentLocation.longitude!),
//                 infoWindow: InfoWindow(
//                     title: double.parse(
//                             getDistance(LatLng(widgets.lat, widgets.lng))
//                                 .toStringAsFixed(2))
//                         .toString()),
//                 onTap: () {
//                   print('marker tapped');
//                 });
//           });

//           getDirections(LatLng(widgets.lat, widgets.lng));
//         }
//       });
//     }
//     // start location listener
//     // add marker
//     // draw polyline
//     // show destination
//   }

//   getDirections(LatLng dst) async {
//     List<LatLng> polylineCoordinates = [];
//     List<dynamic> points = [];
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         '',
//         PointLatLng(curLocation.latitude, curLocation.longitude),
//         PointLatLng(dst.latitude, dst.longitude),
//         travelMode: TravelMode.driving);
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//         points.add({'lat': point.latitude, 'lng': point.longitude});
//       });
//     } else {
//       print(result.errorMessage);
//     }
//     addPolyLine(polylineCoordinates);
//   }

//   addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = PolylineId('poly');
//     Polyline polyline = Polyline(
//         polylineId: id,
//         color: Colors.red,
//         points: polylineCoordinates,
//         width: 3);
//     polylines[id] = polyline;
//     setState(() {});
//   }

//   double calculateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 -
//         c((lat2 - lat1) * p) / 2 +
//         c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }

//   double getDistance(LatLng destposition) {
//     return calculateDistance(curLocation.latitude, curLocation.longitude,
//         destposition.latitude, destposition.longitude);
//   }

//   addMarker() {
//     setState(() {
//       sourcePosition = Marker(
//           markerId: MarkerId('source'),
//           position: curLocation,
//           icon:
//               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure));
//     });
//     setState(() {
//       destinationPosition = Marker(
//           markerId: MarkerId('destination'),
//           position: LatLng(widgets.lat, widgets.lng),
//           icon:
//               BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan));
//     });
//   }
// }
