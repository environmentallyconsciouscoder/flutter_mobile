enum UserRole {
  employee(
    description: 'An employee',
    appWriteEnum: 'Employee',
  ),
  ownerManager(
    description: 'An owner/manager',
    appWriteEnum: 'Owner/Manager',
  ),
  cleaningTeam(
    description: 'Part of the cleaning team',
    appWriteEnum: 'Cleaning Team',
  );

  final String description;
  final String appWriteEnum;

  const UserRole({required this.description, required this.appWriteEnum});

  static UserRole lookup(String value) {
    return values.firstWhere(
      (element) => element.appWriteEnum.toLowerCase() == value.toLowerCase(),
      orElse: () => UserRole.ownerManager,
    );
  }
}
