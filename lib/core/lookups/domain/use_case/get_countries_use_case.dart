import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/lookups/data/models/country_model.dart';
import 'package:isnad_worker/core/lookups/domain/repo/lookups_repo.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/lookup_query_params.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/usecase/usecase.dart';

class GetCountriesUseCase
    implements UseCase<List<CountryModel>, GetCountriesUseCaseParams> {
  final LookupsRepo repository;

  GetCountriesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<CountryModel>>> call(
    GetCountriesUseCaseParams params,
  ) async {
    return await repository.getCountries(params);
  }
}

class GetCountriesUseCaseParams {
  final LookupQueryParams query;

  const GetCountriesUseCaseParams({this.query = const LookupQueryParams()});

  Map<String, dynamic> toMap() => {'IsActive': 'true', ...query.toMap()};
}
