import 'package:isnad_worker/core/constant/app_assets.dart';

class JobModel {
  String? id;
  String? code;
  String? iconPath;

  JobModel({this.id, this.code, this.iconPath});

  factory JobModel.fromJson(Map<String, dynamic> json) {
    final translations = json['jobTitleTranslations'] as List?;

    String? name;
    if (translations != null && translations.isNotEmpty) {
      final defaultItem = translations.firstWhere(
        (e) => e['isDefault'] == true,
        orElse: () => translations.first,
      );
      name = defaultItem['name'];
    }

    return JobModel(
      id: json['jobTitle']?['id'] as String?,
      code: name,
      iconPath: AppIcons.dropDownIcon,
    );
  }
}
