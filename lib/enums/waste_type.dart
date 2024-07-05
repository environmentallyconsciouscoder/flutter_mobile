enum WasteType {
  general(
    description: 'General',
    appWriteEnum: 'General',
  ),
  spoilage(
    description: 'Spoilage',
    appWriteEnum: 'Spoilage',
  ),
  preparation(
    description: 'Preparation',
    appWriteEnum: 'Preparation',
  ),
  plate(
    description: 'Plate',
    appWriteEnum: 'Plate',
  ),
  all(
    description: 'All',
    appWriteEnum: 'All',
  );

  final String description;
  final String appWriteEnum;

  const WasteType({required this.description, required this.appWriteEnum});

  static WasteType lookup(String value) {
    return values.firstWhere(
      (element) => element.appWriteEnum.toLowerCase() == value.toLowerCase(),
      orElse: () => WasteType.general,
    );
  }
}
