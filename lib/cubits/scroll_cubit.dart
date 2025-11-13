import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollCubit extends Cubit<double> {
  // Initial state is 0.0 (top of the page)
  ScrollCubit() : super(0.0);

  // Method to update the scroll offset
  void updateScroll(double offset) => emit(offset);
}
