import 'package:beta_project/BaseData/car_data.dart';
import 'package:beta_project/models/car_model.dart';
import 'package:beta_project/widgets/car_model_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Wajib import ini

class CarCarousel extends StatelessWidget {
  const CarCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a shuffled list of cars and take the first 4
    final List<CarModel> cars = (carouselCars.toList()..shuffle()).take(4).toList();

    return SizedBox(
      height: 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            // GESTURE DETECTOR: Agar mobil bisa diklik
            child: GestureDetector(
              onTap: () {
                // Navigasi ke detail
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