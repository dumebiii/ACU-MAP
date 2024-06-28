class ApiResponse<T> {
  final T? data;
  final bool? success;
  final String? message;

  const ApiResponse({
    this.data,
    this.success,
    this.message,
  }) : super();

  factory ApiResponse.fromMap(Map<String, dynamic> json) {
    return ApiResponse(
      data: null,
      success: json['success'] ?? false,
      message: json['message'] ?? 'An Error occured',
    );
  }
}
