import 'package:dio/dio.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';

class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'No valid cache found']);
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class DataParsingException implements Exception {
  final String message;
  DataParsingException(this.message);
}

class ServerException implements Exception {
  final String message;

  ServerException(this.message);

  factory ServerException.fromResponse(Response response) {
    return ServerException(ServerFailure.fromResponse(response).errMessage);
  }

  factory ServerException.fromDioError(DioException e) {
    return ServerException(ServerFailure.fromDioError(e).errMessage);
  }

  @override
  String toString() => message;
}
