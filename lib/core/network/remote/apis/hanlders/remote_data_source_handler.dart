import 'package:dio/dio.dart';
import 'package:isnad_worker/core/network/errors/exception.dart';
import 'package:isnad_worker/core/network/remote/apis/hanlders/models/base_api_response_model.dart';

class RemoteDataSourceCallHandler {
  RemoteDataSourceCallHandler();

  Future<BaseApiResponseModel<T>> call<T>(
    Future<Response> Function() request,
    T Function(dynamic json) parser,
  ) async {
    try {
      final response = await request();

      if (!_isSuccessStatusCode(response.statusCode)) {
        throw ServerException.fromResponse(response);
      }

      final base = BaseApiResponseModel<T>.fromMap(response.data, parser);

      if (!base.isSuccess) {
        throw ServerException(base.errors.join(','));
      }

      //  if (!base.isSuccess) {
      //   final msg = base.errors.isNotEmpty
      //       ? base.errors.join(', ')
      //       : (base.errorCode != null && base.errorCode != 'none'
      //           ? base.errorCode!
      //           : null);
      //   throw ServerException(msg ?? 'Server error');
      // }

      return base;
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  bool _isSuccessStatusCode(int? statusCode) {
    return statusCode == 200 || statusCode == 201 || statusCode == 204;
  }
}
