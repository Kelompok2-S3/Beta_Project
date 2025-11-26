import 'package:beta_project/domain/entities/car_model.dart';

final List<CarModel> atsCars = [
  CarModel(
    name: 'GT',
    brand: 'ATS',
    description: '',
    assetPath: 'assets/images/ATS/ATS_ATS_GT.png', // Corrected Path
    power: '',
    acceleration: '',
    topSpeed: '',
    price: '',
    engine: '',
    displacement: '',
    torque: '',
    drive: '',
    galleryImages: [
      'assets/images/ATS/ATS_ATS_GT.png', // Corrected Path
    ],
    technicalData: [
      SpecificationGroup(title: 'Engine', specs: {'Type': '', 'Displacement': ''}),
    ],
  ),
];
