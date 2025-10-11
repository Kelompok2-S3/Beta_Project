import '../models/car_model.dart';

// Import all individual car data files
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
import '../data/buick_data.dart';
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
import '../data/willys_data.dart';
import '../data/autozam_data.dart';
import '../data/brabham_data.dart';
import '../data/bugatti_data.dart';
import '../data/deberti_data.dart';
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
import '../data/universal_studios_data.dart';
import '../data/automobili_pininfarina_data.dart';
import '../data/casey_currie_motorsports_data.dart';

// This is the central, pre-compiled list of all cars for maximum performance.
final List<CarModel> allCars = [
  ...amcCars,
  ...amgCars,
  ...atsCars,
  ...bacCars,
  ...bmwCars,
  ...gmcCars,
  ...alfaCars,
  ...audiCars,
  ...autoCars,
  ...fordCars,
  ...jeepCars,
  ...miniCars,
  ...abartCars,
  ...acuraCars,
  ...arielCars,
  ...buickCars,
  ...dodgeCars,
  ...hondaCars,
  ...lexusCars,
  ...lotusCars,
  ...mazdaCars,
  ...alpineCars,
  ...apolloCars,
  ...ascariCars,
  ...bentlyCars,
  ...jaguarCars,
  ...nissanCars,
  ...paganiCars,
  ...subaruCars,
  ...toyotaCars,
  ...willysCars,
  ...autozamCars,
  ...brabhamCars,
  ...bugattiCars,
  ...debertiCars,
  ...ferrariCars,
  ...formulaCars,
  ...hyundaiCars,
  ...mclarenCars,
  ...porscheCars,
  ...renaultCars,
  ...cadillacCars,
  ...hooniganCars,
  ...maseratiCars,
  ...mercedesCars,
  ...chevroletCars,
  ...hennesseyCars,
  ...alumicraftCars,
  ...hotWheelsCars,
  ...koenigseggCars,
  ...mitsubishiCars,
  ...volkswagenCars,
  ...lamborghiniCars,
  ...astonMartinCars,
  ...universalStudiosCars,
  ...automobiliPininfarinaCars,
  ...caseyCurrieMotorsportsCars,
];
