import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterModel {
  final SfRangeValues ageRange;
  final SfRangeValues experienceRange;
  final List<String> nationalities;
  final String? profession;
  final String? skill;
  final int? minExperience;
  final int? maxExperience;
  final String? language;
  final int? gender;

  const FilterModel({
    this.ageRange = const SfRangeValues(18.0, 60.0),
    this.experienceRange = const SfRangeValues(0.0, 20.0),
    this.nationalities = const [],
    this.profession,
    this.skill,
    this.minExperience,
    this.maxExperience,
    this.language,
    this.gender,
  });

  FilterModel copyWith({
    SfRangeValues? ageRange,
    SfRangeValues? experienceRange,
    List<String>? nationalities,
    String? profession,
    String? skill,
    int? minExperience,
    int? maxExperience,
    String? language,
    int? gender,
  }) {
    return FilterModel(
      ageRange: ageRange ?? this.ageRange,
      experienceRange: experienceRange ?? this.experienceRange,
      nationalities: nationalities ?? this.nationalities,
      profession: profession ?? this.profession,
      skill: skill ?? this.skill,
      minExperience: minExperience ?? this.minExperience,
      maxExperience: maxExperience ?? this.maxExperience,
      language: language ?? this.language,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ageRange': ageRange,
      'experienceRange': experienceRange,
      'nationalities': nationalities,
      'profession': profession,
      'skill': skill,
      'minExperience': minExperience,
      'maxExperience': maxExperience,
      'language': language,
      'gender': gender,
    };
  }

  bool get isEmpty =>
      ageRange.start == 18.0 &&
      ageRange.end == 60.0 &&
      experienceRange.start == 0.0 &&
      experienceRange.end == 20.0 &&
      nationalities.isEmpty &&
      profession == null &&
      skill == null &&
      minExperience == null &&
      maxExperience == null &&
      language == null &&
      gender == null;

  static FilterModel get initial => const FilterModel();
}
