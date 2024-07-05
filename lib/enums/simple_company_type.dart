enum SimpleCompanyType {
  registeredCompany(
    description: 'Registered company',
    appWriteEnum: 'Registered company',
  ),
  soleTrader(
    description: 'Sole trader',
    appWriteEnum: 'Sole trader',
  ),
  charity(
    description: 'Registered charity',
    appWriteEnum: 'Registered charity',
  );

  final String description;
  final String appWriteEnum;

  const SimpleCompanyType({required this.description, required this.appWriteEnum});

  static SimpleCompanyType lookup(String value) {
    return values.firstWhere(
      (element) => element.appWriteEnum.toLowerCase() == value.toLowerCase(),
      orElse: () => SimpleCompanyType.registeredCompany,
    );
  }
}
