enum CollectionFrequency {
  twiceWeekly(
    description: 'Twice weekly',
    appWriteEnum: 'Twice weekly',
  ),
  weekly(
    description: 'Weekly',
    appWriteEnum: 'Weekly',
  ),
  fortnightly(
    description: 'Fortnightly',
    appWriteEnum: 'Fortnightly',
  ),
  fourWeekly(
    description: '4-weekly',
    appWriteEnum: '4-weekly',
  ),
  monthly(
    description: 'Monthly',
    appWriteEnum: 'Monthly',
  );

  final String description;
  final String appWriteEnum;

  const CollectionFrequency({required this.description, required this.appWriteEnum});

  static CollectionFrequency lookup(String value) {
    return values.firstWhere(
      (element) => element.appWriteEnum.toLowerCase() == value.toLowerCase(),
      orElse: () => CollectionFrequency.weekly,
    );
  }
}
