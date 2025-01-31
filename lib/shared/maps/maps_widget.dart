// import 'dart:async';
// import 'dart:math' as math;

// import 'package:app_management_system/config/app_config.dart';
// import 'package:app_management_system/shared/custom_alert/alert_dialog_custom.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapsWidget extends HookWidget {
//   final List<dynamic> route;
//   const MapsWidget({Key? key, required this.route}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Completer<GoogleMapController> maps = Completer();
//     CameraPosition? currentPosition;
//     Set<Polyline> polylines = {};
//     Set<Marker> markers = {};

//     void showAlertDialog(msg) {
//       showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialogCustom(
//               title: 'Mohon maaf',
//               message: msg ?? "",
//               isShowCancel: false,
//               onSubmitClick: () => Navigator.of(context).pop(),
//             );
//           });
//     }

//     Future<Polyline> getRoutePolyline(
//         {required LatLng start,
//         required LatLng finish,
//         required Color color,
//         required String id,
//         int width = 4}) async {
//       final polylinePoints = PolylinePoints();
//       final List<LatLng> polylineCoordinates = [];

//       final startPoint = PointLatLng(start.latitude, start.longitude);
//       final finishPoint = PointLatLng(finish.latitude, finish.longitude);

//       final result = await polylinePoints.getRouteBetweenCoordinates(
//         AppConfig.mapKey,
//         startPoint,
//         finishPoint,
//       );
//       if (result.points.isNotEmpty) {
//         // loop through all PointLatLng points and convert them
//         // to a list of LatLng, required by the Polyline
//         for (var point in result.points) {
//           polylineCoordinates.add(
//             LatLng(point.latitude, point.longitude),
//           );
//         }
//       }
//       final polyline = Polyline(
//         polylineId: PolylineId(id),
//         color: color,
//         points: polylineCoordinates,
//         width: width,
//       );
//       return polyline;
//     }

//     Future<Set<Polyline>> getAllPolylines() async {
//       Set<Polyline> polyline = {};

//       for (var i = 0; i < route.length - 1; i++) {
//         final marker = Marker(
//           markerId: MarkerId('marker_$i'),
//           infoWindow:
//               InfoWindow(title: route[i].name, snippet: route[i].fullAddress),
//           position: LatLng(double.parse(route[i].latitude),
//               double.parse(route[i].longitude)),
//         );
//         markers.add(marker);

//         var start = LatLng(
//             double.parse(route[i].latitude), double.parse(route[i].longitude));
//         var finish = LatLng(double.parse(route[i + 1].latitude),
//             double.parse(route[i + 1].longitude));
//         final line = await getRoutePolyline(
//           start: start,
//           finish: finish,
//           color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
//               .withOpacity(1.0),
//           id: 'polyline_$i',
//         );
//         polyline.add(line);
//       }

//       return polyline;
//     }

//     Future _getCurrentLocation() async {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         showAlertDialog("Location services are disabled.");
//         return Future.error('Location services are disabled.');
//       }

//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           showAlertDialog("Location permissions are denied");
//           return Future.error('Location permissions are denied');
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         showAlertDialog(
//             "Location permissions are permanently denied, we cannot request permissions.");
//         return Future.error(
//             'Location permissions are permanently denied, we cannot request permissions.');
//       }

//       polylines = await getAllPolylines();
//       markers.add(Marker(
//           markerId: const MarkerId('driver_location'),
//           // icon: currentLocationIcon,
//           position: LatLng(currentPosition?.target.latitude ?? 0,
//               currentPosition?.target.longitude ?? 0)));
//     }

//     return SizedBox(
//       height: MediaQuery.of(context).size.height - 80,
//       width: MediaQuery.of(context).size.width,
//       child: currentPosition == null
//           ? const Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               mapType: MapType.normal,
//               initialCameraPosition: currentPosition!,
//               polylines: polylines,
//               markers: markers,
//               onMapCreated: (GoogleMapController controller) {
//                 maps.complete(controller);
//               },
//             ),
//     );
//   }
// }
