part of 'lookups_cubit.dart';

@immutable
sealed class LookupsState extends Equatable {}

final class LookupsInitial extends LookupsState {
  @override
  List<Object?> get props => [];
}

class GetCountriesLoadingState extends LookupsState {
  @override
  List<Object?> get props => [];
}

class GetCountriesSuccessState extends LookupsState {
  final List<CountryModel> countries;

  GetCountriesSuccessState(this.countries);

  @override
  List<Object?> get props => [countries];
}

class GetCountriesFailureState extends LookupsState {
  final String message;

  GetCountriesFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetJobsLoadingState extends LookupsState {
  @override
  List<Object?> get props => [];
}

class GetJobsSuccessState extends LookupsState {
  final List<JobModel> jobs;

  GetJobsSuccessState(this.jobs);

  @override
  List<Object?> get props => [jobs];
}

class GetJobsFailureState extends LookupsState {
  final String message;

  GetJobsFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetCitiesLoadingState extends LookupsState {
  @override
  List<Object?> get props => [];
}

class GetCitiesSuccessState extends LookupsState {
  final List<CityModel> cities;

  GetCitiesSuccessState(this.cities);

  @override
  List<Object?> get props => [cities];
}

class GetCitiesFailureState extends LookupsState {
  final String message;

  GetCitiesFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetSkillsLoadingState extends LookupsState {
  @override
  List<Object?> get props => [];
}

class GetSkillsSuccessState extends LookupsState {
  final List<SkillModel> skills;

  GetSkillsSuccessState(this.skills);

  @override
  List<Object?> get props => [skills];
}

class GetSkillsFailureState extends LookupsState {
  final String message;

  GetSkillsFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetLanguagesLoadingState extends LookupsState {
  @override
  List<Object?> get props => [];
}

class GetLanguagesSuccessState extends LookupsState {
  final List<dynamic> languages;

  GetLanguagesSuccessState(this.languages);

  @override
  List<Object?> get props => [languages];
}

class GetLanguagesFailureState extends LookupsState {
  final String message;

  GetLanguagesFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetPrivateServicesLoadingState extends LookupsState {
  @override
  List<Object?> get props => [];
}

class GetPrivateServicesSuccessState extends LookupsState {
  final List<PrivateServiceModel> privateServices;

  GetPrivateServicesSuccessState(this.privateServices);

  @override
  List<Object?> get props => [privateServices];
}

class GetPrivateServicesFailureState extends LookupsState {
  final String message;

  GetPrivateServicesFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
