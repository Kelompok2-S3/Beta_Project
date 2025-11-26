import 'package:beta_project/domain/entities/car_model.dart';

abstract class CarRepository {
  List<CarModel> get carouselCars;
  Map<String, List<CarModel>> get menuCars;
  List<CarModel> get allCars;
  Map<String, List<String>> get brandsByLetter;
  Map<String, List<CarModel>> get modelsByBrand;
  CarModel? findCarByName(String name);
}
