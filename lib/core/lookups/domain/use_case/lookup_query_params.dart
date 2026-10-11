class LookupQueryParams {
  final String? filterText;
  final int skipCount;
  final int maxResultCount;

  const LookupQueryParams({
    this.filterText,
    this.skipCount = 0,
    this.maxResultCount = 20,
  });

  Map<String, dynamic> toMap() {
    return {
      if (filterText != null && filterText!.isNotEmpty)
        'FilterText': filterText,
      'SkipCount': skipCount,
      'MaxResultCount': maxResultCount,
    };
  }
}
