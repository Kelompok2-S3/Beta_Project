class Car {
  final String category;
  final String brand;
  final String year;
  final String engine;
  final String power;
  final String torque;
  final String weight;
  final String sourceUrl;

  Car({
    required this.category,
    required this.brand,
    required this.year,
    required this.engine,
    required this.power,
    required this.torque,
    required this.weight,
    required this.sourceUrl,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    String getValue(String keyPart) {
      try {
        final key = json.keys.firstWhere((k) => k.contains(keyPart), orElse: () => '');
        return key.isNotEmpty ? json[key]?.toString() ?? '' : '';
      } catch (e) {
        return '';
      }
    }

    return Car(
      category: getValue('Kategori'),
      brand: getValue('Merek'),
      year: getValue('Tahun'),
      engine: getValue('Mesin'),
      power: getValue('Tenaga'),
      torque: getValue('Torsi'),
      weight: getValue('Berat'),
      sourceUrl: getValue('Source URL'),
    );
  }
}
