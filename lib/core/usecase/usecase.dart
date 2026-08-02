import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';

abstract class UseCase<type, Params> {
  Future<Either<Failure, type>> call(Params params);
}

class NoParams {}
