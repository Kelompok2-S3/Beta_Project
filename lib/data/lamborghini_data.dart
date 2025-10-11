import 'package:beta_project/models/car_model.dart';

final List<CarModel> lamborghiniCars = [
  CarModel(
    name: 'Revuelto',
    brand: 'Lamborghini',
    description: 'The first-ever V12 hybrid plug-in HPEV.',
    assetPath: 'assets/images/Lamborghini/Lamborghini_Lamborghini_Revuelto.png',
    power: '1015 PS',
    acceleration: '2.5s',
    topSpeed: '>350 km/h',
    price: 'From €450,000',
    engine: 'V12 Hybrid',
    displacement: '6.5L',
    torque: '725 Nm',
    drive: 'All-Wheel Drive',
    galleryImages: [
      'assets/images/Lamborghini/Lamborghini_Lamborghini_Revuelto.png',
    ],
    technicalData: [
      SpecificationGroup(title: 'Engine', specs: {'Type': 'V12 Hybrid', 'Displacement': '6.5L'}),
    ],
  ),
  CarModel(
    name: 'Urus',
    brand: 'Lamborghini',
    description: 'The world\'s first Super Sport Utility Vehicle.',
    assetPath: 'assets/images/Lamborghini/Lamborghini_Lamborghini_Urus.png',
    power: '666 PS',
    acceleration: '3.3s',
    topSpeed: '306 km/h',
    price: 'From €200,000',
    engine: '4.0L Twin-Turbo V8',
    displacement: '4.0L',
    torque: '850 Nm',
    drive: 'All-Wheel Drive',
    galleryImages: [
      'assets/images/Lamborghini/Lamborghini_Lamborghini_Urus.png',
    ],
    technicalData: [
      SpecificationGroup(title: 'Engine', specs: {'Type': '4.0L Twin-Turbo V8', 'Displacement': '4.0L'}),
    ],
  ),
];
