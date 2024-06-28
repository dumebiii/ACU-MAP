// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:math' as math;

import 'package:acumap/app/app.locator.dart';
import 'package:acumap/app/app.router.dart';
import 'package:acumap/utilities/api_handle/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:acumap/app/app.logger.dart';
import 'package:acumap/utilities/api_handle/map_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../common/app_colors.dart';

class MapViewModel extends BaseViewModel implements Initialisable {
  @override
  void initialise() {
    getLocationUpdates();

    destinationdetails();
    addSenderIcon();
    addRecIcon();
  }

  final _navigationService = locator<NavigationService>();

  final SharedDataService _sharedDataService = locator<SharedDataService>();

  final map = MappingService();
  final log = getLogger('MapViewModel');
  Completer<GoogleMapController> controller = Completer();
  LatLng? lattlngg;
  Location locationcontroller = Location();

  String get selectedPlaceName => _sharedDataService.selectedPlaceName;
  double get selectedPlaceLat => _sharedDataService.selectedPlaceLat;
  double get selectedPlaceLng => _sharedDataService.selectedPlaceLng;

  String? destinationName;
  LatLng? destination;

  LatLng schoolLocation = const LatLng(7.849858790844228, 3.9479412490584567);
  LatLng? currentposition;
  // LatLng? currentposition;
  double raduis = 390.0;

  Marker? selectedMarker;

  bool? ishybrid = false;
  final Set<Marker> markers = {};

  bool isMarkerOutside = false;
  bool selected = false;

  Set<Polyline> polylines = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  BitmapDescriptor startIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;

  final double offset = 0.5; // Adjust this value for desired area size

// Create LatLngBounds with southwest and northeast corners

  void toggleHybridView() {
    ishybrid = !ishybrid!;
    notifyListeners();
  }

  double radians(double degrees) {
    return degrees * math.pi / 180;
  }

  void navigateToSearchScreen() {
    _navigationService.navigateToSearchView();
  }

  void destinationdetails() {
    destination = LatLng(selectedPlaceLat, selectedPlaceLng);
    destinationName = selectedPlaceName;
  }

  Future getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData locationData;

    _serviceEnabled = await locationcontroller.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationcontroller.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await locationcontroller.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationcontroller.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await locationcontroller.getLocation();

    locationcontroller.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        currentposition =
            // const LatLng(7.847506353496916, 3.947253469700116);
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
        notifyListeners();
        print('olayyyy    $currentposition');
      }
    });
  }

  void checkMarkerPosition(LatLng position) {
    final distance = calculateDistance(position, schoolLocation);
    isMarkerOutside = distance > raduis;
    notifyListeners();

    print(raduis);
    print(distance);
    print(isMarkerOutside.toString());

    // Update UI based on _isMarkerOutside (optional)
    // You can call a separate function to display the warning message here
  }

  double calculateDistance(LatLng latLng1, LatLng latLng2) {
    // Implement the Haversine formula or another distance calculation method here
    // You can find implementations online
    // Replace this with your actual distance calculation logic
    // For example, using Haversine formula:
    // https://en.wikipedia.org/wiki/Haversine_formula
    final double dLat = radians(latLng2.latitude - latLng1.latitude);
    final double dLon = radians(latLng2.longitude - latLng1.longitude);
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(radians(latLng1.latitude)) *
            math.cos(radians(latLng2.latitude)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    const radiusEarth = 6371;
    // Earth's radius in kilometers (adjust if needed)

    print(c * radiusEarth * 1000);
    return c * radiusEarth * 1000;
  }

  void addMarker(LatLng position, String title) {
    markers.add(
      Marker(
        markerId: MarkerId(title),
        position: position,
        infoWindow: InfoWindow(
          title: title,
        ),
        onTap: () {
          // Handle marker tap here
          print('Marker $title tapped!');
        },
      ),
    );
  }

  void addSenderIcon() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(24, 24)),
      "assets/images/rec.png",
    ).then(
      (icon) {
        startIcon = icon;
        notifyListeners();
      },
    );
  }

  void addRecIcon() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(24, 24)),
      "assets/images/arr.png",
    ).then(
      (icon) {
        destinationIcon = icon;
        notifyListeners();
      },
    );
  }

  void setPolylines() async {
    PolylinePoints polylinePoints = PolylinePoints();
    print('omoooooooooo $currentposition');

    print(currentposition);
    print('okay $destination');

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyDdfXG9xg1eN3a8RWkP8o6kBSPt-78uKsU",
        PointLatLng(currentposition!.latitude, currentposition!.longitude),
        PointLatLng(selectedPlaceLat, selectedPlaceLng),
        travelMode: TravelMode.walking,
        avoidHighways: true,
        avoidTolls: true,
        optimizeWaypoints: true);

    if (result.status == 'OK') {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      polylines.add(Polyline(
          width: 4,
          polylineId: const PolylineId('polyLine'),
          color: kblue,
          points: polylineCoordinates));
      notifyListeners();
    }
  }

  double calculateTravelTime() {
    final distance = Geolocator.distanceBetween(
        currentposition!.latitude,
        currentposition!.longitude,
        destination!.latitude,
        destination!.longitude);
    final timeInSec = distance / 1.4;
    final timeInMinutes = timeInSec / 60;
    return timeInMinutes;
  }

  double estimateTravelTime(LatLng start, LatLng end) {
    double distance = calculateDistance(start, end);
    double travelTime = distance / 5;
    // switch (travelMode) {
    //   case 'driving':
    //     travelTime = distance / 60; // Assuming average speed of 60 km/h
    //     break;
    //   case 'walking':
    //     travelTime = distance / 5; // Assuming average speed of 5 km/h
    //     break;
    //   case 'cycling':
    //     travelTime = distance / 15; // Assuming average speed of 15 km/h
    //     break;
    //   default:
    //     travelTime = 0.0; // Handle unknown travel modes

    return travelTime; // Travel time in hours
  }
}
