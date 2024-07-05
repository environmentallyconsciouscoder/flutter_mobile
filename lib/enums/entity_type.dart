enum EntityType {
  caddy(
    description: 'Caddy',
    appWriteEnum: 'caddy',
  ),
  producerSite(
    description: 'Producer site',
    appWriteEnum: 'producerSite',
  ),
  bin(
    description: 'Bin',
    appWriteEnum: 'bin',
  ),
  carrier(
    description: 'Carrier',
    appWriteEnum: 'carrier',
  ),
  processorSite(
    description: 'Processor site',
    appWriteEnum: 'processorSite',
  );

  final String description;
  final String appWriteEnum;

  const EntityType({required this.description, required this.appWriteEnum});

  static EntityType lookup(String value) {
    return values.firstWhere(
      (element) => element.appWriteEnum.toLowerCase() == value.toLowerCase(),
      orElse: () => EntityType.bin,
    );
  }
}
