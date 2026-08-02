import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:isnad_worker/core/lookups/data/models/city_model.dart';
import 'package:isnad_worker/core/lookups/data/models/country_model.dart';
import 'package:isnad_worker/core/lookups/data/models/job_model.dart';
import 'package:isnad_worker/core/lookups/data/models/language_model.dart';
import 'package:isnad_worker/core/lookups/data/models/private_service_model.dart';
import 'package:isnad_worker/core/lookups/data/models/skill_model.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/get_cities_use_case.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/get_countries_use_case.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/get_job_titles_use_case.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/get_languages_use_case.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/get_private_services_use_case.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/get_skills_use_case.dart';
import 'package:isnad_worker/core/usecase/usecase.dart';
import 'package:isnad_worker/core/utils/service_locator/service_locator.dart';
import 'package:meta/meta.dart';

part 'lookups_state.dart';

class LookupsCubit extends Cubit<LookupsState> {
  LookupsCubit() : super(LookupsInitial());

  List<CountryModel> countries = [];
  List<JobModel> jobs = [];
  List<CityModel> cities = [];
  List<SkillModel> skills = [];
  List<LanguageModel> languages = [];
  List<PrivateServiceModel> privateServices = [];
  String? _cachedCountryId;

  Future<void> loadAll({bool forceRefresh = false}) async {
    await Future.wait([
      getCountries(forceRefresh: forceRefresh),
      getJobs(forceRefresh: forceRefresh),
      getCities(forceRefresh: forceRefresh),
      getSkills(forceRefresh: forceRefresh),
      getLanguages(forceRefresh: forceRefresh),
      getPrivateServices(forceRefresh: forceRefresh),
    ]);
  }

  Future<void> getCountries({bool forceRefresh = false}) async {
    if (countries.isNotEmpty && !forceRefresh) {
      emit(GetCountriesSuccessState(countries));
      return;
    }

    emit(GetCountriesLoadingState());
    final result = await sl<GetCountriesUseCase>()(NoParams());

    result.fold((error) => emit(GetCountriesFailureState(error.errMessage)), (
      model,
    ) {
      countries = model;
      emit(GetCountriesSuccessState(model));
    });
  }

  Future<void> getJobs({bool forceRefresh = false}) async {
    if (jobs.isNotEmpty && !forceRefresh) {
      emit(GetJobsSuccessState(jobs));
      return;
    }

    emit(GetJobsLoadingState());
    final result = await sl<GetJobTitlesUseCase>()(NoParams());

    result.fold((error) => emit(GetJobsFailureState(error.errMessage)), (
      model,
    ) {
      jobs = model;
      emit(GetJobsSuccessState(model));
    });
  }

  Future<void> getSkills({bool forceRefresh = false}) async {
    if (skills.isNotEmpty && !forceRefresh) {
      emit(GetSkillsSuccessState(skills));
      return;
    }

    emit(GetSkillsLoadingState());
    final result = await sl<GetSkillsUseCase>()(NoParams());

    result.fold((error) => emit(GetSkillsFailureState(error.errMessage)), (
      model,
    ) {
      skills = model;
      emit(GetSkillsSuccessState(model));
    });
  }

  Future<void> getLanguages({bool forceRefresh = false}) async {
    if (languages.isNotEmpty && !forceRefresh) {
      emit(GetLanguagesSuccessState(languages));
      return;
    }

    emit(GetLanguagesLoadingState());
    final result = await sl<GetLanguagesUseCase>()(NoParams());

    result.fold((error) => emit(GetLanguagesFailureState(error.errMessage)), (
      model,
    ) {
      languages = model;
      emit(GetLanguagesSuccessState(model));
    });
  }

  Future<void> getPrivateServices({bool forceRefresh = false}) async {
    if (privateServices.isNotEmpty && !forceRefresh) {
      emit(GetPrivateServicesSuccessState(privateServices));
      return;
    }

    emit(GetPrivateServicesLoadingState());
    final result = await sl<GetPrivateServicesUseCase>()(NoParams());

    result.fold(
      (error) => emit(GetPrivateServicesFailureState(error.errMessage)),
      (model) {
        privateServices = model;
        emit(GetPrivateServicesSuccessState(model));
      },
    );
  }

  bool hasCitiesFor(String? countryId) =>
      cities.isNotEmpty && _cachedCountryId == countryId;

  Future<void> getCities({String? countryId, bool forceRefresh = false}) async {
    if (cities.isNotEmpty && !forceRefresh && _cachedCountryId == countryId) {
      emit(GetCitiesSuccessState(cities));
      return;
    }
    emit(GetCitiesLoadingState());
    final result = await sl<GetCitiesUseCase>()(
      GetCitiesUseCaseParams(countryId: countryId),
    );

    result.fold((error) => emit(GetCitiesFailureState(error.errMessage)), (
      model,
    ) {
      cities = model;
      _cachedCountryId = countryId;
      emit(GetCitiesSuccessState(model));
    });
  }
}
