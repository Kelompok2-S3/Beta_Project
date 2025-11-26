import 'package:beta_project/data/car_repository.dart';
import 'package:beta_project/models/car_model.dart';
import 'package:beta_project/widgets/car_model_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarCarousel extends StatelessWidget {
  const CarCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // Access cars from the repository
    final carRepository = CarRepository.instance;
    final List<CarModel> cars = (carRepository.carouselCars.toList()..shuffle()).take(4).toList();

    return SizedBox(
      height: 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: GestureDetector(
              onTap: () {
                final encodedName = Uri.encodeComponent(car.name);
                context.push('/car/$encodedName');
              },
              child: CarModelCard(model: car),
            ),
          );
        },
      ),
    );
  }
}
