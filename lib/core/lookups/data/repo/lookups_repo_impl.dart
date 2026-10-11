import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/lookups/data/data_source/lookups_remote_data_source.dart';
import 'package:isnad_worker/core/lookups/data/models/city_model.dart';
import 'package:isnad_worker/core/lookups/data/models/country_model.dart';
import 'package:isnad_worker/core/lookups/data/models/job_model.dart';
import 'package:isnad_worker/core/lookups/data/models/language_model.dart';
import 'package:isnad_worker/core/lookups/data/models/private_service_model.dart';
import 'package:isnad_worker/core/lookups/data/models/skill_model.dart';
import 'package:isnad_worker/core/lookups/domain/repo/lookups_repo.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/get_cities_use_case.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/get_countries_use_case.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/get_job_titles_use_case.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/get_languages_use_case.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/get_private_services_use_case.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/get_skills_use_case.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/network/local/network_info.dart';
import 'package:isnad_worker/core/network/remote/apis/hanlders/repo_impl_callhandler.dart';

class LookupsRepoImpl implements LookupsRepo {
  final LookupsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LookupsRepoImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<CountryModel>>> getCountries(
    GetCountriesUseCaseParams params,
  ) async {
    return await RepoImplCallHandler<List<CountryModel>>(networkInfo)(
      () async => await remoteDataSource.getCountries(params),
    );
  }

  @override
  Future<Either<Failure, List<JobModel>>> getJobTitles(
    GetJobTitlesUseCaseParams params,
  ) async {
    return await RepoImplCallHandler<List<JobModel>>(networkInfo)(
      () async => await remoteDataSource.getJobTitles(params),
    );
  }

  @override
  Future<Either<Failure, List<SkillModel>>> getSkills(
    GetSkillsUseCaseParams params,
  ) async {
    return await RepoImplCallHandler<List<SkillModel>>(networkInfo)(
      () async => await remoteDataSource.getSkills(params),
    );
  }

  @override
  Future<Either<Failure, List<LanguageModel>>> getLanguages(
    GetLanguagesUseCaseParams params,
  ) async {
    return await RepoImplCallHandler<List<LanguageModel>>(networkInfo)(
      () async => await remoteDataSource.getLanguages(params),
    );
  }

  @override
  Future<Either<Failure, List<CityModel>>> getCities(
    GetCitiesUseCaseParams params,
  ) async {
    return await RepoImplCallHandler<List<CityModel>>(networkInfo)(() async {
      return await remoteDataSource.getCities(params);
    });
  }

  @override
  Future<Either<Failure, List<PrivateServiceModel>>> getPrivateServices(
    GetPrivateServicesUseCaseParams params,
  ) async {
    return await RepoImplCallHandler<List<PrivateServiceModel>>(networkInfo)(
      () async => await remoteDataSource.getPrivateServices(params),
    );
  }
}
