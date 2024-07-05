enum CompanyType {
  publicLimited(
    description: 'Public limited company',
    appWriteEnum: 'Public limited company (PLC)',
  ),
  limitedByShares(
    description: 'Private limited by shares',
    appWriteEnum: 'Private company limited by shares (LTD)',
  ),
  limitedByGuarantee(
    description: 'Private limited by guarantee',
    appWriteEnum: 'Company limited by guarantee (CLG)',
  ),
  unlimited(
    description: 'Unlimited company',
    appWriteEnum: 'Unlimited company (UNLTD)',
  ),
  limitedLiabilityPartnership(
    description: 'Limited Liability Partnership',
    appWriteEnum: 'Limited Liability Partnership (LLP)',
  ),
  communityInterest(
    description: 'Community Interest company',
    appWriteEnum: 'Community Interest Company (CIC)',
  ),
  industrialAndProvidentSociety(
    description: 'Industrial and Provident Society',
    appWriteEnum: 'Industrial and Provident Society (IPS)',
  ),
  royalCharter(
    description: 'Royal Charter',
    appWriteEnum: 'Royal Charter (RC)',
  ),
  soleTrader(
    description: 'Sole trader',
    appWriteEnum: 'Sole trader (ST)',
  ),
  charity(
    description: 'Charitable organisation',
    appWriteEnum: 'Charitable Incorporated Organisation (CIO)',
  );

  final String description;
  final String appWriteEnum;

  const CompanyType({required this.description, required this.appWriteEnum});

  static CompanyType lookup(String value) {
    return values.firstWhere(
      (element) => element.appWriteEnum.toLowerCase() == value.toLowerCase(),
      orElse: () => CompanyType.limitedByGuarantee,
    );
  }
}
