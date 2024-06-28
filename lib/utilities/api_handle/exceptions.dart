import 'package:acumap/model/api_response.dart';
import 'package:dio/dio.dart';

class AppException implements Exception {
  static ApiResponse handleError<T>(
    DioException e, {
    T? data,
  }) {
    // debugLog(e);
    if (e.response != null && DioExceptionType.badResponse == e.type) {
      if (e.response!.statusCode! >= 500) {
        return const ApiResponse(
          success: false,
          message: 'a server error occured',
        );
      }
      if (e.response?.data is Map<String, dynamic>) {
        // debugLog(ApiResponse().fromMap(e.response?.data).error);
        return ApiResponse(data: e.response?.data);
      } else if (e.response?.data is String) {
        // debugLog(e.response?.data);
        return ApiResponse(
          success: false,
          message: e.response?.data,
        );
      }
    }
    return ApiResponse(
      success: false,
      data: data,
      message: _mapException(e.type),
    );
  }

  static String _mapException(DioExceptionType? error) {
    if (DioExceptionType.connectionTimeout == error ||
        DioExceptionType.receiveTimeout == error ||
        DioExceptionType.sendTimeout == error) {
      return 'Your request timed out';
    } else if (DioExceptionType.unknown == error) {
      return 'an internet connection error occured';
    }
    return "An error occurred";
  }
}
