import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:isnad_worker/core/network/errors/exception.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/network/local/network_info.dart';

class RepoImplCallHandler<T> {
  final NetworkInfo networkInfo;

  RepoImplCallHandler(this.networkInfo);

  Future<Either<Failure, T>> call(Future<T> Function() datasourceCall) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      final result = await datasourceCall();
      return Right(result);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on DataParsingException catch (e) {
      return Left(DataParsingFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } on SocketException {
      return Left(NetworkFailure());
    } on FormatException {
      return Left(DataParsingFailure('failure.data_parsing_error'.tr()));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
