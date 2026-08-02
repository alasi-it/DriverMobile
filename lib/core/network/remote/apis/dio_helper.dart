import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:isnad_worker/core/constant/app_config.dart';
import 'package:isnad_worker/core/network/remote/apis/logging_interc.dart';

import '../end_points.dart';
import 'dio_interceptors.dart';

class DioHelper {
  static Dio? dio;

  static Future<void> init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: BASE_URL,
        followRedirects: false,
        receiveDataWhenStatusError: true,
        validateStatus: (status) => status! < 500,
        connectTimeout: const Duration(seconds: 10),

        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
      ),
    );

    /// DIO [HEADERS]
    dio!.options.headers = {'Content-Type': 'application/json'};

    dio?.interceptors.addAll([
      AppInterceptors(dio!),
      if (AppConfig.enableLogging) const LoggingInterceptor(),
    ]);
  }

  /// METHOD [POST] DATA FROM API
  Future<Response> post({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    dynamic data,
    ProgressCallback? onSendProgress,
  }) async {
    final isFormData = data is FormData;
    dio!.options.headers =
        headers ?? (isFormData ? {} : {'Content-Type': 'application/json'});
    print("Debug mode: $kDebugMode");
    return await dio!.post(
      url,
      data: data,
      queryParameters: query,
      onSendProgress: onSendProgress,
    );
  }

  /// METHOD [GET] DATA FROM API
  Future<Response> get({
    required String url,
    Map<String, dynamic>? query,
    data,
  }) async {
    return await dio!.get(url, queryParameters: query, data: data);
  }

  /// METHOD [DELETE] DATA FROM API
  Future<Response> delete({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    dynamic data,
  }) async {
    dio!.options.headers = headers ?? {'Content-Type': 'application/json'};
    return await dio!.delete(url, data: data, queryParameters: query);
  }

  /// METHOD [PATCH] UPDATE DATA ON API
  Future<Response> patch({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    dynamic data,
  }) async {
    dio!.options.headers = headers ?? {'Content-Type': 'application/json'};
    return await dio!.patch(url, data: data, queryParameters: query);
  }

  /// METHOD [PUT] UPDATE DATA ON API
  Future<Response> put({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    return await dio!.put(url, data: data, queryParameters: query);
  }

  /// METHOD [DOWNLOAD] FILE FROM API
  Future<void> download({
    required String url,
    required String savePath,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    ProgressCallback? onReceiveProgress,
  }) async {
    dio!.options.headers = headers ?? {'Content-Type': 'application/json'};
    await dio!.download(
      url,
      savePath,
      queryParameters: query,
      onReceiveProgress: onReceiveProgress,
    );
  }
}
