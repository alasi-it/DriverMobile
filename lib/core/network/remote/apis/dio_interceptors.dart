import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:isnad_worker/core/constant/app_config.dart';
import 'package:isnad_worker/core/network/local/cache/secure_storage.dart';

import '../../../utils/helper/app_locals.dart';
import '../../local/cache/cache_keys.dart';
import '../end_points.dart';

class AppInterceptors extends Interceptor {
  AppInterceptors(this.dio);

  final Dio dio;

  static Future<String?>? _ongoingRefresh;

  static bool _isRefreshRequest(RequestOptions options) {
    return options.uri.toString().contains('RefreshToken');
  }

  static Future<String?> _refreshAccessToken() async {
    if (_ongoingRefresh != null) {
      return _ongoingRefresh!;
    }
    _ongoingRefresh = _callRefreshEndpoint();
    try {
      return await _ongoingRefresh!;
    } finally {
      _ongoingRefresh = null;
    }
  }

  static Future<void> _clearAuthAndGoToLogin() async {
    final token = await SecureStorage.instance.read(CacheKeys.token);
    if (token != null) {
      await SecureStorage.instance.delete(CacheKeys.token);
      await SecureStorage.instance.delete(CacheKeys.refreshtoken);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // AppNavigator.remove(const LoginScreen());
      });
    }
  }

  static Future<String?> _callRefreshEndpoint() async {
    try {
      final refreshToken = await SecureStorage.instance.read(
        CacheKeys.refreshtoken,
      );
      if (refreshToken == null || refreshToken.isEmpty) {
        return null;
      }

      final refreshDio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 15),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Accept-Language': AppLocales.currentLocale.languageCode,
          },
        ),
      );

      final response = await refreshDio.post<dynamic>(
        REFRESH_TOKEN_URL,
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        return null;
      }

      final body = response.data;
      String? access;
      String? newRefresh;

      if (body is Map<String, dynamic>) {
        access = body['token'] as String? ?? body['accessToken'] as String?;
        newRefresh = body['refreshToken'] as String?;
      } else if (body is String && body.isNotEmpty) {
        access = body;
      }

      if (access == null || access.isEmpty) {
        return null;
      }

      await SecureStorage.instance.write(CacheKeys.token, access);
      if (newRefresh != null && newRefresh.isNotEmpty) {
        await SecureStorage.instance.write(CacheKeys.refreshtoken, newRefresh);
      }

      return access;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? token = await SecureStorage.instance.read(CacheKeys.token);
    // final tt =
    // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsImp0aSI6Ijk4MDUxYzI2LTEwZmMtNGQ0Ni1iNjAzLTEyZDM2NDMwNDg3MSIsImVtYWlsIjoiYWRtaW5AdGVuYW50LmxvY2FsIiwidW5pcXVlX25hbWUiOiJhZG1pbiIsIm5hbWVpZCI6Ijk4MDUxYzI2LTEwZmMtNGQ0Ni1iNjAzLTEyZDM2NDMwNDg3MSIsInVzcyI6IkNTVVZUT1RBRTJWN0c3MlBKSjY1V1BQSFdDM0hDS1hWIiwidGVuYW50X2lkIjoiZDkxNzJmNzEtOGJhMi00ZDAxLWI0YmUtZjdlNmQwYjg5ZTNhIiwicm9sZSI6IkFkbWluIiwibmJmIjoxNzc5Mjc1MzQxLCJleHAiOjE3ODE4NjczNDEsImlhdCI6MTc3OTI3NTM0MSwiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3QiLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdCJ9.4y5WV3hiFrXbno4CPSuVVEN2kzGeszjBhs0v_IJuzrk';
    options.headers.addAll({
      'Accept': 'application/json',
      'Accept-Language': AppLocales.currentLocale.languageCode,
      'X-Tenant-Id': AppConfig.xTenantId,

      if (token != null) 'Authorization': 'Bearer $token',
    });
    return handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.statusCode != 401) {
      return handler.next(response);
    }

    final options = response.requestOptions;
    if (_isRefreshRequest(options) || options.extra['__auth_retry'] == true) {
      await _clearAuthAndGoToLogin();
      return handler.next(response);
    }

    final newToken = await _refreshAccessToken();
    if (newToken == null) {
      await _clearAuthAndGoToLogin();
      return handler.next(response);
    }

    options.headers['Authorization'] = 'Bearer $newToken';
    options.extra['__auth_retry'] = true;

    try {
      final retried = await dio.fetch(options);
      return handler.resolve(retried);
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 401) {
        await _clearAuthAndGoToLogin();
      }
      if (e is DioException) {
        return handler.reject(e);
      }
      return handler.next(response);
    }
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final options = err.requestOptions;
    if (_isRefreshRequest(options) || options.extra['__auth_retry'] == true) {
      await _clearAuthAndGoToLogin();
      return handler.next(err);
    }

    final newToken = await _refreshAccessToken();
    if (newToken == null) {
      await _clearAuthAndGoToLogin();
      return handler.next(err);
    }

    options.headers['Authorization'] = 'Bearer $newToken';
    options.extra['__auth_retry'] = true;

    try {
      final retried = await dio.fetch(options);
      return handler.resolve(retried);
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 401) {
        await _clearAuthAndGoToLogin();
      }
      if (e is DioException) {
        return handler.next(e);
      }
      return handler.next(err);
    }
  }
}
