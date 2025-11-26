import 'package:beta_project/domain/entities/car_model.dart';

final List<CarModel> ferrariCars = [
  CarModel(
    name: 'SF90 Stradale',
    brand: 'Ferrari',
    description: 'The new series-production supercar.',
    assetPath: 'assets/images/Ferrari/Ferrari_Ferrari_SF90_Stradale.png',
    power: '1000 CV',
    acceleration: '2.5s',
    topSpeed: '340 km/h',
    price: 'From €430,000',
    engine: 'V8 - 90° twin-turbo',
    displacement: '3990 cc',
    torque: '800 Nm',
    drive: 'All-Wheel Drive',
    galleryImages: [
      'assets/images/Ferrari/Ferrari_Ferrari_SF90_Stradale.png',
    ],
    technicalData: [
      SpecificationGroup(title: 'Engine', specs: {'Type': 'V8 - 90° twin-turbo', 'Displacement': '3990 cc'}),
    ],
  ),
  CarModel(
    name: 'F8 Tributo',
    brand: 'Ferrari',
    description: 'An homage to the most powerful V8 in Ferrari history.',
    assetPath: 'assets/images/Ferrari/Ferrari_Ferrari_F8_Tributo.png',
    power: '720 CV',
    acceleration: '2.9s',
    topSpeed: '340 km/h',
    price: 'From €236,000',
    engine: 'V8 - 90° twin-turbo',
    displacement: '3902 cc',
    torque: '770 Nm',
    drive: 'Rear-Wheel Drive',
    galleryImages: [
      'assets/images/Ferrari/Ferrari_Ferrari_F8_Tributo.png',
    ],
    technicalData: [
      SpecificationGroup(title: 'Engine', specs: {'Type': 'V8 - 90° twin-turbo', 'Displacement': '3902 cc'}),
    ],
  ),
  CarModel(
    name: '812 Superfast',
    brand: 'Ferrari',
    description: 'The fastest and most powerful Ferrari yet.',
    assetPath: 'assets/images/Ferrari/Ferrari_Ferrari_812_Superfast.png',
    power: '800 CV',
    acceleration: '2.9s',
    topSpeed: '340 km/h',
    price: 'From €292,000',
    engine: 'V12 - 65°',
    displacement: '6496 cc',
    torque: '718 Nm',
    drive: 'Rear-Wheel Drive',
    galleryImages: [
      'assets/images/Ferrari/Ferrari_Ferrari_812_Superfast.png',
    ],
    technicalData: [
      SpecificationGroup(title: 'Engine', specs: {'Type': 'V12 - 65°', 'Displacement': '6496 cc'}),
    ],
  ),
  CarModel(
    name: 'LaFerrari',
    brand: 'Ferrari',
    description: 'The first hybrid supercar from Maranello.',
    assetPath: 'assets/images/Ferrari/Ferrari_Ferrari_LaFerrari.png',
    power: '963 CV',
    acceleration: '<3s',
    topSpeed: '>350 km/h',
    price: '€1,300,000',
    engine: 'V12 Hybrid',
    displacement: '6262 cc',
    torque: '>900 Nm',
    drive: 'Rear-Wheel Drive',
    galleryImages: [
      'assets/images/Ferrari/Ferrari_Ferrari_LaFerrari.png',
    ],
    technicalData: [
      SpecificationGroup(title: 'Engine', specs: {'Type': 'V12 Hybrid', 'Displacement': '6262 cc'}),
    ],
  ),
];
