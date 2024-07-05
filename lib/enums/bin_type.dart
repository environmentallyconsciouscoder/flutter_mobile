enum BinType {
  hdpeWheelie(
    description: 'HDPE wheelie bin',
    appWriteEnum: 'HDPE Wheelie',
  ),
  metal(
    description: 'Metal bin',
    appWriteEnum: 'Metal',
  ),
  smart(
    description: 'Smart bin',
    appWriteEnum: 'Smart',
  ),
  other(
    description: 'Other bin',
    appWriteEnum: 'Other',
  ),
  unknown(
    description: "Don't know",
    appWriteEnum: 'Unknown',
  );

  final String description;
  final String appWriteEnum;

  const BinType({required this.description, required this.appWriteEnum});

  static BinType lookup(String value) {
    return values.firstWhere(
      (element) => element.appWriteEnum.toLowerCase() == value.toLowerCase(),
      orElse: () => BinType.hdpeWheelie,
    );
  }
}
