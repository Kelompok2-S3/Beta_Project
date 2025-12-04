import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'car_state.dart';

class CarCubit extends Cubit<CarState> {
  CarCubit() : super(CarInitial());
}
