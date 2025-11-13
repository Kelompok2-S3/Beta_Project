import 'package:flutter_bloc/flutter_bloc.dart';

class MenuCubit extends Cubit<bool> {
  MenuCubit() : super(false); // Initial state is false (menu is closed)

  void toggleMenu() => emit(!state);
}
