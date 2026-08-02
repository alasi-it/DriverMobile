import 'dart:convert';

class BaseApiResponseModel<T> {
  final bool isSuccess;
  final String? errorCode;
  final List<String> errors;
  final String? traceId;
  final T? data;

  BaseApiResponseModel({
    required this.isSuccess,
    this.errorCode,
    this.errors = const [],
    this.traceId,
    this.data,
  });

  factory BaseApiResponseModel.fromJson(
    String source,
    T Function(dynamic json)? fromJsonT,
  ) {
    final decoded = jsonDecode(source);
    return BaseApiResponseModel.fromMap(decoded, fromJsonT);
  }

  factory BaseApiResponseModel.fromMap(
    Map<String, dynamic> json,
    T Function(dynamic json)? fromJsonT,
  ) {
    return BaseApiResponseModel<T>(
      isSuccess: json['isSuccess'] ?? false,
      errorCode: json['errorCode'],
      errors: List<String>.from(json['errors'] ?? []),
      traceId: json['traceId'],
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'],
    );
  }

  bool get hasErrors => !isSuccess || errors.isNotEmpty;
}
