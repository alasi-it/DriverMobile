import 'package:isnad_worker/core/file_management/domain/entities/file_tag.dart';

class FileDescriptorModel {
  final String id;
  final String name;
  final String? mimeType;
  final int? size;
  final FileTag fileTag;
  final DateTime? createdDate;
  String? urlll;

  FileDescriptorModel({
    required this.id,
    required this.name,
    required this.mimeType,
    required this.size,
    required this.fileTag,
    this.urlll,
    required this.createdDate,
  });

  factory FileDescriptorModel.fromJson(Map<String, dynamic> json) {
    return FileDescriptorModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      mimeType: json['mimeType']?.toString(),
      size: json['size'] is num ? (json['size'] as num).toInt() : null,
      fileTag: (json['fileTag']?.toString() ?? '').toFileTag(),
      createdDate: DateTime.tryParse(json['createdDate']?.toString() ?? ''),
      urlll: json['url']?.toString(),
    );
  }
}
