enum FileTag {
  profilePicture,
  cv,
  nationalId,
  contract,
  certificate,
  report,
  invoice,
  other,
}

extension FileTagApiValue on FileTag {
  int get apiValue => switch (this) {
    FileTag.profilePicture => 1,

    FileTag.nationalId => 3,
    FileTag.contract => 4,
    FileTag.certificate => 5,
    FileTag.report => 6,
    FileTag.invoice => 7,
    FileTag.other => 8,
    FileTag.cv => 2,
  };
}

extension FileTagParsing on String {
  FileTag toFileTag() => switch (this) {
    'profilePicture' => FileTag.profilePicture,
    'cv' => FileTag.cv,
    'nationalId' => FileTag.nationalId,
    'contract' => FileTag.contract,
    'certificate' => FileTag.certificate,
    'report' => FileTag.report,
    'invoice' => FileTag.invoice,
    'other' => FileTag.other,
    _ => FileTag.cv,
  };
}
