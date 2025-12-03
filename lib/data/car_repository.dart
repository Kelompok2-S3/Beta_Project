import 'package:beta_project/domain/entities/car_model.dart';
import 'package:beta_project/domain/repositories/car_repository.dart' as domain;
import 'package:beta_project/services/car_service.dart';
import 'package:beta_project/models/car_model.dart' as api;

class CarRepositoryImpl implements domain.CarRepository {
  // Private constructor
  CarRepositoryImpl._();

  // Singleton instance
  static final CarRepositoryImpl instance = CarRepositoryImpl._();

  // Data storage
  List<CarModel> _allCars = [];
  Map<String, List<CarModel>> _modelsByBrand = {};
  Map<String, List<String>> _brandsByLetter = {};
  
  final CarService _carService = CarService();
  bool _isInitialized = false;

  // Initialize data (Lightweight: Brands only)
  Future<void> initialize() async {
    // If already initialized and has data, skip.
    // If initialized but empty, allow retry.
    if (_isInitialized && _brandsByLetter.isNotEmpty) return;

    try {
      print("CarRepository: Fetching brands from API...");
      final brands = await _carService.fetchBrands();
      print("CarRepository: Fetched ${brands.length} brands.");
      
      _organizeBrands(brands);
      
      // Optionally fetch first page of cars for carousel/initial list
      await fetchCarsPage(1);

      _isInitialized = true;
    } catch (e, stackTrace) {
      print("Error initializing CarRepository: $e");
      print(stackTrace);
    }
  }

  Future<List<CarModel>> fetchCarsPage(int page) async {
    try {
      final apiCars = await _carService.fetchCars(page: page, limit: 20);
      final newCars = apiCars.map((apiCar) {
        try {
          return _mapApiCarToDomain(apiCar);
        } catch (e) {
          print("CarRepository: Error mapping car ${apiCar.brand}: $e");
          return null;
        }
      }).whereType<CarModel>().toList();

      _allCars.addAll(newCars);
      
      for (var car in newCars) {
        if (!_modelsByBrand.containsKey(car.brand)) {
          _modelsByBrand[car.brand] = [];
        }
        // Avoid duplicates
        if (!_modelsByBrand[car.brand]!.any((c) => c.name == car.name)) {
           _modelsByBrand[car.brand]!.add(car);
        }
      }

      return newCars;
    } catch (e) {
      print("CarRepository: Error fetching page $page: $e");
      return [];
    }
  }

  Future<void> fetchModelsForBrand(String brand) async {
    // If we already have models for this brand, maybe we don't need to fetch?
    // But since we only fetch brands initially, _modelsByBrand[brand] might be empty or incomplete.
    // Let's fetch specifically for this brand.
    try {
      // Fetch a large number to get all models for this brand
      final apiCars = await _carService.fetchCars(page: 1, limit: 100, brand: brand);
      
      if (!_modelsByBrand.containsKey(brand)) {
        _modelsByBrand[brand] = [];
      }

      final domainCars = apiCars.map((apiCar) => _mapApiCarToDomain(apiCar)).toList();
      
      // Update the list, avoiding duplicates
      final existingNames = _modelsByBrand[brand]!.map((c) => c.name).toSet();
      for (var car in domainCars) {
        if (!existingNames.contains(car.name)) {
          _modelsByBrand[brand]!.add(car);
        }
      }
    } catch (e) {
      print("CarRepository: Error fetching models for brand $brand: $e");
    }
  }

  void _organizeBrands(List<String> brands) {
    _brandsByLetter = {};
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

  CarModel _mapApiCarToDomain(api.Car apiCar) {
    // Extract Model Name from URL
    String modelName = apiCar.sourceUrl.split('/').last;
    modelName = Uri.decodeComponent(modelName);
    String displayName = modelName.replaceAll('_', ' ');
    
    // Construct Asset Path
    // Matches the scraper's logic: assets/images/Brand/Model_Name.png
    // Note: Scraper uses clean_filename which removes special chars.
    // We'll try to match that.
    String cleanBrand = apiCar.brand.replaceAll(RegExp(r'[\\/*?:"<>|]'), "").trim();
    String cleanModel = modelName.replaceAll(RegExp(r'[\\/*?:"<>|]'), "").trim();
    
    // The scraper seems to have saved files with underscores if the URL had them.
    // Let's use the exact segment from URL as filename base if possible, 
    // but the scraper code used `clean_filename(model_name)`.
    // If model_name came from `url.split('/')[-1].replace('_', ' ')`, it has spaces.
    // So filename has spaces.
    // BUT user saw `Ferrari_Ferrari_SF90_Stradale.png`.
    // This implies the URL segment was `Ferrari_Ferrari_SF90_Stradale` and `replace` didn't happen or I'm confused.
    // Let's try to be robust: check both with spaces and underscores?
    // We can't check file existence easily here.
    // Let's stick to the most likely path: `assets/images/$cleanBrand/$cleanModel.png` (with spaces if modelName has spaces).
    // If the user says the file is `Ferrari_Ferrari_SF90_Stradale.png`, that has underscores.
    // So maybe I should NOT replace underscores in the filename construction?
    // Let's try to keep underscores for the filename if the URL has them.
    String filenameBase = apiCar.sourceUrl.split('/').last; // Keep underscores
    String filename = filenameBase.replaceAll(RegExp(r'[\\/*?:"<>|]'), "").trim();
    
    String assetPath = 'assets/images/$cleanBrand/$filename.png';

    return CarModel(
      name: displayName,
      brand: apiCar.brand,
      price: 'Price on Request',
      assetPath: assetPath,
      description: 'Experience the power of the $displayName. A masterpiece of engineering from ${apiCar.brand}.',
      power: apiCar.power,
      acceleration: 'N/A',
      topSpeed: 'N/A',
      torque: apiCar.torque,
      engine: apiCar.engine,
      displacement: 'N/A',
      drive: 'N/A',
      galleryImages: [],
      technicalData: [
        SpecificationGroup(
          title: 'Performance',
          specs: {
            'Power': apiCar.power,
            'Torque': apiCar.torque,
            'Weight': apiCar.weight,
          },
        ),
        SpecificationGroup(
          title: 'Engine',
          specs: {
            'Engine': apiCar.engine,
            'Year': apiCar.year,
          },
        ),
      ],
    );
  }

  // Public accessors
  @override
  List<CarModel> get carouselCars => _allCars.take(6).toList(); // Just take first 6 for carousel
  
  @override
  Map<String, List<CarModel>> get menuCars => _modelsByBrand; // Map to modelsByBrand
  
  @override
  List<CarModel> get allCars => _allCars;
  
  @override
  Map<String, List<String>> get brandsByLetter => _brandsByLetter;
  
  @override
  Map<String, List<CarModel>> get modelsByBrand => _modelsByBrand;

  @override
  CarModel? findCarByName(String name) {
    try {
      return allCars.firstWhere((car) => car.name == name);
    } catch (e) {
      return null;
    }
  }

  @override
  List<CarModel> searchCarsByName(String query) {
    if (query.isEmpty) {
      return [];
    }
    final lowerCaseQuery = query.toLowerCase();
    return allCars
        .where((car) => car.name.toLowerCase().contains(lowerCaseQuery))
        .toList();
  }
}
