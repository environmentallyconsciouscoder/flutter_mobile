enum CaddySize {
  l7(
    description: '7 litres',
    volume: 7000,
    weight: 365,
  ),
  l20(
    description: '20 litres',
    volume: 20000,
    weight: 1110,
  );

  final String description;
  final int volume;
  final int weight;

  const CaddySize({required this.description, required this.volume, required this.weight});

  static CaddySize lookup(String value) {
    return values.firstWhere(
      (element) => element.description == value.toLowerCase(),
      orElse: () => CaddySize.l7,
    );
  }

  static CaddySize lookupFromVolume(int value) {
    return values.firstWhere(
      (element) => element.volume == value,
      orElse: () => CaddySize.l7,
    );
  }
}
