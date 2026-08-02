import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/lookups/data/models/private_service_model.dart';
import 'package:isnad_worker/core/lookups/domain/repo/lookups_repo.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/usecase/usecase.dart';

class GetPrivateServicesUseCase
    implements UseCase<List<PrivateServiceModel>, NoParams> {
  final LookupsRepo repository;

  GetPrivateServicesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<PrivateServiceModel>>> call(
    NoParams params,
  ) async {
    return await repository.getPrivateServices();
  }
}
