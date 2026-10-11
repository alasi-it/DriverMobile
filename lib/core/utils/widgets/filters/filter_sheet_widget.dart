// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:isnad_worker/core/lookups/presentation/manager/lookups_cubit.dart';
// import 'package:isnad_worker/core/style/app_colors.dart';
// import 'package:isnad_worker/core/style/app_dimensions.dart';
// import 'package:isnad_worker/core/utils/models/filter_model.dart';
// import 'package:isnad_worker/core/utils/widgets/buttons/custom_button.dart';
// import 'package:isnad_worker/core/utils/widgets/fields/custom_field_dropdown.dart';
// import 'package:isnad_worker/core/utils/widgets/filters/age_range_filter_slider_widget.dart';
// import 'package:isnad_worker/core/utils/widgets/filters/experance_filter_selector.dart'
//     show RadioFilterWidget;
// import 'package:isnad_worker/core/utils/widgets/filters/experience_range_filter_slider_widget.dart';
// import 'package:isnad_worker/core/utils/widgets/filters/filter_sheet_header_widget.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';

// class FilterSheet extends StatefulWidget {
//   const FilterSheet({
//     super.key,
//     this.showJobs = true,
//     this.showSkills = true,
//     this.initialFilter,
//     this.showLang = true,
//     this.showGender = true,
//   });
//   final bool showJobs;
//   final bool showSkills;
//   final bool showLang;
//   final bool showGender;
//   final FilterModel? initialFilter;

//   @override
//   State<FilterSheet> createState() => _FilterSheetState();
// }

// class _FilterSheetState extends State<FilterSheet> {
//   SfRangeValues _ageRange = const SfRangeValues(18.0, 60.0);
//   SfRangeValues _experienceRange = const SfRangeValues(0.0, 20.0);

//   String? _selectedNationalityId;
//   String? _selectedNationalityLabel;
//   String? _selectedProfessionId;
//   String? _selectedProfessionLabel;
//   String? _selectedSkillId;
//   String? _selectedSkillLabel;
//   String? _selectedLanguageId;
//   String? _selectedLanguageLabel;
//   String? _selectedGender;

//   int _resetKey = 0;

//   late final LookupsCubit _lookups;

//   int? _genderLabelToInt(String? label) {
//     if (label == null) return null;
//     return label == _genderOptions[0] ? 0 : 1;
//   }

//   String? _genderIntToLabel(int? value) {
//     if (value == null) return null;
//     return value == 0 ? _genderOptions[0] : _genderOptions[1];
//   }

//   List<String> get _genderOptions => [
//     'filter.genders.male'.tr(),
//     'filter.genders.female'.tr(),
//   ];

//   void _hydrateFromInitialFilter() {
//     final filter = widget.initialFilter;
//     if (filter == null) return;
//     _ageRange = filter.ageRange;
//     _experienceRange = filter.experienceRange;
//     _selectedNationalityId = filter.nationalities.isNotEmpty
//         ? filter.nationalities.first
//         : null;
//     _selectedProfessionId = filter.profession;
//     _selectedSkillId = filter.skill;
//     _selectedLanguageId = filter.language;
//     _selectedGender = _genderIntToLabel(filter.gender);
//   }

//   // The initial filter only carries selected ids, not their display labels,
//   // so we resolve each label once against the first search page.
//   void _resolveInitialLabels() {
//     if (_selectedNationalityId != null) {
//       _lookups.searchCountries(filterText: '', skipCount: 0).then((countries) {
//         final match = countries.where((c) => c.id == _selectedNationalityId);
//         if (match.isNotEmpty && mounted) {
//           setState(
//             () => _selectedNationalityLabel = match.first.nationalityName,
//           );
//         }
//       });
//     }

//     if (widget.showJobs && _selectedProfessionId != null) {
//       _lookups.searchJobTitles(filterText: '', skipCount: 0).then((jobs) {
//         final match = jobs.where((j) => j.id == _selectedProfessionId);
//         if (match.isNotEmpty && mounted) {
//           setState(() => _selectedProfessionLabel = match.first.code);
//         }
//       });
//     }

//     if (widget.showSkills && _selectedSkillId != null) {
//       _lookups.searchSkills(filterText: '', skipCount: 0).then((skills) {
//         final match = skills.where((s) => s.id == _selectedSkillId);
//         if (match.isNotEmpty && mounted) {
//           setState(() => _selectedSkillLabel = match.first.name);
//         }
//       });
//     }

//     if (widget.showLang && _selectedLanguageId != null) {
//       _lookups.searchLanguages(filterText: '', skipCount: 0).then((languages) {
//         final match = languages.where((l) => l.id == _selectedLanguageId);
//         if (match.isNotEmpty && mounted) {
//           setState(() => _selectedLanguageLabel = match.first.name);
//         }
//       });
//     }
//   }

//   void _resetFilters() {
//     setState(() {
//       _ageRange = const SfRangeValues(18.0, 60.0);
//       _experienceRange = const SfRangeValues(0.0, 20.0);
//       _selectedNationalityId = null;
//       _selectedNationalityLabel = null;
//       _selectedProfessionId = null;
//       _selectedProfessionLabel = null;
//       _selectedSkillId = null;
//       _selectedSkillLabel = null;
//       _selectedLanguageId = null;
//       _selectedLanguageLabel = null;
//       _selectedGender = null;
//       _resetKey++;
//     });
//   }

//   void _applyFilters() {
//     final isDefaultExp =
//         _experienceRange.start == 0.0 && _experienceRange.end == 20.0;
//     Navigator.of(context).pop(
//       FilterModel(
//         ageRange: _ageRange,
//         experienceRange: _experienceRange,
//         nationalities: _selectedNationalityId != null
//             ? [_selectedNationalityId!]
//             : [],
//         profession: _selectedProfessionId,
//         skill: _selectedSkillId,
//         minExperience: isDefaultExp ? null : _experienceRange.start.round(),
//         maxExperience: isDefaultExp ? null : _experienceRange.end.round(),
//         language: _selectedLanguageId,
//         gender: _genderLabelToInt(_selectedGender),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _hydrateFromInitialFilter();
//     _lookups = context.read<LookupsCubit>();
//     _resolveInitialLabels();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
//         decoration: BoxDecoration(
//           boxShadow: [AppDimensions.sheetShadow],
//           color: Theme.of(context).scaffoldBackgroundColor,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               FilterSheetHeader(title: 'filter.browse_results'.tr()),
//               SizedBox(height: 16.h),

//               AgeRangeFilterSlider(
//                 key: ValueKey('age_$_resetKey'),
//                 initialRange: _ageRange,
//                 onChanged: (val) => setState(() => _ageRange = val),
//               ),

//               SizedBox(height: 24.h),

//               CustomFieldDropdown<String>(
//                 showInBottomSheet: true,
//                 key: ValueKey('nat_$_resetKey'),
//                 title: 'filter.nationality'.tr(),
//                 hintText: 'filter.select_nationality'.tr(),
//                 validator: (_) => null,
//                 selected: _selectedNationalityId,
//                 selectedLabel: _selectedNationalityLabel,
//                 onChanged: (id) => setState(() => _selectedNationalityId = id),
//                 onItemSelected: (item) =>
//                     setState(() => _selectedNationalityLabel = item?.label),
//                 asyncItems: (filterText, skipCount, maxResultCount) => _lookups
//                     .searchCountries(
//                       filterText: filterText,
//                       skipCount: skipCount,
//                       maxResultCount: maxResultCount,
//                     )
//                     .then(
//                       (result) => result
//                           .where(
//                             (c) =>
//                                 (c.id?.isNotEmpty ?? false) &&
//                                 (c.nationalityName?.isNotEmpty ?? false),
//                           )
//                           .map(
//                             (c) => DropdownItem(
//                               id: c.id!,
//                               label: c.nationalityName!,
//                             ),
//                           )
//                           .toList(),
//                     ),
//               ),

//               SizedBox(height: 24.h),

//               if (widget.showJobs) ...[
//                 CustomFieldDropdown<String>(
//                   showInBottomSheet: true,
//                   key: ValueKey('prof_$_resetKey'),
//                   title: 'filter.profession'.tr(),
//                   hintText: 'filter.select_profession'.tr(),
//                   validator: (_) => null,
//                   selected: _selectedProfessionId,
//                   selectedLabel: _selectedProfessionLabel,
//                   onChanged: (id) => setState(() => _selectedProfessionId = id),
//                   onItemSelected: (item) =>
//                       setState(() => _selectedProfessionLabel = item?.label),
//                   asyncItems: (filterText, skipCount, maxResultCount) =>
//                       _lookups
//                           .searchJobTitles(
//                             filterText: filterText,
//                             skipCount: skipCount,
//                             maxResultCount: maxResultCount,
//                           )
//                           .then(
//                             (result) => result
//                                 .where(
//                                   (j) =>
//                                       (j.id?.isNotEmpty ?? false) &&
//                                       (j.code?.isNotEmpty ?? false),
//                                 )
//                                 .map(
//                                   (j) =>
//                                       DropdownItem(id: j.id!, label: j.code!),
//                                 )
//                                 .toList(),
//                           ),
//                 ),
//                 SizedBox(height: 24.h),
//               ],

//               if (widget.showSkills) ...[
//                 CustomFieldDropdown<String>(
//                   showInBottomSheet: true,
//                   key: ValueKey('skill_$_resetKey'),
//                   title: 'filter.skill'.tr(),
//                   hintText: 'filter.select_skill'.tr(),
//                   validator: (_) => null,
//                   selected: _selectedSkillId,
//                   selectedLabel: _selectedSkillLabel,
//                   onChanged: (id) => setState(() => _selectedSkillId = id),
//                   onItemSelected: (item) =>
//                       setState(() => _selectedSkillLabel = item?.label),
//                   asyncItems: (filterText, skipCount, maxResultCount) =>
//                       _lookups
//                           .searchSkills(
//                             filterText: filterText,
//                             skipCount: skipCount,
//                             maxResultCount: maxResultCount,
//                           )
//                           .then(
//                             (result) => result
//                                 .where(
//                                   (s) =>
//                                       (s.id?.isNotEmpty ?? false) &&
//                                       (s.name?.isNotEmpty ?? false),
//                                 )
//                                 .map(
//                                   (s) =>
//                                       DropdownItem(id: s.id!, label: s.name!),
//                                 )
//                                 .toList(),
//                           ),
//                 ),
//                 SizedBox(height: 24.h),
//               ],

//               ExperienceRangeFilterSlider(
//                 key: ValueKey('exp_$_resetKey'),
//                 initialRange: _experienceRange,
//                 onChanged: (val) => setState(() => _experienceRange = val),
//               ),

//               SizedBox(height: 24.h),

//               if (widget.showLang) ...[
//                 CustomFieldDropdown<String>(
//                   showInBottomSheet: true,
//                   key: ValueKey('lang_$_resetKey'),
//                   title: 'filter.language'.tr(),
//                   hintText: 'filter.select_language'.tr(),
//                   validator: (_) => null,
//                   selected: _selectedLanguageId,
//                   selectedLabel: _selectedLanguageLabel,
//                   onChanged: (id) => setState(() => _selectedLanguageId = id),
//                   onItemSelected: (item) =>
//                       setState(() => _selectedLanguageLabel = item?.label),
//                   asyncItems: (filterText, skipCount, maxResultCount) =>
//                       _lookups
//                           .searchLanguages(
//                             filterText: filterText,
//                             skipCount: skipCount,
//                             maxResultCount: maxResultCount,
//                           )
//                           .then(
//                             (result) => result
//                                 .where(
//                                   (l) =>
//                                       (l.id?.isNotEmpty ?? false) &&
//                                       (l.name?.isNotEmpty ?? false),
//                                 )
//                                 .map(
//                                   (l) =>
//                                       DropdownItem(id: l.id!, label: l.name!),
//                                 )
//                                 .toList(),
//                           ),
//                 ),
//                 SizedBox(height: 24.h),
//               ],

//               if (widget.showGender) ...[
//                 RadioFilterWidget(
//                   key: ValueKey('gender_$_resetKey'),
//                   title: 'filter.gender'.tr(),
//                   options: _genderOptions,
//                   initialSelected: _selectedGender,
//                   onChanged: (val) => setState(() => _selectedGender = val),
//                 ),

//                 SizedBox(height: 32.h),
//               ],
//               SafeArea(
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: CustomButton(
//                         title: 'filter.apply'.tr(),
//                         onTap: _applyFilters,
//                         borderRadius: BorderRadius.circular(8.r),
//                         borderColor: AppColors.primary,
//                         height: 48.h,
//                       ),
//                     ),
//                     SizedBox(width: 16.w),
//                     Expanded(
//                       child: CustomButton(
//                         title: 'filter.reset'.tr(),
//                         onTap: _resetFilters,
//                         bgColor: Theme.of(context).colorScheme.surface,
//                         textColor: AppColors.primary,
//                         borderColor: AppColors.primary,
//                         borderRadius: BorderRadius.circular(8.r),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
