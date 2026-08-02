import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/lookups/data/models/city_model.dart';
import 'package:isnad_worker/core/lookups/data/models/country_model.dart';
import 'package:isnad_worker/core/lookups/data/models/job_model.dart';
import 'package:isnad_worker/core/lookups/data/models/language_model.dart';
import 'package:isnad_worker/core/lookups/data/models/private_service_model.dart';
import 'package:isnad_worker/core/lookups/data/models/skill_model.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/get_cities_use_case.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';

abstract class LookupsRepo {
  Future<Either<Failure, List<CountryModel>>> getCountries();
  Future<Either<Failure, List<CityModel>>> getCities(
    GetCitiesUseCaseParams params,
  );
  Future<Either<Failure, List<JobModel>>> getJobTitles();
  Future<Either<Failure, List<SkillModel>>> getSkills();
  Future<Either<Failure, List<LanguageModel>>> getLanguages();
  Future<Either<Failure, List<PrivateServiceModel>>> getPrivateServices();
}
