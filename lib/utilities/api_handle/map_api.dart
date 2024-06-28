import 'package:acumap/app/app.logger.dart';
import 'package:acumap/model/api_response.dart';
import 'package:acumap/model/search.dart';
import 'package:acumap/ui/common/app_strings.dart';
import 'package:acumap/utilities/api_handle/api.dart';
import 'package:acumap/utilities/api_handle/dio_interceptor.dart';
import 'package:acumap/utilities/api_handle/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

class MappingService implements Mapping {
  final log = getLogger('MappingService');
  final dio = Dio();
  final _apiService = DioInterceptor();
  final mapUurl = mapUrl;
  String baseurl =
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=7.849858790844228,3.9479412490584567&key=AIzaSyDdfXG9xg1eN3a8RWkP8o6kBSPt-78uKsU";

  final postHeader = {
    'Content-Type': 'application/json',
    'cookie': 'session_id=ufe1nfq69mdi67pnql6n1cs3cv; path=/; HttpOnly=',
    'Access-Control-Allow-Credentials': 'true'
  };

  @override
  Future<ApiResponse> getPlace(LatLng latLng) async {
    const mapUurl = mapUrl;
    String getPlace =
        "$mapUurl/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=AIzaSyDdfXG9xg1eN3a8RWkP8o6kBSPt-78uKsU";

    var api = _apiService.api;
    try {
      Response res = await api.get(
        getPlace,
        options: Options(headers: postHeader),
      );
      log.i(res);
      log.i(res.data['message']);
      return ApiResponse(
          success: res.data['success'],
          data: res,
          message: res.data['message']);
    } on DioException catch (e) {
      return AppException.handleError(e);
    }
  }

  @override
  Future<ApiResponse<List<Results>>?> search(
      LatLng latLng, String query, int raduis) async {
    // const mapUurl = mapUrl;
    String search =
        // "https://maps.googleapis.com/maps/api/place/textsearch/json?location=7.849858790844228,3.9479412490584567&query=Ajayi&radius=390&key=AIzaSyDdfXG9xg1eN3a8RWkP8o6kBSPt-78uKsU";
        "$mapUurl/maps/api/place/textsearch/json?location=${latLng.latitude},${latLng.longitude}&query=Ajayi Crowther$query&radius=$raduis&key=AIzaSyDdfXG9xg1eN3a8RWkP8o6kBSPt-78uKsU";

    // "$mapUurl/maps/api/place/textsearch/json?latlng=${latLng.latitude},${latLng.longitude}&key=AIzaSyDdfXG9xg1eN3a8RWkP8o6kBSPt-78uKsU";

    print(search);
    var api = _apiService.api;
    try {
      Response res = await api.get(
        search,
      );

      List<Results> parsedResults = [];

      for (var locationData in res.data["results"]) {
        // Parse each location object using Results.fromJson
        Results parsedResult = Results.fromJson(locationData);
        parsedResults.add(parsedResult);
      }

      log.i(res);
      log.i(res.data["results"]);
      return ApiResponse(
          success: res.data['success'],
          data: parsedResults, //
          message: res.data['message']);
    } on DioException catch (e) {
      return null;
    }
  }
}
