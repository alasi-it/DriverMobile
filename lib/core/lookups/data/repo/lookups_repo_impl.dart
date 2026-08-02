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
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/network/local/network_info.dart';
import 'package:isnad_worker/core/network/remote/apis/hanlders/repo_impl_callhandler.dart';

class LookupsRepoImpl implements LookupsRepo {
  final LookupsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LookupsRepoImpl({required this.remoteDataSource, required this.networkInfo});

  List<CountryModel>? _countriesCache;
  List<JobModel>? _jobTitlesCache;
  List<SkillModel>? _skillsCache;
  List<LanguageModel>? _languagesCache;
  List<PrivateServiceModel>? _privateServicesCache;

  @override
  Future<Either<Failure, List<CountryModel>>> getCountries() async {
    final cached = _countriesCache;
    if (cached != null && cached.isNotEmpty) {
      return Right(cached);
    }

    final result = await RepoImplCallHandler<List<CountryModel>>(networkInfo)(
      () async {
        return await remoteDataSource.getCountries();
      },
    );

    result.fold((_) {}, (data) => _countriesCache = data);
    return result;
  }

  @override
  Future<Either<Failure, List<JobModel>>> getJobTitles() async {
    final cached = _jobTitlesCache;
    if (cached != null && cached.isNotEmpty) {
      return Right(cached);
    }

    final result = await RepoImplCallHandler<List<JobModel>>(networkInfo)(
      () async {
        return await remoteDataSource.getJobTitles();
      },
    );

    result.fold((_) {}, (data) => _jobTitlesCache = data);
    return result;
  }

  @override
  Future<Either<Failure, List<SkillModel>>> getSkills() async {
    final cached = _skillsCache;
    if (cached != null && cached.isNotEmpty) {
      return Right(cached);
    }

    final result = await RepoImplCallHandler<List<SkillModel>>(networkInfo)(
      () async => await remoteDataSource.getSkills(),
    );

    result.fold((_) {}, (data) => _skillsCache = data);
    return result;
  }

  @override
  Future<Either<Failure, List<LanguageModel>>> getLanguages() async {
    final cached = _languagesCache;
    if (cached != null && cached.isNotEmpty) return Right(cached);

    final result = await RepoImplCallHandler<List<LanguageModel>>(networkInfo)(
      () async => await remoteDataSource.getLanguages(),
    );

    result.fold((_) {}, (data) => _languagesCache = data);
    return result;
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
  Future<Either<Failure, List<PrivateServiceModel>>>
  getPrivateServices() async {
    final cached = _privateServicesCache;
    if (cached != null && cached.isNotEmpty) {
      return Right(cached);
    }

    final result = await RepoImplCallHandler<List<PrivateServiceModel>>(
      networkInfo,
    )(() async => await remoteDataSource.getPrivateServices());

    result.fold((_) {}, (data) => _privateServicesCache = data);
    return result;
  }
}
