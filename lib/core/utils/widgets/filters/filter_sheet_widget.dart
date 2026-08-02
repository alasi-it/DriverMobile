import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/lookups/data/models/country_model.dart';
import 'package:isnad_worker/core/lookups/data/models/job_model.dart';
import 'package:isnad_worker/core/lookups/data/models/skill_model.dart';
import 'package:isnad_worker/core/lookups/presentation/manager/lookups_cubit.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/utils/models/filter_model.dart';
import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
import 'package:isnad_worker/core/utils/widgets/filters/age_range_filter_slider_widget.dart';
import 'package:isnad_worker/core/utils/widgets/filters/experance_filter_selector.dart'
    show RadioFilterWidget;
import 'package:isnad_worker/core/utils/widgets/filters/experience_range_filter_slider_widget.dart';
import 'package:isnad_worker/core/utils/widgets/filters/filter_sheet_header_widget.dart';
import 'package:isnad_worker/core/utils/widgets/filters/single_choice_filter_widget.dart';
import 'package:isnad_worker/core/utils/widgets/status/error_widget_with_msg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({
    super.key,
    this.showJobs = true,
    this.showSkills = true,
    this.initialFilter,
    this.showLang = true,
    this.showGender = true,
  });
  final bool showJobs;
  final bool showSkills;
  final bool showLang;
  final bool showGender;
  final FilterModel? initialFilter;

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  SfRangeValues _ageRange = const SfRangeValues(18.0, 60.0);
  SfRangeValues _experienceRange = const SfRangeValues(0.0, 20.0);

  String? _selectedNationalityId;
  String? _selectedProfessionId;
  String? _selectedSkillId;
  String? _selectedLanguage;
  String? _selectedGender;

  int? _genderLabelToInt(String? label) {
    if (label == null) return null;
    return label == _genderOptions[0] ? 0 : 1;
  }

  String? _genderIntToLabel(int? value) {
    if (value == null) return null;
    return value == 0 ? _genderOptions[0] : _genderOptions[1];
  }

  int _resetKey = 0;
  bool _hydratedFromCubit = false;

  List<String> get _genderOptions => [
    'filter.genders.male'.tr(),
    'filter.genders.female'.tr(),
  ];

  void _hydrateFromActiveFilter() {
    if (_hydratedFromCubit) return;
    _hydratedFromCubit = true;

    final filter = widget.initialFilter;
    if (filter != null) {
      _ageRange = filter.ageRange;
      _experienceRange = filter.experienceRange;
      _selectedNationalityId = filter.nationalities.isNotEmpty
          ? filter.nationalities.first
          : null;
      _selectedProfessionId = filter.profession;
      _selectedSkillId = filter.skill;
      _selectedLanguage = filter.language;
      _selectedGender = _genderIntToLabel(filter.gender);
    }

    final lookups = context.read<LookupsCubit>();
    if (lookups.countries.isEmpty) {
      lookups.getCountries();
    }
    if (widget.showJobs && lookups.jobs.isEmpty) {
      lookups.getJobs();
    }
    if (widget.showLang && lookups.languages.isEmpty) {
      lookups.getLanguages();
    }
  }

  void _resetFilters() {
    setState(() {
      _ageRange = const SfRangeValues(18.0, 60.0);
      _experienceRange = const SfRangeValues(0.0, 20.0);
      _selectedNationalityId = null;
      _selectedProfessionId = null;
      _selectedSkillId = null;
      _selectedLanguage = null;
      _selectedGender = null;
      _resetKey++;
    });
  }

  void _applyFilters() {
    final isDefaultExp =
        _experienceRange.start == 0.0 && _experienceRange.end == 20.0;
    Navigator.of(context).pop(
      FilterModel(
        ageRange: _ageRange,
        experienceRange: _experienceRange,
        nationalities: _selectedNationalityId != null
            ? [_selectedNationalityId!]
            : [],
        profession: _selectedProfessionId,
        skill: _selectedSkillId,
        minExperience: isDefaultExp ? null : _experienceRange.start.round(),
        maxExperience: isDefaultExp ? null : _experienceRange.end.round(),
        language: _selectedLanguage,
        gender: _genderLabelToInt(_selectedGender),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final lookups = context.read<LookupsCubit>();
    if (lookups.countries.isEmpty) {
      lookups.getCountries();
    }
    if (lookups.skills.isEmpty) {
      lookups.getSkills();
    }
  }

  @override
  Widget build(BuildContext context) {
    _hydrateFromActiveFilter();
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        decoration: BoxDecoration(
          boxShadow: [AppDimensions.sheetShadow],
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilterSheetHeader(title: 'filter.browse_results'.tr()),
              SizedBox(height: 16.h),

              AgeRangeFilterSlider(
                key: ValueKey('age_$_resetKey'),
                initialRange: _ageRange,
                onChanged: (val) => setState(() => _ageRange = val),
              ),

              SizedBox(height: 24.h),

              BlocBuilder<LookupsCubit, LookupsState>(
                buildWhen: (previous, current) =>
                    current is GetCountriesLoadingState ||
                    current is GetCountriesFailureState ||
                    current is GetCountriesSuccessState,
                builder: (context, state) {
                  if (state is GetCountriesFailureState) {
                    return Text('');
                  }

                  if (state is GetCountriesLoadingState) {
                    return Skeletonizer(
                      ignorePointers: true,

                      child: SingleChoiceFilterWidget(
                        key: ValueKey('nat_$_resetKey'),
                        title: 'filter.nationality'.tr(),
                        options: [],
                        initialSelected: '',
                        onChanged: (_) {},
                      ),
                    );
                  }

                  final countries = context.read<LookupsCubit>().countries;
                  String? initialSelectedName;
                  if (_selectedNationalityId != null) {
                    final match = countries.where(
                      (c) => c.id == _selectedNationalityId,
                    );
                    if (match.isNotEmpty) {
                      initialSelectedName = match.first.nationalityName;
                    }
                  }

                  return SingleChoiceFilterWidget(
                    key: ValueKey('nat_$_resetKey'),
                    title: 'filter.nationality'.tr(),
                    options: countries
                        .map((e) => e.nationalityName ?? '')
                        .toList(),
                    pageSize: 5,
                    initialSelected: initialSelectedName,
                    onChanged: (selectedName) {
                      setState(() {
                        _selectedNationalityId = countries
                            .firstWhere(
                              (c) => c.nationalityName == selectedName,
                              orElse: () => CountryModel(),
                            )
                            .id;
                      });
                    },
                  );
                },
              ),

              SizedBox(height: 24.h),

              if (widget.showJobs) ...[
                BlocBuilder<LookupsCubit, LookupsState>(
                  buildWhen: (previous, current) =>
                      current is GetJobsLoadingState ||
                      current is GetJobsFailureState ||
                      current is GetJobsSuccessState,
                  builder: (context, state) {
                    if (state is GetJobsFailureState) {
                      return ErrorWidgetWithMsg(
                        msg: state.message,
                        onRetry: () => context.read<LookupsCubit>().getJobs(),
                      );
                    }

                    if (state is GetJobsLoadingState) {
                      return Skeletonizer(
                        ignorePointers: true,

                        child: SingleChoiceFilterWidget(
                          key: ValueKey('prof_$_resetKey'),
                          title: 'filter.profession'.tr(),
                          options: [],
                          initialSelected: '',
                          onChanged: (_) {},
                        ),
                      );
                    }

                    final jobs = context.read<LookupsCubit>().jobs;
                    String? initialSelectedCode;
                    if (_selectedProfessionId != null) {
                      final match = jobs.where(
                        (j) => j.id == _selectedProfessionId,
                      );
                      if (match.isNotEmpty) {
                        initialSelectedCode = match.first.code;
                      }
                    }

                    return Column(
                      children: [
                        SingleChoiceFilterWidget(
                          key: ValueKey('prof_$_resetKey'),
                          title: 'filter.profession'.tr(),
                          options: jobs.map((e) => e.code ?? '').toList(),
                          pageSize: 5,
                          initialSelected: initialSelectedCode,
                          onChanged: (selectedName) {
                            setState(() {
                              _selectedProfessionId = jobs
                                  .firstWhere(
                                    (j) => j.code == selectedName,
                                    orElse: () => JobModel(),
                                  )
                                  .id;
                            });
                          },
                        ),
                        SizedBox(height: 24.h),
                      ],
                    );
                  },
                ),
              ],
              if (widget.showSkills) ...[
                BlocBuilder<LookupsCubit, LookupsState>(
                  buildWhen: (previous, current) =>
                      current is GetSkillsLoadingState ||
                      current is GetSkillsFailureState ||
                      current is GetSkillsSuccessState,
                  builder: (context, state) {
                    if (state is GetSkillsFailureState) {
                      return ErrorWidgetWithMsg(
                        msg: state.message,
                        onRetry: () => context.read<LookupsCubit>().getSkills(),
                      );
                    }

                    if (state is GetSkillsLoadingState) {
                      return Skeletonizer(
                        ignorePointers: true,
                        child: SingleChoiceFilterWidget(
                          key: ValueKey('skill_$_resetKey'),
                          title: 'filter.skill'.tr(),
                          options: [],
                          initialSelected: '',
                          onChanged: (_) {},
                        ),
                      );
                    }

                    final skills = context.read<LookupsCubit>().skills;
                    String? initialSelectedName;
                    if (_selectedSkillId != null) {
                      final match = skills.where(
                        (s) => s.id == _selectedSkillId,
                      );
                      if (match.isNotEmpty) {
                        initialSelectedName = match.first.name;
                      }
                    }

                    return Column(
                      children: [
                        SingleChoiceFilterWidget(
                          key: ValueKey('skill_$_resetKey'),
                          title: 'filter.skill'.tr(),
                          options: skills.map((e) => e.name ?? '').toList(),
                          pageSize: 5,
                          initialSelected: initialSelectedName,
                          onChanged: (selectedName) {
                            setState(() {
                              _selectedSkillId = skills
                                  .firstWhere(
                                    (s) => s.name == selectedName,
                                    orElse: () => SkillModel(),
                                  )
                                  .id;
                            });
                          },
                        ),
                        SizedBox(height: 24.h),
                      ],
                    );
                  },
                ),
              ],
              ExperienceRangeFilterSlider(
                key: ValueKey('exp_$_resetKey'),
                initialRange: _experienceRange,
                onChanged: (val) => setState(() => _experienceRange = val),
              ),

              SizedBox(height: 24.h),

              if (widget.showLang) ...[
                BlocBuilder<LookupsCubit, LookupsState>(
                  buildWhen: (previous, current) =>
                      current is GetLanguagesLoadingState ||
                      current is GetLanguagesFailureState ||
                      current is GetLanguagesSuccessState,
                  builder: (context, state) {
                    if (state is GetLanguagesFailureState) {
                      return ErrorWidgetWithMsg(
                        msg: state.message,
                        onRetry: () =>
                            context.read<LookupsCubit>().getLanguages(),
                      );
                    }

                    if (state is GetLanguagesLoadingState) {
                      return Skeletonizer(
                        ignorePointers: true,
                        child: RadioFilterWidget(
                          key: ValueKey('lang_$_resetKey'),
                          title: 'filter.language'.tr(),
                          options: [],
                          onChanged: (_) {},
                        ),
                      );
                    }

                    final languages = context.read<LookupsCubit>().languages;

                    return RadioFilterWidget(
                      key: ValueKey('lang_$_resetKey'),
                      title: 'filter.language'.tr(),
                      options: languages.map((e) => e.name ?? '').toList(),
                      optionValues: languages.map((e) => e.id ?? '').toList(),
                      initialSelected: _selectedLanguage,
                      onChanged: (selectedId) {
                        setState(() {
                          _selectedLanguage = selectedId;
                        });
                      },
                    );
                  },
                ),

                SizedBox(height: 24.h),
              ],
              if (widget.showGender) ...[
                RadioFilterWidget(
                  key: ValueKey('gender_$_resetKey'),
                  title: 'filter.gender'.tr(),
                  options: _genderOptions,
                  initialSelected: _selectedGender,
                  onChanged: (val) => setState(() => _selectedGender = val),
                ),

                SizedBox(height: 32.h),
              ],
              SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        title: 'filter.apply'.tr(),
                        onTap: _applyFilters,
                        borderRadius: BorderRadius.circular(8.r),
                        borderColor: AppColors.primary,
                        height: 48.h,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: CustomButton(
                        title: 'filter.reset'.tr(),
                        onTap: _resetFilters,
                        bgColor: AppColors.white,
                        textColor: AppColors.primary,
                        borderColor: AppColors.primary,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
