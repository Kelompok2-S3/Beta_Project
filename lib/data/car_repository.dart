import 'package:beta_project/models/car_model.dart';
import 'amc_data.dart';
import 'amg_data.dart';
import 'ats_data.dart';
import 'bac_data.dart';
import 'bmw_data.dart';
import 'gmc_data.dart';
import 'alfa_data.dart';
import 'audi_data.dart';
import 'auto_data.dart';
import 'ford_data.dart';
import 'jeep_data.dart';
import 'mini_data.dart';
import 'abart_data.dart';
import 'acura_data.dart';
import 'ariel_data.dart';
import 'dodge_data.dart';
import 'honda_data.dart';
import 'lexus_data.dart';
import 'lotus_data.dart';
import 'mazda_data.dart';
import 'alpine_data.dart';
import 'apollo_data.dart';
import 'ascari_data.dart';
import 'bently_data.dart';
import 'jaguar_data.dart';
import 'nissan_data.dart';
import 'pagani_data.dart';
import 'subaru_data.dart';
import 'toyota_data.dart';
import 'bugatti_data.dart';
import 'ferrari_data.dart';
import 'formula_data.dart';
import 'hyundai_data.dart';
import 'mclaren_data.dart';
import 'porsche_data.dart';
import 'renault_data.dart';
import 'cadillac_data.dart';
import 'hoonigan_data.dart';
import 'maserati_data.dart';
import 'mercedes_data.dart';
import 'chevrolet_data.dart';
import 'hennessey_data.dart';
import 'alumicraft_data.dart';
import 'hot_wheels_data.dart';
import 'koenigsegg_data.dart';
import 'mitsubishi_data.dart';
import 'volkswagen_data.dart';
import 'lamborghini_data.dart';
import 'aston_martin_data.dart';
import 'buick_data.dart';
import 'brabham_data.dart';
import 'autozam_data.dart';
import 'automobili_pininfarina_data.dart';
import 'deberti_data.dart';
import 'willys_data.dart';
import 'casey_currie_motorsports_data.dart';
import 'universal_studios_data.dart';

class CarRepository {
  // Private constructor
  CarRepository._() {
    _initializeData();
  }

  // Singleton instance
  static final CarRepository instance = CarRepository._();

  // Data storage
  late final List<CarModel> _carouselCars;
  late final Map<String, List<CarModel>> _menuCars;
  late final List<CarModel> _allCars;
  late final Map<String, List<String>> _brandsByLetter;
  late final Map<String, List<CarModel>> _modelsByBrand;

  void _initializeData() {
    _carouselCars = [
      ...ferrariCars,
      ...lamborghiniCars,
      ...koenigseggCars,
      ...porscheCars,
      ...bugattiCars,
      ...mclarenCars,
    ];

    _menuCars = {
      'AMC': amcCars,
      'AMG': amgCars,
      'ATS': atsCars,
      'BAC': bacCars,
      'BMW': bmwCars,
      'GMC': gmcCars,
      'Alfa': alfaCars,
      'Audi': audiCars,
      'Auto': autoCars,
      'Ford': fordCars,
      'Jeep': jeepCars,
      'MINI': miniCars,
      'Abart': abartCars,
      'Acura': acuraCars,
      'Ariel': arielCars,
      'Dodge': dodgeCars,
      'Honda': hondaCars,
      'Lexus': lexusCars,
      'Lotus': lotusCars,
      'Mazda': mazdaCars,
      'Alpine': alpineCars,
      'Apollo': apolloCars,
      'Ascari': ascariCars,
      'Bently': bentlyCars,
      'Jaguar': jaguarCars,
      'Nissan': nissanCars,
      'Pagani': paganiCars,
      'Subaru': subaruCars,
      'Toyota': toyotaCars,
      'Bugatti': bugattiCars,
      'Ferrari': ferrariCars,
      'Formula': formulaCars,
      'Hyundai': hyundaiCars,
      'McLaren': mclarenCars,
      'Porsche': porscheCars,
      'Renault': renaultCars,
      'Cadillac': cadillacCars,
      'Hoonigan': hooniganCars,
      'Maserati': maseratiCars,
      'Mercedes': mercedesCars,
      'Chevrolet': chevroletCars,
      'Hennessey': hennesseyCars,
      'Alumicraft': alumicraftCars,
      'Hot Wheels': hotWheelsCars,
      'Koenigsegg': koenigseggCars,
      'Mitsubishi': mitsubishiCars,
      'Volkswagen': volkswagenCars,
      'Lamborghini': lamborghiniCars,
      'Aston Martin': astonMartinCars,
      'Buick': buickCars,
      'Brabham': brabhamCars,
      'Autozam': autozamCars,
      'Automobili Pininfarina': automobiliPininfarinaCars,
      'DeBerti': debertiCars,
      'Willys': willysCars,
      'Casey Currie Motorsports': caseyCurrieMotorsportsCars,
      'Universal Studios': universalStudiosCars,
    };

    _allCars = _menuCars.values.expand((cars) => cars).toList();

    // Grouping logic from AppMenu
    _modelsByBrand = {};
    for (var car in _allCars) {
      if (!_modelsByBrand.containsKey(car.brand)) {
        _modelsByBrand[car.brand] = [];
      }
      _modelsByBrand[car.brand]!.add(car);
    }

    _brandsByLetter = {};
    List<String> brands = _modelsByBrand.keys.toList();
    brands.sort();
    for (var brand in brands) {
      if (brand.isNotEmpty) {
        String firstLetter = brand.substring(0, 1).toUpperCase();
        if (!_brandsByLetter.containsKey(firstLetter)) {
          _brandsByLetter[firstLetter] = [];
        }
        _brandsByLetter[firstLetter]!.add(brand);
      }
    }
  }

  // Public accessors
  List<CarModel> get carouselCars => _carouselCars;
  Map<String, List<CarModel>> get menuCars => _menuCars;
  List<CarModel> get allCars => _allCars;
  Map<String, List<String>> get brandsByLetter => _brandsByLetter;
  Map<String, List<CarModel>> get modelsByBrand => _modelsByBrand;

  CarModel? findCarByName(String name) {
    try {
      return allCars.firstWhere((car) => car.name == name);
    } catch (e) {
      return null;
    }
  }
}
