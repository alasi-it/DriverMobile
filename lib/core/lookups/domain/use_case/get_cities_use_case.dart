import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/lookups/data/models/city_model.dart';
import 'package:isnad_worker/core/lookups/domain/repo/lookups_repo.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/lookup_query_params.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/usecase/usecase.dart';

class GetCitiesUseCase
    implements UseCase<List<CityModel>, GetCitiesUseCaseParams> {
  final LookupsRepo repository;

  GetCitiesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<CityModel>>> call(
    GetCitiesUseCaseParams params,
  ) async {
    return await repository.getCities(params);
  }
}

class GetCitiesUseCaseParams {
  final String? countryId;
  final LookupQueryParams query;

  GetCitiesUseCaseParams({
    required this.countryId,
    this.query = const LookupQueryParams(),
  });

  Map<String, dynamic> toMap() {
    return {
      if (countryId != null) "countryId": countryId,
      'IsActive': 'true',
      ...query.toMap(),
    };
  }
}
