import 'package:isnad_worker/core/lookups/data/models/city_model.dart';
import 'package:isnad_worker/core/lookups/data/models/country_model.dart';
import 'package:isnad_worker/core/lookups/data/models/job_model.dart';
import 'package:isnad_worker/core/lookups/data/models/language_model.dart';
import 'package:isnad_worker/core/lookups/data/models/private_service_model.dart';
import 'package:isnad_worker/core/lookups/data/models/skill_model.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/get_cities_use_case.dart';
import 'package:isnad_worker/core/network/errors/exception.dart';
import 'package:isnad_worker/core/network/remote/apis/dio_helper.dart';
import 'package:isnad_worker/core/network/remote/apis/hanlders/remote_data_source_handler.dart';
import 'package:isnad_worker/core/network/remote/end_points.dart';

abstract class LookupsRemoteDataSource {
  Future<List<CountryModel>> getCountries();
  Future<List<CityModel>> getCities(GetCitiesUseCaseParams params);
  Future<List<JobModel>> getJobTitles();
  Future<List<SkillModel>> getSkills();
  Future<List<LanguageModel>> getLanguages();
  Future<List<PrivateServiceModel>> getPrivateServices();
}

class LookupsRemoteDataSourceImpl implements LookupsRemoteDataSource {
  final DioHelper networkManager;

  LookupsRemoteDataSourceImpl({required this.networkManager});

  @override
  Future<List<CountryModel>> getCountries() async {
    final data = await RemoteDataSourceCallHandler().call<List<CountryModel>>(
      () => networkManager.get(url: COUNTRIES_URL, query: {'IsActive': 'true'}),
      (json) =>
          List<CountryModel>.from(json.map((x) => CountryModel.fromJson(x))),
    );

    return data.data ?? (throw ServerException('Empty response'));
  }

  @override
  Future<List<CityModel>> getCities(GetCitiesUseCaseParams params) async {
    final Map<String, dynamic> query = params.toMap();

    final data = await RemoteDataSourceCallHandler().call<List<CityModel>>(
      () => networkManager.get(url: CITIES_URL, query: query),
      (json) => List<CityModel>.from(json.map((x) => CityModel.fromJson(x))),
    );

    return data.data ?? (throw ServerException('Empty response'));
  }

  @override
  Future<List<JobModel>> getJobTitles() async {
    final data = await RemoteDataSourceCallHandler().call<List<JobModel>>(
      () => networkManager.get(url: JOBS_URL, query: {'IsActive': 'true'}),
      (json) => List<JobModel>.from(json.map((x) => JobModel.fromJson(x))),
    );

    return data.data ?? (throw ServerException('Empty response'));
  }

  @override
  Future<List<SkillModel>> getSkills() async {
    final data = await RemoteDataSourceCallHandler().call<List<SkillModel>>(
      () => networkManager.get(url: SKILLS_URL, query: {'IsActive': 'true'}),
      (json) => List<SkillModel>.from(json.map((x) => SkillModel.fromJson(x))),
    );

    return data.data ?? (throw ServerException('Empty response'));
  }

  @override
  Future<List<LanguageModel>> getLanguages() async {
    final data = await RemoteDataSourceCallHandler().call<List<LanguageModel>>(
      () => networkManager.get(url: LANGUAGES_URL),
      (json) =>
          List<LanguageModel>.from(json.map((x) => LanguageModel.fromJson(x))),
    );

    return data.data ?? (throw ServerException('Empty response'));
  }

  @override
  Future<List<PrivateServiceModel>> getPrivateServices() async {
    final data = await RemoteDataSourceCallHandler()
        .call<List<PrivateServiceModel>>(
          () => networkManager.get(
            url: PRIVATE_SERVICES_URL,
            query: {
              'ServiceType': 'recruitmentClient',
              'IsAvailableForPrivate': 'true',
            },
          ),
          (json) => List<PrivateServiceModel>.from(
            json.map((x) => PrivateServiceModel.fromJson(x)),
          ),
        );

    return data.data ?? (throw ServerException('Empty response'));
  }
}
