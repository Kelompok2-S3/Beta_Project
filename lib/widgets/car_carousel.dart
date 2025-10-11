import 'package:beta_project/BaseData/car_data.dart';
import 'package:beta_project/models/car_model.dart';
import 'package:beta_project/widgets/car_model_card.dart';
import 'package:flutter/material.dart';

class CarCarousel extends StatelessWidget {
  const CarCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // Data is now fetched from the central car_data.dart file
    final List<CarModel> cars = carouselCars;

    return SizedBox(
      height: 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CarModelCard(model: cars[index]),
          );
        },
      ),
    );
  }
}
