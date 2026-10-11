import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/lookups/data/models/private_service_model.dart';
import 'package:isnad_worker/core/lookups/domain/repo/lookups_repo.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/lookup_query_params.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/usecase/usecase.dart';

class GetPrivateServicesUseCase
    implements
        UseCase<List<PrivateServiceModel>, GetPrivateServicesUseCaseParams> {
  final LookupsRepo repository;

  GetPrivateServicesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<PrivateServiceModel>>> call(
    GetPrivateServicesUseCaseParams params,
  ) async {
    return await repository.getPrivateServices(params);
  }
}

class GetPrivateServicesUseCaseParams {
  final LookupQueryParams query;

  const GetPrivateServicesUseCaseParams({
    this.query = const LookupQueryParams(),
  });

  Map<String, dynamic> toMap() => {
    'ServiceType': 'recruitmentClient',
    'IsAvailableForPrivate': 'true',
    ...query.toMap(),
  };
}
