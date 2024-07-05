enum SiteType {
  hospitality(
    description: 'Hospitality business',
    appWriteEnum: 'Hospitality',
  ),
  nonHospitality(
    description: 'Non-hospitality business',
    appWriteEnum: 'Non-hospitality',
  );

  final String description;
  final String appWriteEnum;

  const SiteType({required this.description, required this.appWriteEnum});

  static SiteType lookup(String value) {
    return values.firstWhere(
      (element) => element.appWriteEnum.toLowerCase() == value.toLowerCase(),
      orElse: () => SiteType.nonHospitality,
    );
  }
}
