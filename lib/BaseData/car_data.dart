import 'package:beta_project/domain/entities/car_model.dart';
import '../data/amc_data.dart';
import '../data/amg_data.dart';
import '../data/ats_data.dart';
import '../data/bac_data.dart';
import '../data/bmw_data.dart';
import '../data/gmc_data.dart';
import '../data/alfa_data.dart';
import '../data/audi_data.dart';
import '../data/auto_data.dart';
import '../data/ford_data.dart';
import '../data/jeep_data.dart';
import '../data/mini_data.dart';
import '../data/abart_data.dart';
import '../data/acura_data.dart';
import '../data/ariel_data.dart';
import '../data/dodge_data.dart';
import '../data/honda_data.dart';
import '../data/lexus_data.dart';
import '../data/lotus_data.dart';
import '../data/mazda_data.dart';
import '../data/alpine_data.dart';
import '../data/apollo_data.dart';
import '../data/ascari_data.dart';
import '../data/bently_data.dart';
import '../data/jaguar_data.dart';
import '../data/nissan_data.dart';
import '../data/pagani_data.dart';
import '../data/subaru_data.dart';
import '../data/toyota_data.dart';
import '../data/bugatti_data.dart';
import '../data/ferrari_data.dart';
import '../data/formula_data.dart';
import '../data/hyundai_data.dart';
import '../data/mclaren_data.dart';
import '../data/porsche_data.dart';
import '../data/renault_data.dart';
import '../data/cadillac_data.dart';
import '../data/hoonigan_data.dart';
import '../data/maserati_data.dart';
import '../data/mercedes_data.dart';
import '../data/chevrolet_data.dart';
import '../data/hennessey_data.dart';
import '../data/alumicraft_data.dart';
import '../data/hot_wheels_data.dart';
import '../data/koenigsegg_data.dart';
import '../data/mitsubishi_data.dart';
import '../data/volkswagen_data.dart';
import '../data/lamborghini_data.dart';
import '../data/aston_martin_data.dart';
import '../data/buick_data.dart';
import '../data/brabham_data.dart';
import '../data/autozam_data.dart';
import '../data/automobili_pininfarina_data.dart';
import '../data/deberti_data.dart';
import '../data/willys_data.dart';
import '../data/casey_currie_motorsports_data.dart';
import '../data/universal_studios_data.dart';

// Data for the main carousel, combining multiple brands
final List<CarModel> carouselCars = [
  ...ferrariCars,
  ...lamborghiniCars,
  ...koenigseggCars, // Still included in case data is added later
  ...porscheCars,
  ...bugattiCars,
  ...mclarenCars,
];

// Data for the app menu, combining all car data
final Map<String, List<CarModel>> menuCars = {
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
