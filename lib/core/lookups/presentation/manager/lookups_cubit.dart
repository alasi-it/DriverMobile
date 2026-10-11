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
import 'package:isnad_worker/core/lookups/domain/use_case/lookup_query_params.dart';
import 'package:isnad_worker/core/utils/service_locator/service_locator.dart';

class _LookupPage<T> {
  final List<T> items = [];
  bool hasMore = true;
  bool isLoading = false;
}

class LookupsCubit {
  final Map<String, _LookupPage<CountryModel>> _countriesPages = {};
  final Map<String, _LookupPage<CityModel>> _citiesPages = {};
  final Map<String, _LookupPage<JobModel>> _jobsPages = {};
  final Map<String, _LookupPage<SkillModel>> _skillsPages = {};
  final Map<String, _LookupPage<LanguageModel>> _languagesPages = {};
  final Map<String, _LookupPage<PrivateServiceModel>> _privateServicesPages =
      {};

  void clearAll() {
    _countriesPages.clear();
    _citiesPages.clear();
    _jobsPages.clear();
    _skillsPages.clear();
    _languagesPages.clear();
    _privateServicesPages.clear();
  }

  Future<List<T>> _loadPaginated<T>({
    required Map<String, _LookupPage<T>> pages,
    required String key,
    required bool loadMore,
    required bool forceRefresh,
    required int pageSize,
    required Future<List<T>> Function(int skipCount) fetch,
  }) async {
    final page = forceRefresh
        ? (pages[key] = _LookupPage<T>())
        : pages.putIfAbsent(key, () => _LookupPage<T>());

    if (page.isLoading) return List<T>.from(page.items);
    if (!loadMore && page.items.isNotEmpty) return List<T>.from(page.items);
    if (loadMore && !page.hasMore) return List<T>.from(page.items);

    page.isLoading = true;
    try {
      final result = await fetch(page.items.length);
      page.items.addAll(result);
      page.hasMore = result.length >= pageSize;
      return List<T>.from(page.items);
    } finally {
      page.isLoading = false;
    }
  }

  bool hasMoreCountries({String filterText = ''}) =>
      _countriesPages[filterText]?.hasMore ?? true;

  bool hasMoreJobTitles({String filterText = ''}) =>
      _jobsPages[filterText]?.hasMore ?? true;

  bool hasMoreSkills({String filterText = ''}) =>
      _skillsPages[filterText]?.hasMore ?? true;

  bool hasMoreLanguages({String filterText = ''}) =>
      _languagesPages[filterText]?.hasMore ?? true;

  bool hasMorePrivateServices({String filterText = ''}) =>
      _privateServicesPages[filterText]?.hasMore ?? true;

  bool hasMoreCitiesFor(String? countryId, {String filterText = ''}) =>
      _citiesPages['${countryId ?? ''}|$filterText']?.hasMore ?? true;

  Future<List<CountryModel>> searchCountries({
    required String filterText,
    required int skipCount,
    int maxResultCount = 20,
    bool forceRefresh = false,
  }) {
    return _loadPaginated<CountryModel>(
      pages: _countriesPages,
      key: filterText,
      loadMore: skipCount > 0,
      forceRefresh: forceRefresh,
      pageSize: maxResultCount,
      fetch: (skip) async {
        final result = await sl<GetCountriesUseCase>()(
          GetCountriesUseCaseParams(
            query: LookupQueryParams(
              filterText: filterText,
              skipCount: skip,
              maxResultCount: maxResultCount,
            ),
          ),
        );
        return result.fold(
          (error) => throw Exception(error.errMessage),
          (data) => data,
        );
      },
    );
  }

  Future<List<CityModel>> searchCities({
    required String? countryId,
    required String filterText,
    required int skipCount,
    int maxResultCount = 20,
    bool forceRefresh = false,
  }) {
    return _loadPaginated<CityModel>(
      pages: _citiesPages,
      key: '${countryId ?? ''}|$filterText',
      loadMore: skipCount > 0,
      forceRefresh: forceRefresh,
      pageSize: maxResultCount,
      fetch: (skip) async {
        final result = await sl<GetCitiesUseCase>()(
          GetCitiesUseCaseParams(
            countryId: countryId,
            query: LookupQueryParams(
              filterText: filterText,
              skipCount: skip,
              maxResultCount: maxResultCount,
            ),
          ),
        );
        return result.fold(
          (error) => throw Exception(error.errMessage),
          (data) => data,
        );
      },
    );
  }

  Future<List<JobModel>> searchJobTitles({
    required String filterText,
    required int skipCount,
    int maxResultCount = 20,
    bool forceRefresh = false,
  }) {
    return _loadPaginated<JobModel>(
      pages: _jobsPages,
      key: filterText,
      loadMore: skipCount > 0,
      forceRefresh: forceRefresh,
      pageSize: maxResultCount,
      fetch: (skip) async {
        final result = await sl<GetJobTitlesUseCase>()(
          GetJobTitlesUseCaseParams(
            query: LookupQueryParams(
              filterText: filterText,
              skipCount: skip,
              maxResultCount: maxResultCount,
            ),
          ),
        );
        return result.fold(
          (error) => throw Exception(error.errMessage),
          (data) => data,
        );
      },
    );
  }

  Future<List<SkillModel>> searchSkills({
    required String filterText,
    required int skipCount,
    int maxResultCount = 20,
    bool forceRefresh = false,
  }) {
    return _loadPaginated<SkillModel>(
      pages: _skillsPages,
      key: filterText,
      loadMore: skipCount > 0,
      forceRefresh: forceRefresh,
      pageSize: maxResultCount,
      fetch: (skip) async {
        final result = await sl<GetSkillsUseCase>()(
          GetSkillsUseCaseParams(
            query: LookupQueryParams(
              filterText: filterText,
              skipCount: skip,
              maxResultCount: maxResultCount,
            ),
          ),
        );
        return result.fold(
          (error) => throw Exception(error.errMessage),
          (data) => data,
        );
      },
    );
  }

  Future<List<LanguageModel>> searchLanguages({
    required String filterText,
    required int skipCount,
    int maxResultCount = 20,
    bool forceRefresh = false,
  }) {
    return _loadPaginated<LanguageModel>(
      pages: _languagesPages,
      key: filterText,
      loadMore: skipCount > 0,
      forceRefresh: forceRefresh,
      pageSize: maxResultCount,
      fetch: (skip) async {
        final result = await sl<GetLanguagesUseCase>()(
          GetLanguagesUseCaseParams(
            query: LookupQueryParams(
              filterText: filterText,
              skipCount: skip,
              maxResultCount: maxResultCount,
            ),
          ),
        );
        return result.fold(
          (error) => throw Exception(error.errMessage),
          (data) => data,
        );
      },
    );
  }

  Future<List<PrivateServiceModel>> searchPrivateServices({
    required String filterText,
    required int skipCount,
    int maxResultCount = 20,
    bool forceRefresh = false,
  }) {
    return _loadPaginated<PrivateServiceModel>(
      pages: _privateServicesPages,
      key: filterText,
      loadMore: skipCount > 0,
      forceRefresh: forceRefresh,
      pageSize: maxResultCount,
      fetch: (skip) async {
        final result = await sl<GetPrivateServicesUseCase>()(
          GetPrivateServicesUseCaseParams(
            query: LookupQueryParams(
              filterText: filterText,
              skipCount: skip,
              maxResultCount: maxResultCount,
            ),
          ),
        );
        return result.fold(
          (error) => throw Exception(error.errMessage),
          (data) => data,
        );
      },
    );
  }
}
