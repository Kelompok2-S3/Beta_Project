class SpecificationGroup {
  final String title;
  final Map<String, String> specs;

  SpecificationGroup({required this.title, required this.specs});
}

class CarModel {
  final String name;
  final String brand;
  final String price;
  final String assetPath; // Changed from imageUrl
  final String description;
  final String power;
  final String acceleration;
  final String topSpeed;
  final String torque;
  final String engine;
  final String displacement;
  final String drive;
  final List<String> galleryImages;
  final List<SpecificationGroup> technicalData;

  CarModel({
    required this.name,
    required this.brand,
    required this.price,
    required this.assetPath, // Changed from imageUrl
    required this.description,
    required this.power,
    required this.acceleration,
    required this.topSpeed,
    required this.torque,
    required this.engine,
    required this.displacement,
    required this.drive,
    required this.galleryImages,
    required this.technicalData,
  });
}
