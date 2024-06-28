import 'package:acumap/model/api_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class Auth {}

abstract class Mapping {
  Future<ApiResponse> getPlace(LatLng latLng);
  Future search(LatLng latLng, String query, int raduis);
}
