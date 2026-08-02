class DownloadTokenModel {
  final String token;

  DownloadTokenModel({required this.token});

  factory DownloadTokenModel.fromJson(Map<String, dynamic> json) {
    return DownloadTokenModel(token: json['token']?.toString() ?? '');
  }
}
