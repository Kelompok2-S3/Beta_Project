import 'package:beta_project/domain/entities/car_model.dart';
import 'package:beta_project/domain/repositories/car_repository.dart';

class GetCarouselCars {
  final CarRepository repository;

  GetCarouselCars(this.repository);

  List<CarModel> call() {
    // Di sini Anda bisa menambahkan logika bisnis, misalnya menyaring atau mengurutkan
    // Untuk saat ini, kita hanya akan mengambil 4 mobil secara acak seperti di UI
    final cars = (repository.carouselCars.toList()..shuffle()).take(4).toList();
    return cars;
  }
}
