part of 'car_cubit.dart';

abstract class CarState extends Equatable {
  const CarState();

  @override
  List<Object> get props => [];
}

class CarInitial extends CarState {}
