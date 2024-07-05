enum WasteSourceType {
  covers(
    description: 'Covers',
    appWriteEnum: 'Covers',
  ),
  employees(
    description: 'Employees',
    appWriteEnum: 'Employees',
  );

  final String description;
  final String appWriteEnum;

  const WasteSourceType({required this.description, required this.appWriteEnum});

  static WasteSourceType lookup(String value) {
    return values.firstWhere(
      (element) => element.appWriteEnum.toLowerCase() == value.toLowerCase(),
      orElse: () => WasteSourceType.employees,
    );
  }
}
